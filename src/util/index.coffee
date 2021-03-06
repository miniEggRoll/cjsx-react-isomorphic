_           = require 'underscore'
url         = require 'url'
request     = require 'superagent'
RSVP        = require 'rsvp'
Router      = require 'react-router'

module.exports = 
    getRestaurantById: ({id, locale})->
        href = url.format 
            protocol: 'http'
            hostname: 'api.eztable.com'
            pathname: "/v3/app/eztable/restaurants/#{id}"
            query: 
                full: 1
                locale: locale

        new RSVP.Promise (resolve, reject)->
            request
            .get href
            .end (err, res)->
                if err? then reject err else resolve res.body

    getRestaurantByPage: ({country, page, locale, filter, pageSize})->
        href = url.format 
            protocol: 'http'
            port: 8087
            hostname: 'nodejs.eztable.com'
            pathname: '/search/+'
            query: 
                country: country
                full: 1
                locale: locale
                start: (page-1)*pageSize
                n: pageSize

        new RSVP.Promise (resolve, reject)->
            request
            .get href
            .end (err, res)->
                if err? then reject err else resolve res.body

    wait: (flux, state)->
        {routes} = state
        promises = routes.filter (r)->
            r.handler.fetchData
        .reduce (promises, route)->
            promises.push route.handler.fetchData(flux, state)
            promises
        , []
        RSVP.all promises

    routeHandler: ({routes, location})->
        new RSVP.Promise (resolve, onError)->
            onAbort = (options)->
                resolve {router, options}
            router = Router.create {routes, location, onAbort, onError}
            router.run (Handler, state)->
                state.params.country = 'th' unless state.params.country in ['th', 'hk']
                state.params.page ?= 1
                state.params.page = +state.params.page
                resolve {Handler, state, router}
