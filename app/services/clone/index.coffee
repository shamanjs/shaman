async = require 'async'
fs    = require 'fs'
parse = require './parse'

module.exports = (src, dest, sandbox, next) ->

  fs.readdir src, (err, files) -> 
    next log.error "couldn't read #{src}: #{err}" if err?
    f = async.apply parse, src, dest, sandbox 
    async.forEach files, f, (next if next?)
