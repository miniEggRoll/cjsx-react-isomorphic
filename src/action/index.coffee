util            = require "#{__dirname}/../util/index.cjsx"
{ActionType}    = require "#{__dirname}/../constant/index.coffee"

module.exports = (dispatcher, locale)->
    {
        navPage: ({country, page})->
            dispatcher.dispatch {
                type: ActionType.NAV_PAGE
                country: country
                page: page
                locale: locale
            }
        receiveRestaurant: (restaurant)->
            dispatcher.dispatch {
                type: ActionType.RECEIVE_RESTAURANT
                restaurant: restaurant
            }
        route: ->
            dispatcher.dispatch {
                type: ActionType.ROUTE
            }
    }
