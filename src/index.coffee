debug       = require('debug')('iso:index')
koa         = require 'koa'
statics     = require 'koa-static'
cond        = require 'koa-conditional-get'
etag        = require 'koa-etag'
locale      = require "#{__dirname}/middleware/locale"
body        = require "#{__dirname}/middleware/body"
style       = require "#{__dirname}/middleware/style"
reactHTML   = require "#{__dirname}/middleware/reactHTML"

{PORT, MAX_SECONDS, SEGMENT} = process.env

PORT = 8080
MAX_SECONDS = 3600

app = koa()

app.use (next)->
    yield next
    @set 'Cache-Control', 'max-age=' + MAX_SECONDS if @method is 'GET'

app.use cond()
app.use etag()

app.use statics "#{__dirname}/../dist"
app.use locale 'locale'
app.use reactHTML()
app.use style()
app.use body SEGMENT

app.listen PORT, ->
    console.log "listening on port #{PORT}"
