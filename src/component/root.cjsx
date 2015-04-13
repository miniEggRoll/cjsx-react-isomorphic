React       = require 'react'
Router      = require 'react-router'
App         = require "#{__dirname}/App.cjsx"

{Route, RouteHandler, Link} = Router

Root = React.createClass {
    _onChange: ->
        @setState @getInitialState()
    componentDidMount: ->
        @props.flux.store.appStore.addChangeListener @_onChange
        @props.flux.store.localeStore.addChangeListener @_onChange
    componentWillUnmount: ->
        @props.flux.store.appStore.removeChangeListener @_onChange
        @props.flux.store.localeStore.removeChangeListener @_onChange
    getInitialState: ->
        lang = do =>
            {page, country} = @props.params
            @props.flux.store.localeStore.getAll().map (locale)->
                params = {page, country}
                {locale, params}
        apps = @props.flux.store.appStore.getAll()
        {lang, apps}
    render: ->
        {lang, apps} = @state

        lang = lang.map ({params, locale})=>
            href = "?locale=#{locale}"
            component = <li key={locale} ><a href={href} >{locale}</a></li>

        <div>
            <nav className="navbar" role="navigation">
                <div className="container">
                    <div className="navbar-header">
                        <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#top-navbar-1">
                            <span className="sr-only">Toggle navigation</span>
                            <span className="icon-bar"></span>
                            <span className="icon-bar"></span>
                            <span className="icon-bar"></span>
                        </button>
                        <a className="navbar-brand" href="#">EZTABLE</a>
                    </div>
                    <div className="collapse navbar-collapse" id="top-navbar-1">
                        <ul className="nav navbar-nav navbar-right">
                            <li className="dropdown">
                                <a href="#" className="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000">
                                    <i className="fa fa-globe"></i><br/>language <span className="caret"></span>
                                </a>
                                <ul className="dropdown-menu dropdown-menu-left" role="menu">
                                    {lang}
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <RouteHandler {...this.props} />
        </div>
}

module.exports = Root
