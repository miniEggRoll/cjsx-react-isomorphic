React       = require 'react'
Router      = require 'react-router'

{RouteHandler} = Router

Root = React.createClass {
    render: ->
        <div>
            <RouteHandler {...this.props} />  
        </div>
}

module.exports = Root
