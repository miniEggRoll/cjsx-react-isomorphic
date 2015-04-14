React = require 'react'
{routeHandler, wait} = require "#{__dirname}/util/index.coffee"
Dispatcher  = require "#{__dirname}/dispatcher/index.coffee"
{ActionType} = require "#{__dirname}/constant/index.coffee"

wrapper = document.getElementById 'wrapper'
{locale} = global

flux = Dispatcher {locale}
flux.dispatcher.register (action)->
    switch action.type
        when ActionType.ROUTE
            Handler = null
            state = null
            routeHandler()
            .then (params)->
                Handler = params.Handler
                state = params.state
                wait flux, state
            .then ->
                React.render <Handler {...state} flux={flux} />, wrapper
            .catch (e)->
                console.error e

flux.action.route()
