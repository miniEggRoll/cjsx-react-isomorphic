Action          = require "#{__dirname}/../action/index.coffee"
Store           = require "#{__dirname}/../store/index.coffee"
{Dispatcher}    = require 'flux'

module.exports = ({locale, pageSize, preloadOffset})->
    dispatcher = new Dispatcher()

    {
        pageSize: pageSize
        locale: locale
        dispatcher: dispatcher
        action: Action dispatcher, locale
        preloadOffset: preloadOffset
        store: 
            appStore: Store.appStore dispatcher
            localeStore: Store.localeStore dispatcher
            restaurantStore: Store.restaurantStore dispatcher, preloadOffset
            attrStore: Store.attrStore dispatcher
            countryStore: Store.countryStore dispatcher
    }
