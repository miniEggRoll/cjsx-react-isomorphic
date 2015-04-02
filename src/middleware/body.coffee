_           = require 'underscore'
Mustache    = require 'mustache'
fs          = require 'fs'

render = (path, model)->
    (done)->
        fs.readFile path, {encoding: 'utf8'}, (err, index)->
            if err? then done err else done null, Mustache.render(index, model)


module.exports = ->
    (next)->
        {props, html} = @reactHTML
        @throw 404 unless props? and html?
        json = JSON.stringify props
        @body = yield render "#{__dirname}/../index.mustache", {html, json}
        yield next
