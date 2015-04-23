React       = require 'react'
Router      = require 'react-router'
Dispatcher  = require "#{__dirname}/../dispatcher"
LRU         = require 'lru-cache'
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
            
            {locale} = state.params
            flux = Dispatcher {locale, pageSize, preloadOffset: 0}

            try
                yield wait flux, state
            catch e
                console.error new Error('problem when fetching data')

            html = React.renderToStaticMarkup <Handler {...state} flux={flux} />
            result = {html, pageSize, routes: state.routes, flux, state}
            cache.set key, result
        else 
            result = cache.get key
            {locale} = result.flux

        @localeSetting = {locale}
        @reactHTML = result
        yield next
