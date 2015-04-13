http        = require 'http'
url         = require 'url'
request     = require 'superagent'
qs          = require 'querystring'
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
            try
                if path?
                    Router.run Route, path, (Handler, state)->
                        resolve {state, Handler}
                else
                    Router.run Route, Router.HistoryLocation, (Handler, state)->
                        resolve {Handler, state}
            catch e
                reject e

    wait: (flux, state, Handler, locale)->
        {store, action} = flux
        new RSVP.Promise (resolve, reject)->
            callback = ->
                store.restaurantStore.removeChangeListener callback
                resolve {component, Handler}
            store.restaurantStore.addChangeListener callback
            component = <Handler {...state} locale={locale} flux={flux} />
            action.navPage state.params
