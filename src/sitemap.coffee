require('node-cjsx/register');
fs = require 'fs'
util = require "#{__dirname}/util"
RSVP = require 'rsvp'
_ = require 'underscore'
js2xmlparser = require 'js2xmlparser'
routes = require "#{__dirname}/component/Route.cjsx"
Router = require 'react-router'
router = Router.create {
    routes: routes
    location: ''
}

countries =
    th: 
        count: 67
        l: ['th_TH', 'en_US']
    hk: 
        count: 73
        l: ['zh_HK', 'en_US']


country = 'th'
locale = 'en_US'
pageSize = 12
RSVP.all [1..67].map (page)->
    util.getRestaurantByPage {country, page, locale, pageSize}
.then (result)->
    _.chain result
    .flatten()
    .pluck 'id'
    .uniq()
    .value()
.then (arr)->
    list = _.chain countries
    .map ({count, l}, country)->
        _.map l, (locale)->
            _.map [1..count], (page)->
                router.makePath 'list', {page, locale, country}
    .flatten()
    .value()

    detail = _.chain arr
    .map (id)->
        _.map countries, ({l})->
            _.map l, (locale)->
                router.makePath 'detail', {id, locale}
    .flatten()
    .value()

    list.concat detail
.then (all)->
    result = 
        '@': 
            xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9'
        url: all.map (a)->
            {
                loc: "http://restaurant.eztable.com#{a}"
                priority: '1.000'
            }
    fs.writeFileSync "#{__dirname}/../dist/sitemap.xml", js2xmlparser('urlset', result)
.catch (err)->
    console.log err
