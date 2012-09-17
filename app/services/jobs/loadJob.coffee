npm = require 'npm'
log = require 'node-log'
_ = require 'underscore'
require 'shelljs/global'
req = (agent, job, next) ->
  try
    j = require("#{agent.paths.root}/node_modules/#{job}")
    next null, j
  catch e
    log.info "#{job} not installed, trying npm"
    npm.load ->
      npm.config.set 'loglevel', 'silent'
      npm.commands.install ["#{job}"], (err, data) ->
        if !err? then next()
        else
          log.info "#{job} not on npm, checking locally.."
          npm.commands.link job, (err, data) ->
            try 
              j = require("#{agent.paths.root}/node_modules/#{job}")
              next null, j
            catch e
              log.error e
              next()

module.exports = (agent, job, next) ->
  next() unless job
  job = "shaman-#{job}"
  req agent, job, (err, job) ->
    next() if err?
    next null, _.extend agent, job(agent)