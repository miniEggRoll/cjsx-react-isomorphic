React       = require 'react'
Router      = require 'react-router'
Dispatcher  = require "#{__dirname}/../dispatcher"
{routeHandler, wait} = require "#{__dirname}/../util"
{Route} = require "#{__dirname}/../component"

module.exports = ->
    (next)->
        {locale} = @
        flux = Dispatcher {locale}

        try
            {Handler, state} = yield (done)=>
                Router.run Route, @path, (Handler, state)->
                    state.params.page ?= 1
                    state.params.page = +state.params.page
                    done null, {Handler, state}
            yield wait flux, state
        catch e
            console.log e.stack
            throw e

        html = React.renderToString <Handler {...state} flux={flux} />

        @reactHTML = {html, routes: state.routes}
        yield next
