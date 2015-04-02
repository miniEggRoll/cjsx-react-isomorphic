debug       = require('debug')('iso:index')
koa         = require 'koa'
statics     = require 'koa-static'
body        = require "#{__dirname}/middleware/body"
locale      = require "#{__dirname}/middleware/locale"
model       = require "#{__dirname}/middleware/model"
reactHTML   = require "#{__dirname}/middleware/reactHTML"

app = koa()

app.use statics "#{__dirname}/../dist"
app.use locale('lang')
app.use model()
app.use reactHTML()
app.use body()

app.listen 8080, ->
    console.log 'listening on port 8080'
