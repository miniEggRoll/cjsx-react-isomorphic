React   = require 'react'
Router  = require 'react-router'
RSVP    = require 'rsvp'
{wait, routeHandler}  = require "#{__dirname}/util/index.coffee"
Dispatcher      = require "#{__dirname}/dispatcher/index.coffee"
{ActionType}    = require "#{__dirname}/constant/index.coffee"
{Route}         = require "#{__dirname}/component/index.coffee"

wrapper = document.getElementById 'wrapper'
{locale} = global

flux = Dispatcher {locale, pageSize}
flux.dispatcher.register (action)->
    switch action.type
        when ActionType.ROUTE
            routeHandler {
                routes: Route
                location: Router.HistoryLocation
                onError: (err)-> console.error err
            }
            .then ({Handler, state, router, options})->
                if options?
                    router.transitionTo router.makePath(options.to, options.params, options.query)
                    flux.action.route() 
                else
                    wait(flux, state).then ->
                        React.render <Handler {...state} flux={flux} />, wrapper
            .catch (e)->
                console.error e

flux.action.route()
