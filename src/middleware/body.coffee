_           = require 'underscore'
Mustache    = require 'mustache'
fs          = require 'fs'

render = (path, model)->
    (done)->
        fs.readFile path, {encoding: 'utf8'}, (err, index)->
            if err? then done err else done null, Mustache.render(index, model)

module.exports = (segment, preloadOffset)->
    (next)->
        {style} = @
        {html, pageSize} = @reactHTML
        {locale} = @localeSetting

        {t, d, k} = @tkd or {}

        @throw 404 unless html?
        @body = yield render "#{__dirname}/../index.mustache", {html, locale, style, segment, pageSize, preloadOffset, t, d, k}
        yield next
