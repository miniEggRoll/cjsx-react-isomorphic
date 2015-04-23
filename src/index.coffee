koa         = require 'koa'
statics     = require 'koa-static'
cond        = require 'koa-conditional-get'
etag        = require 'koa-etag'
body        = require "#{__dirname}/middleware/body"
style       = require "#{__dirname}/middleware/style"
tkd         = require "#{__dirname}/middleware/tkd"
reactHTML   = require "#{__dirname}/middleware/reactHTML"

PORT = 8080
PRELOAD_OFFSET = 7
STATIC_PATH = "#{__dirname}/../dist"

{
    MAX_SECONDS
    SEGMENT
    PAGE_SIZE
    CACHE_MAX_LENGTH
    CACHE_MAX_AGE
} = process.env

app = koa()
app.use (next)->
    try
        yield next
    catch e
        @throw 500, e

app.use (next)->
    yield next
    @set 'Cache-Control', 'max-age=' + MAX_SECONDS if @method is 'GET'

app.use cond()
app.use etag()
app.use statics STATIC_PATH
app.use reactHTML PAGE_SIZE, CACHE_MAX_LENGTH, CACHE_MAX_AGE
app.use style()
app.use tkd()
app.use body(SEGMENT, PRELOAD_OFFSET)

app.listen PORT, ->
    console.log "listening on port #{PORT}"
