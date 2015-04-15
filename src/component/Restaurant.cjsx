_               = require 'underscore'
React           = require 'react'

Restaurant = React.createClass {
    render: ->
        {id, name, intro1, images} = @props
        href = "/restaurant/#{id}"
        thumb = if images then images.w240 else ''
        <div className="col-sm-3">
            <a href={href} >
                <div className="work wow fadeInUp">
                    <div className="thumb" >
                        <img src={thumb} />
                    </div>
                    <h3 title={name} >{{name}}</h3>
                    <p title={intro1} >{{intro1}}</p>
                    <div className="work-bottom"></div>
                </div>
            </a>
        </div>
}

module.exports = Restaurant
