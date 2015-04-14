url         = require 'url'
request     = require 'superagent'
RSVP        = require 'rsvp'
React       = require 'react'
Router      = require 'react-router'
{Route}     = require "#{__dirname}/../component/index.coffee"

module.exports = 
    getRestaurantByPage: ({country, start, locale})->
        href = url.format 
            protocol: 'http'
            hostname: 'api.eztable.com'
            pathname: '/v3/restaurants'
            query: 
                fq: "country:#{country}"
                locale: locale
                start: start

        new RSVP.Promise (resolve, reject)->
            request
            .get href
            .end (err, res)->
                if err? then reject err else resolve res.body.restaurants

    routeHandler: (path)->
        new RSVP.Promise (resolve, reject)->
            p = if path? then path else Router.HistoryLocation
            Router.run Route, p, (Handler, state)->
                resolve {Handler, state}
            
    wait: (flux, state)->
        {store, action} = flux
        new RSVP.Promise (resolve, reject)->
            callback = ->
                store.restaurantStore.removeChangeListener callback
                do resolve
            store.restaurantStore.addChangeListener callback
            action.navPage state.params
