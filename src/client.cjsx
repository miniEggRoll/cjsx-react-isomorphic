React = require 'react'
{routeHandler, wait} = require "#{__dirname}/util/index.cjsx"
Dispatcher  = require "#{__dirname}/dispatcher/index.coffee"
{ActionType} = require "#{__dirname}/constant/index.coffee"


wrapper = document.getElementById 'wrapper'
{locale} = global

flux = Dispatcher {locale}
flux.dispatcher.register (action)->
    switch action.type
        when ActionType.ROUTE
            routeHandler().then ({Handler, state})->
                wait flux, state, Handler, locale
            .then ({component})->
                React.render component, wrapper

flux.action.route()
