_   = require 'underscore'

module.exports = (localeKey)->
    (next)->
        locale = @query[localeKey] or @cookies.get(localeKey) or 'en_US'
        @cookies.set localeKey, locale
        @localeSetting = {localeKey, locale}
        yield next
