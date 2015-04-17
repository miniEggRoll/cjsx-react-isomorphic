_ = require 'underscore'

module.exports = ->
    (next)->
        {state, routes, flux} = @reactHTML

        tkd = _.filter routes, (r)->
            r.handler.tkd
        .map (r)->
            r.handler.tkd flux, state
        .pop()

        @tkd = tkd
        yield next
