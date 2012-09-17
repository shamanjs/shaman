path        = require 'path'
fs          = require 'fs'
interpolate = require './interpolate'

# parse template, apply sandbox vars
module.exports = (src, dest, sandbox, file, next) -> 
  src  = path.join src, file
  dest = path.join dest, file
  fs.stat src, (err, stat) ->
    if stat.isDirectory()
      mkdir '-p', dest
      require('./index') src, dest, sandbox
      next()
    else
      fs.readFile src, (err, data) ->
        data = interpolate data.toString(), sandbox
        fs.writeFile dest, data, (err) -> 
          next log.error err if err?
          next()
