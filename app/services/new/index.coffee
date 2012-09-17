require 'shelljs/global'
log         = require 'node-log'
getPaths    = require './getPaths'
getProfile  = require './getProfile'
clone       = require '../clone'

module.exports = (appName, jobs) -> 

  {appPath, shamanPath, templatePath} = getPaths appName
  profile = getProfile shamanPath
  profile.appName = appName

  ## create app

  mkdir '-p', appPath
  cd appPath
  pwd()
  clone templatePath, appPath, profile, (err) ->
    return log.error err if err? 
    profile.new(jobs)

  #if jobs? # then install and apply them

  log.info "#{appName} created"


  
  