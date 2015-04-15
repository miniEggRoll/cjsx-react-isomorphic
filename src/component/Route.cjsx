React   = require 'react'
Router  = require 'react-router'

Root    = require "#{__dirname}/Root.cjsx"
List    = require "#{__dirname}/List.cjsx"
Detail    = require "#{__dirname}/Detail.cjsx"
RestaurantList    = require "#{__dirname}/RestaurantList.cjsx"

{Route, Redirect} = Router

routes = 
    <Route name="root" path="/" handler={Root} >
        <Route name="country" path="country/:country" handler={RestaurantList} >
            <Route name="list" path="page/:page" handler={List} />
        </Route>
        <Route name="detail" path="restaurant/:id" handler={Detail} />
    </Route>

module.exports = routes
