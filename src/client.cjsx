Root    = require "#{__dirname}/component/root.cjsx"
React   = require 'react'

React.render <Root {...props} />, document.getElementById 'wrapper'
