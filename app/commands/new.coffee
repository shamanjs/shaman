require 'shelljs/global'
log = require 'node-log'
nu = require '../services/new'
module.exports = (cmd, [jobs, appName]) -> 

  # if no jobs specified, then it's just the app name
  if !appName? then appName = jobs; jobs = null
  return log.error "usage: shaman create [appName]" unless appName?

  log.info "creating #{ appName }..."

  nu appName, jobs

  ###
  {appPath, shamanPath, templatePath} = getPaths appName
  profile = getProfile shamanPath
  profile.appName = appName

  ## create app

  mkdir '-p', appPath
  cd appPath
  pwd()
  parseDir templatePath, appPath, profile, (err) ->
    return log.error err if err? 
    profile.new(jobs)

  #if jobs? # then install and apply them

  log.info "#{appName} created"


  
  
