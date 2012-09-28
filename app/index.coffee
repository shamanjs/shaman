start = require './services/start'
clone = require './services/clone'
interpolate = require './services/clone/interpolate'

module.exports = 

  start: (contract, root) -> start contract, root
  clone: (src, dest, sandbox, next) -> clone src, dest, sandbox, next
  interpolate: (src, sandbox) -> interpolate src, sandbox