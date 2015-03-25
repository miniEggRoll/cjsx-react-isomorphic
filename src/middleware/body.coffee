Mustache = require 'mustache'
fs       = require 'fs'

index = fs.readFileSync "#{__dirname}/../template/index.mustache", {encoding: 'utf8'}

module.exports = ->
    (next)->
        {props, reactHTML} = @
        json = JSON.stringify props
        @body = Mustache.render index, {reactHTML, json}
        yield next
