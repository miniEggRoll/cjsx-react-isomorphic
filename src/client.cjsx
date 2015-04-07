Root    = require "#{__dirname}/component/root.cjsx"
React   = require 'react'
$       = require 'jquery/dist/jquery.min'

React.render <Root {...props} />, document.getElementById 'wrapper'

$(document).on 'click', 'a.preventNav', -> false
