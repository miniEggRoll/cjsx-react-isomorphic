_           = require 'underscore'
React       = require 'react'
Router      = require 'react-router'
RSVP        = require 'rsvp'
Restaurant  = require "#{__dirname}/Restaurant.cjsx"
{getRestaurantByPage}    = require "#{__dirname}/../util/index.coffee"

{Link} = Router

fetchRestaurant = ({country, locale, flux, page, pageSize})->
    if 0 >= page or flux.store.restaurantStore.checkPageLoaded page 
        new RSVP.Promise (resolve)->
            resolve false
    else 
        getRestaurantByPage {page, country, locale, pageSize}
        .then (raws)->
            flux.store.restaurantStore.addRestaurantsByPage raws, page
            true

keys = ['Our Restaurants']

Page = React.createClass {
    statics: 
        fetchData: (flux, state)->
            {pageSize, locale} = flux
            {page, country} = state.params
            promise = fetchRestaurant {country, locale, flux, page, pageSize}
            @preload flux, state
            @track flux, state
            promise
        track: (flux, state)->
            global.analytics?.track 'viewed_hack_seo_index_page', {
                country: state.params.country
                hostname:'restaurant.eztable.com'
            }
        preload: (flux, state)->
            {pageSize, locale, preloadOffset} = flux
            {page, country} = state.params

            RSVP.all _.range(page-preloadOffset-1, page-1).concat(_.range(page+1, page+preloadOffset+1)).map (p)->
                fetchRestaurant {country, locale, flux, page: p, pageSize}
            .then ->
                flux.store.restaurantStore.cleanupRestaurant page
            .catch (err)->
                console.error err
        tkd: (flux, state)->
            {
                t: 'EZTABLE 24hr online restaurant reservation'
                k: 'EZTABLE,App,restaurant,reservation'
                d: 'EZTABLE App is your 24hr personal dining manager, you can reserve over 3,000 fine-dining restaurants in Asia! Over 6,000,000 diners seated through EZTABLE, and creating millions of wonderful dining experience.'
            }
    contextTypes: {
        router: React.PropTypes.func
    }
    _onChange: ->
        @setState @getInitialState()
    componentDidMount: ->
        @props.flux.store.restaurantStore.addChangeListener @_onChange
    componentWillUnmount: ->
        @props.flux.store.restaurantStore.removeChangeListener @_onChange
    getInitialState: ->
        {params, flux} = @props
        {page, country} = params
        {locale} = flux
        dictionary = flux.store.localeStore.translate keys, flux.locale

        restInfo = flux.store.restaurantStore.getAllForPage page, country
        nextPage = {locale, country, page: page + 1}
        prevPage = {locale, country, page: page - 1}

        {nextPage, prevPage, restInfo, dictionary, locale}
    render: ->
        {nextPage, prevPage, restInfo, dictionary, locale} = @state
        restInfo = restInfo.map (r)->
            <Restaurant key={r.id} {...r} locale={locale} />

        nav = [prevPage, nextPage].map (params, idx)=>
            return if idx is 0 and params.page is 0
            arrow = if idx is 0 then '&larr;' else '&rarr;'
            to = 'list'
            href = @context.router.makePath to, params

            delegate = =>
                @context.router.transitionTo href
                @props.flux.action.route()
            <li key={href} ><Link to={to} params={params} onClick={delegate} ><span aria-hidden="true" dangerouslySetInnerHTML={{__html: arrow}}></span></Link></li>

        <div>
            <div className="row">
                <div className="col-sm-12 work-title wow fadeIn">
                    <h1>{dictionary['Our Restaurants']}</h1>
                </div>
            </div>
            <div className="row">
                {restInfo}
            </div>
            <div className="row">
                <nav>
                    <ul className="pager">
                        {nav}
                    </ul>
                </nav>
            </div>
        </div>
}

module.exports = Page
