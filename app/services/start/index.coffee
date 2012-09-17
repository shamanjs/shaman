log = require 'node-log'
module.exports = (agent, root) ->
  return log.error "shaman.start: missing root dir" unless root?
  agent ?= {}
  agent.log ?= console.log
  agent.paths = require('../paths')(root)
  #agent.load ?= require '../load'
  agent.write ?= (path, data) ->
    require('fs').writeFileSync "#{agent.paths.app}/#{path}", data
  agent.read ?= (path) ->
    require('fs').readFileSync "#{agent.paths.app}/#{path}"
  agent.log "starting agent '#{agent.name}'..."
  # extend agent with jobs
  agent = require('../jobs')(agent)
  