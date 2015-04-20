React       = require 'react'
Router      = require 'react-router'
Dispatcher  = require "#{__dirname}/../dispatcher"
LRU         = require 'lru-cache'
co          = require 'co'
{Route}     = require "#{__dirname}/../component"
{wait, routeHandler}      = require "#{__dirname}/../util"

length = (n)-> 
    n.length

module.exports = (pageSize, max, maxAge)->
    cache = LRU {max, maxAge, length}

    (next)->
        key = @path

        unless cache.has key
            try
                {Handler, state, options, router} = yield routeHandler {
                    routes: Route
                    location: @path
                }
            catch e
                throw e

            return @redirect router.makePath(options.to, options.params, options.query) if options?
            
            state._RUNTIME = 'nodejs'
            {locale} = state.params
            flux = Dispatcher {locale, pageSize}

            try
                yield wait flux, state
            catch e
                throw e

            html = React.renderToStaticMarkup <Handler {...state} flux={flux} />
            result = {html, pageSize, routes: state.routes, flux, state}
            cache.set key, result
        else 
            result = cache.get key
            {locale} = result.flux

        @localeSetting = {locale}
        @reactHTML = result
        yield next
