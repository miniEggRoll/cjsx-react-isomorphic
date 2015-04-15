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
    translate: (keys, locale)->
        _.chain keys
        .map (k)->
            val = lookup k, locale
            [k, val]
        .object()
        .value()

module.exports = (dispatcher)->
    store = new Store()
    store.addLocale locales
    store

lookup = (key, locale)->
    lowerkey = key.toLowerCase()
    if dictionary[lowerkey]? and dictionary[lowerkey][locale]? then dictionary[lowerkey][locale] else key

dictionary = 
    location: 
        en_US: 'Location'
    address: 
        en_US: 'Address'
    transportation:
        en_US: 'Transportation'
    promotion: 
        en_US: 'Promotion'
    cuisine: 
        en_US: 'Cuisine'
    'suitable dining purpose':
        en_US: 'Suitable Dining Purpose'
    type: 
        en_US: 'Type'
    'recommended dishes':
        en_US: 'Recommended Dishes'
    menu: 
        en_US: 'Menu'
    'read menu':
        en_US: 'Read Menu'
    details:
        en_US: 'Details'
    'price range':
        en_US: 'Price Range'
    'open hour': 
        en_US: 'Open Hour'
    service:
        en_US: 'Service'
    introduction:
        en_US: 'Introduction'
    website:
        en_US: 'Website'
    'visit website':
        en_US: 'Visit Website'
    'book now':
        en_US: 'Book Now'
    'our restaurants':
        en_US: 'Our Restaurants'
