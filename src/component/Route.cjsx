_       = require 'underscore'
React   = require 'react'
Router  = require 'react-router'
Root    = require "#{__dirname}/Root.cjsx"
List    = require "#{__dirname}/List.cjsx"
Detail  = require "#{__dirname}/Detail.cjsx"
RestaurantList    = require "#{__dirname}/RestaurantList.cjsx"
{Route, Redirect} = Router

routes = do ->
    locale = 'en_US'
    country = 'th'

    defautlParam = {country, locale}
    
    <Route name="root" path="/" handler={Root} >
        <Route name="country" path="country/:country/locale/:locale" handler={RestaurantList} >
            <Route name="list" path="?:page?" handler={List} />
        </Route>
        <Route name="detail" path="restaurant/:id/?:locale?" handler={Detail} />
        <Redirect to="list" params={defautlParam} />
    </Route>

module.exports = routes
