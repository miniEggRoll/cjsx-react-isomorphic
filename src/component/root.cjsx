_           = require 'underscore'
React       = require 'react'
App         = require "#{__dirname}/App.cjsx"
Restaurant  = require "#{__dirname}/Restaurant.cjsx"

apps = [
    {
        key: 'ios'
        src: 'https://linkmaker.itunes.apple.com/htmlResources/assets/en_us//images/web/linkmaker/badge_appstore-lrg.svg'
        href: "https://itunes.apple.com/th/app/eztable-24hr-restaurant-reservation/id725489275?mt=8&uo=4"
        target: 'itunes_store'
        style: 
            display:'inline-block'
            overflow:'hidden'
            background: 'url(https://linkmaker.itunes.apple.com/htmlResources/assets/en_us//images/web/linkmaker/badge_appstore-lrg.png) no-repeat'
            width:'135px'
            height:'40px'
    }
    {
        key: 'android'
        src: 'https://developer.android.com/images/brand/en_generic_rgb_wo_45.png'
        href: "https://play.google.com/store/apps/developer?id=EZTABLE+Ltd.&hl=zh_TW"
        target: 'blank'
        style: {}
    }
]

Root = React.createClass {
    componentWillReceiveProps: (props)->
        @setState @getInitialState.call {props}
    getInitialState: ->
        {restaurants, page, pageSize, locale} = @props
        pageCount = Math.ceil(restaurants.length/pageSize)
        restInfo = restaurants.slice pageSize*(page - 1), pageSize*page
        
        pagination = do =>
            [Math.max(page-5, 1)...Math.min(pageCount, page+5)].map (idx)->
                className = if idx is page then 'active' else ''
                href = "./?page=#{idx}"
                {idx, className, href}

        lang = do =>
            locale.list.map (l)->
                href = "./?lang=#{l}"
                {l, href}
        {restInfo, pagination, lang, pageCount}
    getDefaultProps: ->
        {
            restaurants: []
            page: 1
            pageSize: 20
            locale: 
                list: []
                selected: 'en_US'
        }
    gotoPage: (page = 1)->
        @setProps {page}
    nextPage: ->
        {pageCount} = @state
        {page, restaurants, pageSize} = @props
        @setProps {page: Math.floor(page + 1, pageCount)}
    previousPage: ->
        {page} = @props
        @setProps {page: (page - 1) or 1}
    render: ->
        {restInfo, pagination, lang, pageCount} = @state

        restInfo = restInfo.map (r)->
            <Restaurant key={r.id} {...r} />

        appLink = apps.map (a)->
            <App key={a.key} {...a} />

        pagination = pagination.map ({className, href, idx})=>
            click = =>
                @gotoPage idx
            <li className={className} onClick={click} key={idx} ><a className="preventNav" href={href}>{idx}</a></li>

        lang = lang.map ({href, l})->
            <li key={l} ><a href={href}>{l}</a></li>

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
                                <li onClick={this.previousPage} ><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                                {pagination}
                                <li onClick={this.nextPage} ><a href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>

            <div className="work-container">
                <div className="container">
                    <div className="row">
                        <div className="col-sm-12 work-title wow fadeIn">
                            <h2>Our Apps</h2>
                        </div>
                    </div>
                    <div className="row col-md-6 col-md-offset-3" >
                        {appLink}
                    </div>
                </div>
            </div>

            <footer>
                <div className="container">
                    <div className="row">
                        <div className="col-sm-3 footer-box wow fadeInUp">
                            <h4>About Us</h4>
                            <div className="footer-box-text">
                                <p>
                                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et. 
                                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et.
                                </p>
                                <p><a href="about.html">Read more...</a></p>
                            </div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-12 wow fadeIn">
                            <div className="footer-border"></div>
                        </div>
                    </div>
                    <div className="row">
                        <div className="col-sm-7 footer-copyright wow fadeIn">
                            <p>Copyright 2012 Andia - All rights reserved. Template by <a href="http://azmind.com">Azmind</a>.</p>
                        </div>
                        <div className="col-sm-5 footer-social wow fadeIn">
                            <a href="#"><i className="fa fa-facebook"></i></a>
                            <a href="#"><i className="fa fa-dribbble"></i></a>
                            <a href="#"><i className="fa fa-twitter"></i></a>
                            <a href="#"><i className="fa fa-pinterest"></i></a>
                        </div>
                    </div>
                </div>
            </footer>
        </div>
}

module.exports = Root
