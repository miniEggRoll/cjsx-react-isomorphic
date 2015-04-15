React       = require 'react'
Router      = require 'react-router'
Restaurant  = require "#{__dirname}/Restaurant.cjsx"
action      = require "#{__dirname}/../action/index.coffee"
{getRestaurantByPage}    = require "#{__dirname}/../util/index.coffee"

{Link} = Router

keys = ['Our Restaurants']

Page = React.createClass {
    statics: 
        fetchData: (flux, state)->
            {locale} = flux
            {page, country} = state.params
            page = +page
            getRestaurantByPage {page, country, locale}
            .then (raws)->
                flux.store.restaurantStore.addRestaurantsByPage raws, page

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
        page = +page

        dictionary = flux.store.localeStore.translate keys, flux.locale

        restInfo = flux.store.restaurantStore.getAllForPage page, country
        nextPage = {country, page: page + 1}
        prevPage = {country, page: page - 1}

        {nextPage, prevPage, restInfo, dictionary}
    render: ->
        {nextPage, prevPage, restInfo, dictionary} = @state
        restInfo = restInfo.map (r)->
            <Restaurant key={r.id} {...r} />

        nav = [prevPage, nextPage].map (params, idx)=>
            to = 'list'
            href = @context.router.makePath to, params

            delegate = =>
                @context.router.transitionTo href
                @props.flux.action.route()

            <li key={href} ><Link to={to} params={params} onClick={delegate} >{params.page}</Link></li>

        <div>
            <div className="row">
                <div className="col-sm-12 work-title wow fadeIn">
                    <h2>{dictionary['Our Restaurants']}</h2>
                </div>
            </div>
            <div className="row">
                {restInfo}
            </div>
            <div className="row">
                <nav>
                    <ul className="pagination">
                        {nav}
                    </ul>
                </nav>
            </div>
        </div>
}

module.exports = Page
