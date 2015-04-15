React   = require 'react'
Router  = require 'react-router'
RSVP    = require 'rsvp'
{wait}  = require "#{__dirname}/util/index.coffee"
Dispatcher      = require "#{__dirname}/dispatcher/index.coffee"
{ActionType}    = require "#{__dirname}/constant/index.coffee"
{Route}         = require "#{__dirname}/component/index.coffee"

wrapper = document.getElementById 'wrapper'
{locale} = global

flux = Dispatcher {locale}
flux.dispatcher.register (action)->
    switch action.type
        when ActionType.ROUTE
            new RSVP.Promise (resolve, reject)->
                Router.run Route, Router.HistoryLocation, (Handler, state)->
                    resolve {Handler, state}
            .then ({Handler, state})->
                wait(flux, state).then ->
                    React.render <Handler {...state} flux={flux} />, wrapper
            .catch (e)->
                console.error e

flux.action.route()
