React       = require 'react'
Router      = require 'react-router'

{Route, RouteHandler, Link} = Router

Root = React.createClass {
    render: ->
        <div>
            <RouteHandler {...this.props} />  
        </div>
}

module.exports = Root
