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
    'Earn 1-3% rebate from every reservation made with EZTABLE APP!'
]

back = ->
    global.window.history.back()

component = React.createClass {
    statics: 
        fetchData: (flux, state)->
            {id} = state.params
            locale = flux.locale
            getRestaurantById {id, locale}
            .then (data)=>
                flux.store.restaurantStore.addRestaurant data
                @track flux, state unless state._RUNTIME is 'nodejs'
        track: (flux, state)->
            {id} = state.params
            {name, country} = flux.store.restaurantStore.getRestaurant id
            global.analytics.track 'viewed_hack_seo_restaurant_page', {
                country: country
                restaurant_name: name
                restaurant_id: id
                hostname: 'restaurant.eztable.com'
            }
        tkd: (flux, state)->
            {id} = state.params
            {name, country, cuisine, intro1} = flux.store.restaurantStore.getRestaurant id
            cuisines = cuisine.type

            {
                t: "#{name} - EZTABLE 24hr online reservation"
                k: "#{name}, #{cuisines}"
                d: intro1
            }

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

        dictionary = store.localeStore.translate keys, locale

        {restaurant, locale, dictionary}
    render: ->
        {restaurant, locale, dictionary} = @state
        {
            cuisine
            name
            images
            highlight
            address
            transportation
            recommended_dishes
            url
            menu_url
            price
            intro1
            opening_meta
            services
            id
            promotions
        } = restaurant

        priceRange = price
        service = services
        opening = opening_meta
        cuisines = cuisine.type
        purpose = cuisine.suitable_purpose
        dishes = cuisine.recommended_dishes
        img = images.o

        {cash_rebate} = promotions
        rebate_title = cash_rebate.content
        rebate_info = cash_rebate.info

        menu = if menu_url then <a href={menu_url||'#'} className="link">{dictionary['Read Menu']}</a> else dictionary['Read Menu']
        website = if url then <a href={url} className="link">{dictionary['Visit Website']}</a> else dictionary['Visit Website']

        <div className="wrapper">
            <div className="header">
                <a onClick={back} className="nav-link">
                    <i className="fa fa-angle-left fa-2x nav-left-icon"></i>
                    <div className="icon-img"><img src="http://a4.mzstatic.com/us/r30/Purple3/v4/ea/0f/90/ea0f9016-46f0-ba7d-0f01-6d6447494ea7/icon175x175.jpeg" /></div>
                    <div className="nav-link-word">
                        <div className="app-link-title">EZTABLE</div>
                        <div className="app-link-subtitle">24hr Online Reservation</div>
                    </div>
                </a>
                <a href="http://www.eztable.com/app/?utm_source=seopage&utm_campaign=hkseogrowth&utm_medium=link&tracktype=tapstream" className="install-button">Install</a>
            </div>
            <section className="main-section">
                <img src={img} className="restaurant-img" />
                <h1 className="restaurant-name">{name}</h1>
                <div className="restaurant-highlight">"{highlight}"</div><a href="http://www.eztable.com/app/?utm_source=seopage&utm_campaign=hkseogrowth&utm_medium=link&tracktype=tapstream" className="booknow-button">{dictionary['Book Now']}</a>
            </section>
            <section className="detail-section">
                <h2 className="title">{dictionary.Location}</h2>
                <div className="detail-item">
                    <div className="subtitle">{dictionary.Address}</div>
                    <div className="content">{address}</div>
                </div>
                <div className="detail-item">
                    <div className="subtitle">{dictionary.Transportation}</div>
                    <div className="content">{transportation}</div>
                </div>
            </section>
            <section className="detail-section">
                <h2 className="title">{dictionary.Promotion}</h2>
                <div className="detail-item">
                    <div className="subtitle">{rebate_title}</div>
                    <div className="content">{rebate_info}</div>
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
                    <div className="content">{menu}</div>
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
                    <div className="content">{service}</div>
                </div>
                <div className="detail-item">
                    <div className="subtitle">{dictionary.Introduction}</div>
                    <div className="content">
                        {intro1}
                    </div>
                </div>
                <div className="detail-item">
                    <div className="subtitle">{dictionary.Website}</div>
                    <div className="content">{website}</div>
                </div>
            </section>
        </div>
}

module.exports = component
