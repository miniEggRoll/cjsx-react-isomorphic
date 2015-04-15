_               = require 'underscore'
{EventEmitter}  = require 'events'

util            = require "#{__dirname}/../util/index.coffee"
{ActionType}    = require "#{__dirname}/../constant/index.coffee"

CHANGE_EVENT = 'change'

class Store extends EventEmitter
    constructor: ()->
        @_restaurant = {}
        @_pageDic = []
    emitChange: ->
        @emit CHANGE_EVENT
    addChangeListener: (cb)->
        this.on CHANGE_EVENT, cb
    removeChangeListener: (cb)->
        this.removeListener CHANGE_EVENT, cb
    getRestaurant: (id)->
        @_restaurant[id]
    getAllForPage: (page)->
        @_pageDic[page].map (id)=>
            @_restaurant[id]
    addRestaurant: (data)->
        @_restaurant[data.id] = data
    addRestaurantsByPage: (raw, page)->
        @_pageDic[page] = _.pluck raw, 'id'
        raw.forEach (r)=>
            @_restaurant[r.id] = r

module.exports = (dispatcher)->
    store = new Store()
    store
