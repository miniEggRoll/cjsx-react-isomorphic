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
{App, Restaurant, Root} = component

describe 'middleware', ->
    describe 'body', ->
        it 'render response body', (done)->
            template = '<p>hello world</p>'
            prop = {foo: 'bar'}
            app = koa()
            app.use (next)->
                @reactHTML = 
                    props: prop
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
                script = $('#props').html()
                assert.equal template, injected
                assert.match script, new RegExp("var props = #{JSON.stringify prop}")
                do done
        
        it 'throws if no props', (done)->
            template = '<p>hello world</p>'
            app = koa()
            app.use (next)->
                @reactHTML = 
                    html: template
                yield next
            app.use middleware.body()

            request(app.callback())
            .get '/'
            .expect 404, done

        it 'throws if no html', (done)->
            app = koa()
            props = {foo: 'bar'}
            app.use (next)->
                @reactHTML = {props}
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
                assert.isArray @locale.list
                assert.equal defaultLocale, @locale.selected
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
                assert.isArray @locale.list
                assert.equal locale, @locale.selected
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
                assert.isArray @locale.list
                assert.equal locale, @locale.selected
                yield next

            agent = request.agent app.callback()

            agent.get "/?#{localeKey}=#{locale}"
            .end ->
                agent.get '/'
                .expect 'Set-Cookie', new RegExp("#{localeKey}=#{locale}")
                .expect 404, done

    describe 'model', ->
        it 'route / to root', (done)->
            page = 3
            locale = {selected: 'test'}
            app = koa()
            app.use (next)->
                @locale = locale
                yield next
            app.use middleware.model()
            app.use (next)->
                assert.isObject @model
                assert.isArray @model.restaurants
                @model.restaurants.forEach (r)->
                    assert.isString r.country
                    assert.isString r.locale
                    assert.isString r.name
                    assert.isString r.intro
                    assert.isString r.thumb
                    assert.isNumber r.id
                    
                assert.equal locale, @model.locale
                assert.equal page, @model.page
                yield next

            request app.callback()
            .get "/?page=#{page}"
            .expect 404, done

    describe 'reactHTML', ->
        it 'render root component', (done)->
            pageSize = 20
            model = 
                restaurants: []
                locale: 
                    list: []
                    selected: 'en_US'
                page: 1
            app = koa()
            app.use (next)->
                @model = model
                yield next
            app.use middleware.reactHTML pageSize
            app.use (next)->
                assert.isObject @reactHTML
                assert.isString @reactHTML.html
                assert.deepEqual @reactHTML.props, _.extend({}, model, {pageSize})
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
        it 'successfully rendered', ->
            props = {}
            component = TestUtils.renderIntoDocument <Root {...props} />
            assert.ok TestUtils.isCompositeComponentWithType(component, Root)
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
