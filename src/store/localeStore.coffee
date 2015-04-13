_               = require 'underscore'
{EventEmitter}  = require 'events'

restaurant      = require "#{__dirname}/../restaurant.coffee"
locales = _.pluck restaurant, 'locale'

CHANGE_EVENT = 'change'

class Store extends EventEmitter
    constructor: ->
        @_locale = []
    emitChange: ->
        @emit CHANGE_EVENT
    addChangeListener: (cb)->
        this.on CHANGE_EVENT, cb
    removeChangeListener: (cb)->
        this.removeListener CHANGE_EVENT, cb
    getAll: ->
        @_locale.slice()
    addLocale: (raw)->
        @_locale = _.union @_locale, raw

module.exports = (dispatcher)->
    store = new Store()
    store.addLocale locales
    store
