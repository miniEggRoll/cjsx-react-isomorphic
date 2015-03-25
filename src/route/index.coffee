path = require 'path'
glob = require 'glob'

glob.sync "#{__dirname}/*"
.filter (fileName)-> fileName isnt __filename
.forEach (fileName)-> 
    baseName = path.basename fileName, path.extname(fileName)
    exports[baseName] = require fileName
