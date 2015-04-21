React           = require 'react'

Restaurant = React.createClass {
    contextTypes: {
        router: React.PropTypes.func
    }
    render: ->
        {id, name, intro1, images, locale} = @props
        href = @context.router.makePath 'detail', {locale, id}
        thumb = if images then images.o else ''
        <div className="col-sm-3">
            <a href={href} >
                <div className="work wow fadeInUp">
                    <div className="thumb" >
                        <img src={thumb} />
                    </div>
                    <h2 title={name} >{{name}}</h2>
                    <p title={intro1} >{{intro1}}</p>
                    <div className="work-bottom"></div>
                </div>
            </a>
        </div>
}

module.exports = Restaurant
