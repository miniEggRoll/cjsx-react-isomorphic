React       = require 'react'
Router      = require 'react-router'
Dispatcher  = require "#{__dirname}/../dispatcher"
LRU         = require 'lru-cache'
co          = require 'co'
{Route}     = require "#{__dirname}/../component"
{wait, routeHandler}      = require "#{__dirname}/../util"

options = 
    max: 2000
    maxAge: 1000*60*60
    length: (n)-> n.length

cache = LRU options

module.exports = ->
    (next)->
        {locale} = @
        flux = Dispatcher {locale}
        key = @path + locale

        unless cache.has key
            try
                {Handler, state, options, router} = yield routeHandler {
                    routes: Route
                    location: @path
                }
            catch e
                console.log e.stack
                throw e

            return @redirect router.makePath(options.to, options.params, options.query) if options?
            
            state._RUNTIME = 'nodejs'
            try
                yield wait flux, state
            catch e
                console.log e.stack
                throw e

            html = React.renderToStaticMarkup <Handler {...state} flux={flux} />
            result = {html, routes: state.routes}
            cache.set key, result
        else 
            result = cache.get key

        @reactHTML = result
        yield next
