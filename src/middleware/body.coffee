_           = require 'underscore'
Mustache    = require 'mustache'
fs          = require 'fs'

render = (path, model)->
    (done)->
        fs.readFile path, {encoding: 'utf8'}, (err, index)->
            if err? then done err else done null, Mustache.render(index, model)

module.exports = (segment)->
    (next)->
        {style, locale} = @
        {html} = @reactHTML
        @throw 404 unless html?
        @body = yield render "#{__dirname}/../index.mustache", {html, locale, style, segment}
        yield next
