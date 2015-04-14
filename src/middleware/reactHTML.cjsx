React       = require 'react'
Router      = require 'react-router'
Dispatcher  = require "#{__dirname}/../dispatcher"
{routeHandler, wait} = require "#{__dirname}/../util"

module.exports = ->
    (next)->
        {locale} = @
        flux = Dispatcher {locale}

        try
            {Handler, state} = yield routeHandler @path
            yield wait flux, state
        catch e
            console.log e.stack
            throw e

        html = React.renderToString <Handler {...state} flux={flux} />

        @reactHTML = {html}
        yield next
