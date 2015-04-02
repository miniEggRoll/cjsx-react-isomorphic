_               = require 'underscore'
React           = require 'react'

Restaurant = React.createClass {
    render: ->
        {name, intro, thumb} = @props

        <div className="col-sm-3">
            <div className="work wow fadeInUp">
                <div className="thumb" >
                    <img src={thumb} />
                </div>
                <h3 title={name} >{{name}}</h3>
                <p title={intro} >{{intro}}</p>
                <div className="work-bottom"></div>
            </div>
        </div>
}

module.exports = Restaurant
