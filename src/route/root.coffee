module.exports = 
    method: 'get'
    path: '/'
    gen: (next)->
        @props = {test:'test'}
        yield next
