Action          = require "#{__dirname}/../action/index.coffee"
Store           = require "#{__dirname}/../store/index.coffee"
{Dispatcher}    = require 'flux'

module.exports = ({locale})->
    dispatcher = new Dispatcher()

    {
        locale: locale
        dispatcher: dispatcher
        action: Action dispatcher, locale
        store: 
            appStore: Store.appStore dispatcher
            localeStore: Store.localeStore dispatcher
            restaurantStore: Store.restaurantStore dispatcher
            attrStore: Store.attrStore dispatcher
            countryStore: Store.countryStore dispatcher
    }
