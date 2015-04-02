_       = require 'underscore'
Router  = require 'koa-router'
route   = require "#{__dirname}/../route"

module.exports = ->
    router = Router()
    _.map route, ({method, path, gen}, name)->
        router[method] name, path, gen
    router.routes()
