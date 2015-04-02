_       = require 'underscore'
React   = require 'react'

App = React.createClass {
    render: ->
        {src, href, style, target} = @props

        <div className="col-sm-6" >
            <div className="_work wow fadeInUp">
                <a href={href} target={target} style={style} >
                    <img src={src} alt="EZTABLE" data-at2x={src}/>
                </a>
            </div>
        </div>
}

module.exports = App
