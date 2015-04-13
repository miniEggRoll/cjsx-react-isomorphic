_           = require 'underscore'
co          = require 'co'
React       = require 'react'
Router      = require 'react-router'
{Route}     = require "#{__dirname}/../component"
Dispatcher  = require "#{__dirname}/../dispatcher"
{routeHandler, wait}        = require "#{__dirname}/../util"

module.exports = ->
    (next)->
        {locale} = @
        {state, Handler} = yield routeHandler @path
        {country, page} = state.params
        flux = Dispatcher {locale}

        try
            {component} = yield wait flux, state, Handler, locale
        catch e
            console.log e.stack
            throw e

        html = React.renderToString component
        @reactHTML = {html}
        yield next
