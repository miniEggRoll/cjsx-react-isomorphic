_               = require 'underscore'
{EventEmitter}  = require 'events'

CHANGE_EVENT = 'change'

class Store extends EventEmitter
    constructor: ->
        @_country = {}
    emitChange: ->
        @emit CHANGE_EVENT
    addChangeListener: (cb)->
        this.on CHANGE_EVENT, cb
    removeChangeListener: (cb)->
        this.removeListener CHANGE_EVENT, cb
    getAll: ->
        _.chain(@_country)
        .toArray()
        .value()
    addCountry: (raw)->
        raw.forEach (r)=>
            @_country[r.key] = r

module.exports = (dispatcher)->
    store = new Store()
    store.addCountry countries
    store

localeName =
    en_US: 'English'
    th_TH: 'ภาษาไทย'
    zh_HK: '中文'

countries = [
    {
        key: 'th'
        locale: ['en_US', 'th_TH'].map (l)-> localeName[l]
        en_US: 'Thailand'
    }
    {
        key: 'hk'
        locale: ['en_US', 'zh_HK'].map (l)-> localeName[l]
        en_US: 'Hong Kong'
        name: '中文'
    }
]
