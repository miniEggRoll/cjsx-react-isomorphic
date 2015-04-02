_           = require 'underscore'
restaurant  = require "#{__dirname}/../restaurant.coffee"

module.exports = 
    method: 'get'
    path: '/'
    gen: (next)->
        {page} = @query
        {locale} = @
        restaurants = restaurant.filter (r)->
            r.locale is locale.selected
        @model = {restaurants, locale, page: +page or 1}
        yield next
