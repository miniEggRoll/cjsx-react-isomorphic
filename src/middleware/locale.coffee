_           = require 'underscore'
restaurants = require "#{__dirname}/../restaurant.coffee"
list = _.chain(restaurants).pluck('locale').uniq().value()

module.exports = (key)->
    (next)->
        selected = @query[key] or @cookies.get(key) or 'en_US'
        @cookies.set key, selected
        @locale = {selected, list}
        yield next
