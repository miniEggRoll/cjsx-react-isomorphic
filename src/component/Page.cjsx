React       = require 'react'
Router      = require 'react-router'
Restaurant  = require "#{__dirname}/Restaurant.cjsx"
action = require "#{__dirname}/../action/index.coffee"

{Route, RouteHandler, Link} = Router

Page = React.createClass {
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
        {page, country} = @props.params
        page = +page

        restInfo = @props.flux.store.restaurantStore.getAllForPage page, country
        nextPage = {country, page: page + 1}
        prevPage = {country, page: page - 1}

        {nextPage, prevPage, restInfo}

    render: ->
        {nextPage, prevPage, restInfo} = @state
        restInfo = restInfo.map (r)->
            <Restaurant key={r.id} {...r} />

        nav = [prevPage, nextPage].map (params, idx)=>
            to = 'page'
            delegate = =>
                href = @context.router.makePath to, params
                @context.router.transitionTo href
                @props.flux.action.route()
                false

            <li><Link to={to} params={params} onClick={delegate} >{params.page}</Link></li>

        <div className="work-container">
            <div className="container">
                <div className="row">
                    <div className="col-sm-12 work-title wow fadeIn">
                        <h2>Our Restaurants</h2>
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
        </div>
}

module.exports = Page
