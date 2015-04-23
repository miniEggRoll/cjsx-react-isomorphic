_               = require 'underscore'
{EventEmitter}  = require 'events'

util            = require "#{__dirname}/../util/index.coffee"
{ActionType}    = require "#{__dirname}/../constant/index.coffee"

CHANGE_EVENT = 'change'

mapper = ({information, cuisine, meta, location, detail, promotions, id})->
    {
        cuisine: cuisine
        name: information.name
        images: information.images[0]
        highlight: meta.highlight
        address: location.address
        transportation: location.transportation
        recommended_dishes: cuisine.recommended_dishes
        url: detail.url
        menu_url: cuisine.menu
        price: detail.price_range
        intro1: detail.intro1
        opening_meta: detail.opening_hours
        services: detail.services
        promotions: promotions
        id: id
        country: information.country
    }

class Store extends EventEmitter
    constructor: (@preloadOffset)->
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
        (@_pageDic[page] or []).map (id)=>
            @_restaurant[id]
    checkPageLoaded: (page)->
        ids = @_pageDic[page]
        return ids? and _.every ids, (id)=> @_restaurant[id]?
    addRestaurant: (data)->
        @_restaurant[data.id] = mapper data
    addRestaurantsByPage: (raw, page)->
        @_pageDic[page] = _.pluck raw, 'id'
        raw.forEach (r)=>
            @_restaurant[r.id] = mapper r
    cleanupRestaurant: (page)->
        {preloadOffset} = @
        previous = if page - preloadOffset > 0 then  @_pageDic.slice 0, page - preloadOffset else []
        after = @_pageDic.slice page + preloadOffset + 1

        _.chain previous.concat after
        .flatten()
        .each (id)=> delete @_restaurant[id]

module.exports = (dispatcher, preloadOffset)->
    store = new Store(preloadOffset)
    store
