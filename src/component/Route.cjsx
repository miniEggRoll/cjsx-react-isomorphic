React   = require 'react'
Router  = require 'react-router'

Root    = require "#{__dirname}/Root.cjsx"
Page    = require "#{__dirname}/Page.cjsx"
defaultR = require "#{__dirname}/defaultR.cjsx"
{Route, DefaultRoute} = Router

routes = 
    <Route name="root" path="/" handler={Root}>
        <Route name="page" path="restaurants/:country/:page" handler={Page} />
        <DefaultRoute name="restaurants-index" handler={defaultR}/>
    </Route>

module.exports = routes
