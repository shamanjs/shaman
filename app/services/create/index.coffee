require 'shelljs/global'
log         = require 'node-log'
getPaths     = require './getPaths'
getProfile   = require './getProfile'
cloneFromGit = require '../clone/cloneFromGit'

module.exports = (appName, jobs) -> 

  {appPath, shamanPath, templatePath} = getPaths appName
  profile = getProfile shamanPath
  profile.appName = appName

  ## create app

  mkdir '-p', appPath
  cd appPath
  pwd()
  cloneFromGit appPath, profile, (err) ->
    return log.error err if err? 
    log.info "creating #{appName}..."
    
    # run profile "new" config
    profile.new log, ->

      ## TODO: 

      # install jobs specified on cli from npm
      #npm.commands.install (jobs.map (job) -> "shaman-#{job}"), (err, data) ->
      #  return log.error err if err?
      #  log.info "#{appName} created"

      # save modules into npm file
  