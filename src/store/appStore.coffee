_               = require 'underscore'
{EventEmitter}  = require 'events'

CHANGE_EVENT = 'change'

class Store extends EventEmitter
    constructor: ->
        @_app = {}
    emitChange: ->
        @emit CHANGE_EVENT
    addChangeListener: (cb)->
        this.on CHANGE_EVENT, cb
    removeChangeListener: (cb)->
        this.removeListener CHANGE_EVENT, cb
    getAll: ->
        _.toArray @_app
    addApp: (raw)->
        raw.forEach (r)=>
            @_app[r.key] = r
 
apps = [
    {
        key: 'ios'
        src: 'https://linkmaker.itunes.apple.com/htmlResources/assets/en_us//images/web/linkmaker/badge_appstore-lrg.svg'
        href: "https://itunes.apple.com/th/app/eztable-24hr-restaurant-reservation/id725489275?mt=8&uo=4"
        target: 'itunes_store'
        style: 
            display:'inline-block'
            overflow:'hidden'
            background: 'url(https://linkmaker.itunes.apple.com/htmlResources/assets/en_us//images/web/linkmaker/badge_appstore-lrg.png) no-repeat'
            width:'135px'
            height:'40px'
    }
    {
        key: 'android'
        src: 'https://developer.android.com/images/brand/en_generic_rgb_wo_45.png'
        href: "https://play.google.com/store/apps/developer?id=EZTABLE+Ltd.&hl=zh_TW"
        target: 'blank'
        style: {}
    }
]

module.exports = (dispatcher)->
    store = new Store()
    store.addApp apps
    store
