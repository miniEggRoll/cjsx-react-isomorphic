React   = require 'react'
root    = require "#{__dirname}/../component/root"

module.exports = ->
    (next)->
        {props} = @
        @reactHTML = React.renderToString React.createElement(root, props)
        yield next
