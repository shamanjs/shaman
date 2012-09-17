start = require './services/start'
clone = require './services/clone'
module.exports = 

  start: (contract, root) -> start contract, root
  clone: (src, dest, sandbox, next) -> clone src, dest, sandbox, next
