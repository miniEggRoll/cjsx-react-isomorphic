_       = require 'underscore'
React   = require 'react'
Router  = require 'react-router'

Root    = require "#{__dirname}/Root.cjsx"
Page    = require "#{__dirname}/Page.cjsx"

{Route, RouteHandler, Link} = Router

routes = 
    <Route name="root" path="/" handler={Root}>
        <Route name="page" path="/restaurants/:country/:page" handler={Page} />
    </Route>

module.exports = routes
