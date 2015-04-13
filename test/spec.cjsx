debug       = require('debug')('test')
_           = require 'underscore'
cheerio     = require 'cheerio'
jsdom       = require('jsdom').jsdom
{assert}    = require 'chai'
koa         = require 'koa'
request     = require 'supertest'
React       = require 'react/addons'
middleware  = require "#{__dirname}/../src/middleware"
restaurant  = require "#{__dirname}/../src/restaurant"
component   = require "#{__dirname}/../src/component"

{TestUtils} = React.addons
{App, Restaurant, Route} = component

describe 'middleware', ->
    describe 'body', ->
        it 'render response body', (done)->
            template = '<p>hello world</p>'
            app = koa()
            app.use (next)->
                @reactHTML = 
                    html: template
                yield next
            app.use middleware.body()

            request(app.callback())
            .get '/'
            .expect 'Content-Type', 'text/html; charset=utf-8'
            .expect 200
            .end (err, res)->
                $ = cheerio.load res.text
                injected = $('#wrapper').html()
                assert.equal template, injected
                do done

        it 'throws if no html', (done)->
            app = koa()
            app.use (next)->
                @reactHTML = {}
                yield next
            app.use middleware.body()

            request(app.callback())
            .get '/'
            .expect 404, done
            
    describe 'locale', ->
        it 'use en_US as default locale', (done)->
            defaultLocale = 'en_US'
            localeKey = 'lang'
            app = koa()
            app.use middleware.locale localeKey
            app.use (next)->
                assert.equal defaultLocale, @locale
                yield next

            request(app.callback())
            .get '/'
            .expect 'Set-Cookie', new RegExp("#{localeKey}=#{defaultLocale}")
            .expect 404, done

        it 'parse locale through url', (done)->
            locale = 'zh_TW'
            localeKey = 'lang'
            app = koa()
            app.use middleware.locale localeKey
            app.use (next)->
                assert.equal locale, @locale
                yield next

            request(app.callback())
            .get "/?#{localeKey}=#{locale}"
            .expect 'Set-Cookie', new RegExp("#{localeKey}=#{locale}")
            .expect 404, done

        it 'parse locale through cookies', (done)->
            locale = 'zh_TW'
            localeKey = 'lang'
            app = koa()
            app.use middleware.locale localeKey
            app.use (next)->
                assert.equal locale, @locale
                yield next

            agent = request.agent app.callback()

            agent.get "/?#{localeKey}=#{locale}"
            .end ->
                agent.get '/'
                .expect 'Set-Cookie', new RegExp("#{localeKey}=#{locale}")
                .expect 404, done

    describe 'reactHTML', ->
        it 'render root component', (done)->
            app = koa()
            app.use middleware.reactHTML()
            app.use (next)->
                assert.isObject @reactHTML
                assert.isString @reactHTML.html
                yield next

            request(app.callback())
            .get '/'
            .expect 404, done

describe 'restaurants', ->
    it 'fixture', ->
        restaurant.forEach ({id, country, locale, name, intro, thumb})->
            assert.isString country
            assert.isString locale
            assert.isNotNull name
            assert.isNotNull intro
            assert.isString thumb
            assert.isNumber id

describe 'component', ->
    global.document = jsdom '<html><head></head><body></body></html>'
    global.window = document.defaultView
    global.navigator = global.window.navigator

    describe 'root', ->
        # it 'successfully rendered', ->
        #     props = {}
        #     component = TestUtils.renderIntoDocument <Route {...props} />
        #     assert.ok TestUtils.isCompositeComponentWithType(component, Route)
    describe 'app', ->
        it 'successfully rendered', ->
            props = {}
            component = TestUtils.renderIntoDocument <App {...props} />
            assert.ok TestUtils.isCompositeComponentWithType(component, App)

    describe 'restaurant', ->
        it 'successfully rendered', ->
            props = {}
            component = TestUtils.renderIntoDocument <Restaurant {...props} />
            assert.ok TestUtils.isCompositeComponentWithType(component, Restaurant)
