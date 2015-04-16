_           = require 'underscore'
url         = require 'url'
request     = require 'superagent'
RSVP        = require 'rsvp'
Router      = require 'react-router'

pageSize = 8

module.exports = 
    getRestaurantById: ({id, locale})->
        href = url.format 
            protocol: 'http'
            hostname: 'api.eztable.com'
            pathname: '/v3/restaurants'
            query: 
                fq: "id:#{id}"
                locale: locale
                start: 0

        new RSVP.Promise (resolve, reject)->
            request
            .get href
            .end (err, res)->
                if err? then reject err else resolve res.body.restaurants[0]

    getRestaurantByPage: ({country, page, locale, filter})->
        reqCount = Math.floor(pageSize/10) + 1

        promises = _.chain reqCount
        .range()
        .map (idx)->
            start = (page-1)*pageSize + 10*idx
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
        .value()

        RSVP.all promises
        .then (res)->
            res.reduce (memo, r)->
                memo.concat r
            , []
            .slice 0, pageSize

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
                state.params.page ?= 1
                state.params.page = +state.params.page
                resolve {Handler, state, router}
