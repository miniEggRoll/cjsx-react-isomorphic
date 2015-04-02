_           = require 'underscore'
React       = require 'react'
rootPath    = "#{__dirname}/../component"

module.exports = (pageSize = 20)->
    (next)->
        {Root} = require rootPath
        {model} = @
        props = _.extend {}, model, {pageSize}
        html = React.renderToString React.createElement(Root, props)
        @reactHTML = {props, html}
        yield next
