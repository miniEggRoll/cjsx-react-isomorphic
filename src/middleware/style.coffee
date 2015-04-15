_ = require 'underscore'

detail = """
<link href="/assets/css/hack_restaurant.css" rel="stylesheet" type="text/css">
<link href="http://fonts.googleapis.com/css?family=Roboto:400,500,700,300,100" rel="stylesheet" type="text/css">
<link href="http://netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
"""

country = """
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,400">
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Droid+Sans">
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Lobster">
<link rel="stylesheet" href="/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/assets/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="/assets/css/animate.css">
<link rel="stylesheet" href="/assets/css/magnific-popup.css">
<link rel="stylesheet" href="/assets/flexslider/flexslider.css">
<link rel="stylesheet" href="/assets/css/form-elements.css">
<link rel="stylesheet" href="/assets/css/style.css">
<link rel="stylesheet" href="/assets/css/media-queries.css">
"""

module.exports = ->
    (next)->
        style = country if _.findWhere @reactHTML.routes, {name: 'country'}
        style = detail if _.findWhere @reactHTML.routes, {name: 'detail'}
        style = country unless style?

        @style = style
        yield next
