require 'shelljs/global'
log    = require 'node-log'
create = require '../services/create'

module.exports = (cmd, [jobs, appName]) -> 
  # if no jobs specified, then it's just the app name
  if !appName? then appName = jobs; jobs = null
  return log.error "usage: shaman create [appName]" unless appName?
  log.info "creating #{ appName }..."

  create appName, jobs