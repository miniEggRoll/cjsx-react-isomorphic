React       = require 'react'
Router      = require 'react-router'

{Link, RouteHandler} = Router

Root = React.createClass {
    contextTypes: {
        router: React.PropTypes.func
    }
    _onChange: ->
        @setState @getInitialState()
    componentDidMount: ->
        @props.flux.store.appStore.addChangeListener @_onChange
        @props.flux.store.localeStore.addChangeListener @_onChange
        @props.flux.store.countryStore.addChangeListener @_onChange
    componentWillUnmount: ->
        @props.flux.store.appStore.removeChangeListener @_onChange
        @props.flux.store.localeStore.removeChangeListener @_onChange
        @props.flux.store.countryStore.removeChangeListener @_onChange
    getInitialState: ->
        {flux, params} = @props
        country = flux.store.countryStore.getAll()

        lang = country.filter(({key})-> 
            key is params.country
        )[0].locale
        .map (locale)->
            {locale}

        apps = flux.store.appStore.getAll()
        {lang, apps, country}
    render: ->
        {lang, apps, country} = @state

        lang = lang.map ({locale})=>
            href = "?locale=#{locale}"
            <li key={locale} ><a href={href} >{locale}</a></li>
        country = country.map ({key, en_US})=>
            href = @context.router.makePath 'country', {country: key}, {locale: 'en_US'}
            <li key={key} ><a href={href} >{en_US}</a></li>

        gohome = =>
            @context.router.transitionTo '/'
            @props.flux.action.route()

        <div className="restaurantList" >
            <nav className="navbar" role="navigation">
                <div className="container">
                    <div className="navbar-header">
                        <button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#top-navbar-1">
                            <span className="sr-only">Toggle navigation</span>
                            <span className="icon-bar"></span>
                            <span className="icon-bar"></span>
                            <span className="icon-bar"></span>
                        </button>
                        <Link className="navbar-brand" to='/' onClick={gohome} >EZTABLE</Link>
                    </div>
                    <div className="collapse navbar-collapse" id="top-navbar-1">
                        <ul className="nav navbar-nav navbar-right">
                            <li className="dropdown">
                                <a href="#" className="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000">
                                    <i className="fa fa-globe"></i><br/>country <span className="caret"></span>
                                </a>
                                <ul className="dropdown-menu dropdown-menu-left" role="menu">
                                    {country}
                                </ul>
                            </li>
                        </ul>
                        <ul className="nav navbar-nav navbar-right">
                            <li className="dropdown">
                                <a href="#" className="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000">
                                    <i className="fa fa-language"></i><br/>language <span className="caret"></span>
                                </a>
                                <ul className="dropdown-menu dropdown-menu-left" role="menu">
                                    {lang}
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <div className="work-container">
                <div className="container">
                    <RouteHandler {...this.props} />  
                </div>
            </div>
        </div>
}

module.exports = Root
