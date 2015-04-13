_               = require 'underscore'
{EventEmitter}  = require 'events'

util            = require "#{__dirname}/../util/index.cjsx"
{ActionType}    = require "#{__dirname}/../constant/index.coffee"

CHANGE_EVENT = 'change'
pageSize = 10

class Store extends EventEmitter
    constructor: ()->
        @_restaurant = []
    emitChange: ->
        @emit CHANGE_EVENT
    addChangeListener: (cb)->
        this.on CHANGE_EVENT, cb
    removeChangeListener: (cb)->
        this.removeListener CHANGE_EVENT, cb
    getAllForPage: (page)->
        @_restaurant.slice pageSize*(page - 1), pageSize*page
    addRestaurants: (raw, page)->
        raw.forEach (r, idx)=>
            @_restaurant[pageSize*(page-1)+idx] = r

module.exports = (dispatcher)->
    store = new Store()
    store.dispatchToken = dispatcher.register (action)->
        switch action.type
            when ActionType.NAV_PAGE
                {page, country, locale} = action
                start = pageSize*(page - 1)
                util.getRestaurantByPage {start, country, locale}
                .then (raws)->
                    store.addRestaurants raws, page
                    do store.emitChange
    store
