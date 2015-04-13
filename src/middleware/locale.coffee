_   = require 'underscore'

module.exports = (key)->
    (next)->
        selected = @query[key] or @cookies.get(key) or 'en_US'
        @cookies.set key, selected
        @locale = selected
        yield next
