debug       = require('debug')('iso:index')
koa         = require 'koa'
statics     = require 'koa-static'
body        = require "#{__dirname}/middleware/body"
props       = require "#{__dirname}/middleware/props"
reactHTML   = require "#{__dirname}/middleware/reactHTML"

app = koa()

app.use statics "#{__dirname}/../dist"
app.use props()
app.use reactHTML()
app.use body()

app.listen 8080, ->
    debug 'listening on port 8080'
