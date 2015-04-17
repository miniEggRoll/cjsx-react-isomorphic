debug       = require('debug')('iso:index')
koa         = require 'koa'
statics     = require 'koa-static'
cond        = require 'koa-conditional-get'
etag        = require 'koa-etag'
locale      = require "#{__dirname}/middleware/locale"
body        = require "#{__dirname}/middleware/body"
style       = require "#{__dirname}/middleware/style"
tkd       = require "#{__dirname}/middleware/tkd"
reactHTML   = require "#{__dirname}/middleware/reactHTML"

{MAX_SECONDS, SEGMENT, PAGE_SIZE} = process.env

PORT = 8080

app = koa()
# app.use (next)->
#     try
#         yield next
#     catch e
#         console.error e

app.use (next)->
    yield next
    @set 'Cache-Control', 'max-age=' + MAX_SECONDS if @method is 'GET'
app.use cond()
app.use etag()
app.use statics "#{__dirname}/../dist"
app.use locale '_locale'
app.use reactHTML PAGE_SIZE
app.use style()
app.use tkd()
app.use body SEGMENT

app.listen PORT, ->
    console.log "listening on port #{PORT}"
