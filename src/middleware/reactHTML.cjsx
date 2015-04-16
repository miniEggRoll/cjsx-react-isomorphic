React       = require 'react'
Router      = require 'react-router'
Dispatcher  = require "#{__dirname}/../dispatcher"
co          = require 'co'
{Route}     = require "#{__dirname}/../component"
{wait, routeHandler}      = require "#{__dirname}/../util"

module.exports = ->
    (next)->
        {locale} = @
        flux = Dispatcher {locale}

        try
            {Handler, state, options, router} = yield routeHandler {
                routes: Route
                location: @path
            }
        catch e
            console.log e.stack
            throw e

        return @redirect router.makePath(options.to, options.params, options.query) if options?
        
        try
            yield wait flux, state
        catch e
            console.log e.stack
            throw e

        html = React.renderToString <Handler {...state} flux={flux} />

        @reactHTML = {html, routes: state.routes}
        yield next
