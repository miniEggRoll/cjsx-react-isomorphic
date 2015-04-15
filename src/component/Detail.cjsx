_       = require 'underscore'
React   = require 'react'
{getRestaurantById}    = require "#{__dirname}/../util/index.coffee"

keys = [
    'Location'
    'Address'
    'Transportation'
    'Promotion'
    'Cuisine'
    'Suitable Dining Purpose'
    'Type'
    'Recommended Dishes'
    'Menu'
    'Read Menu'
    'Details'
    'Price Range'
    'Open Hour'
    'Service'
    'Introduction'
    'Website'
    'Visit Website'
    'Book Now'
]

component = React.createClass {
    statics: 
        fetchData: (flux, state)->
            {id} = state.params
            locale = flux.locale
            getRestaurantById {id, locale}
            .then (data)->
                flux.store.restaurantStore.addRestaurant data
    _onChange: ->
        @setState @getInitialState()
    componentDidMount: ->
        @props.flux.store.restaurantStore.addChangeListener @_onChange
    componentWillUnmount: ->
        @props.flux.store.restaurantStore.removeChangeListener @_onChange
    getInitialState: ->
        {flux, params} = @props
        {locale, store} = flux

        restaurant = store.restaurantStore.getRestaurant params.id
        attrs = restaurant.cuisine_category.map (c)=>
            store.attrStore.getAttr c

        dictionary = store.localeStore.translate keys, locale

        cuisines = _.chain attrs
        .where {category:'Cuisine Type'}
        .pluck locale
        .value()

        purpose = _.chain attrs
        .where {category:'Suitable Purpose'}
        .pluck locale
        .value()

        service = _.filter {
            is_accept_credit_card: 'Accept Credit Cards Payment'
            has_parking: 'Parking Space'
            has_wifi: 'Wi-Fi'
        }, (str, key)-> 
            restaurant[key]

        {restaurant, cuisines, purpose, service, locale, dictionary}
    render: ->
        {restaurant, cuisines, purpose, service, locale, dictionary} = @state
        {
            name
            images
            highlight
            address
            transportation
            recommended_dishes
            url
            menu_url
            min_price
            max_price
            intro1
            promotion
            promotion_title
            opening_meta
            is_accept_credit_card
            is_wheelchair_accessible
            has_parking
            has_wifi
        } = restaurant

        priceRange = "#{min_price} ~ #{max_price}"
        img = images.w240
        service = service.join ', '
        cuisines = cuisines.join ', '
        purpose = purpose.join ', '
        dishes = recommended_dishes.map (d)->
            "- #{d}"
        .join '</br>'

        opening = _.map opening_meta, (arr, key)->
            str = _.chain(arr)
            .map ({days, start, end})->
                "#{days}  #{start} - #{end}"
            .unshift "[#{key}]"
            .join '</br>'
        .join '</br></br>'

        <div className="wrapper">
            <div className="header"><a href="http://www.eztable.com" className="nav-link"><i className="fa fa-angle-left fa-2x nav-left-icon"></i>
                <div className="icon-img"><img src="http://a4.mzstatic.com/us/r30/Purple3/v4/ea/0f/90/ea0f9016-46f0-ba7d-0f01-6d6447494ea7/icon175x175.jpeg" /></div>
                <div className="nav-link-word">
                    <div className="app-link-title">EZTABLE</div>
                    <div className="app-link-subtitle">24hr Online Reservation</div>
                </div></a><a href="http://www.eztable.com/app/?utm_source=seopage&amp;utm_campaign=hkseogrowth&amp;utm_medium=link&amp;tracktype=tapstream" className="install-button">Install</a>
            </div>
            <section className="main-section">
                <img src={img} className="restaurant-img" />
                <h1 className="restaurant-name">{name}</h1>
                <div className="restaurant-highlight">"{highlight}"</div><a href="http://www.eztable.com/app/?utm_source=seopage&amp;utm_campaign=hkseogrowth&amp;utm_medium=link&amp;tracktype=tapstream" className="booknow-button">{dictionary['Book Now']}</a>
            </section>
            <section className="detail-section">
                <h2 className="title">{dictionary.Location}</h2>
                <div className="detail-item">
                    <div className="subtitle">{dictionary.Address}</div>
                    <div className="content"><a href="http://www.eztable.com" className="link">{address}</a></div>
                </div>
                <div className="detail-item">
                    <div className="subtitle">{dictionary.Transportation}</div>
                    <div className="content">{transportation}</div>
                </div>
            </section>
            <section className="detail-section">
                <h2 className="title">{dictionary.Promotion}</h2>
                <div className="detail-item">
                    <div className="subtitle">{promotion_title}</div>
                    <div className="content">{promotion}</div>
                </div>
            </section>
            <section className="detail-section">
                <h2 className="title">{dictionary.Cuisine}</h2>
                <div className="detail-item">
                    <div className="subtitle">{dictionary['Suitable Dining Purpose']}</div>
                    <div className="content">{purpose}</div>
                </div>
                <div className="detail-item">
                    <div className="subtitle">{dictionary['Type']}</div>
                    <div className="content">{cuisines}</div>
                </div>
                <div className="detail-item">
                    <div className="subtitle">{dictionary['Recommended Dishes']}</div>
                    <div className="content" dangerouslySetInnerHTML={__html: dishes}></div>
                </div>
                <div className="detail-item">
                    <div className="subtitle">{dictionary['Menu']}</div>
                    <div className="content"><a href={menu_url} className="link">{dictionary['Read Menu']}</a></div>
                </div>
            </section>
            <section className="detail-section">
                <h2 className="title">{dictionary['Details']}</h2>
                <div className="detail-item">
                    <div className="subtitle">{dictionary['Price Range']}</div>
                    <div className="content">{priceRange}</div>
                </div>
                <div className="detail-item">
                    <div className="subtitle">{dictionary['Open Hour']}</div>
                    <div className="content" dangerouslySetInnerHTML={__html:opening} ></div>
                </div>
                <div className="detail-item">
                    <div className="subtitle">{dictionary.Service}</div>
                    <div className="content">{dictionary.service}</div>
                </div>
                <div className="detail-item">
                    <div className="subtitle">{dictionary.Introduction}</div>
                    <div className="content">
                        {intro1}
                    </div>
                </div>
                <div className="detail-item">
                    <div className="subtitle">{dictionary.Website}</div>
                    <div className="content"><a href={url} className="link">{dictionary['Visit Website']}</a></div>
                </div>
            </section>
        </div>
}

module.exports = component
