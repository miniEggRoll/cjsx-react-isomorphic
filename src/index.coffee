debug       = require('debug')('iso:index')
koa         = require 'koa'
statics     = require 'koa-static'
locale      = require "#{__dirname}/middleware/locale"
body        = require "#{__dirname}/middleware/body"
reactHTML   = require "#{__dirname}/middleware/reactHTML"

app = koa()

app.use statics "#{__dirname}/../dist"
app.use locale 'locale'
app.use reactHTML()
app.use body()

app.listen 8080, ->
    console.log 'listening on port 8080'
