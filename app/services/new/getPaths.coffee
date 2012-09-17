path        = require 'path'
fs          = require 'fs'
log         = require 'node-log'
getUserHome = require './getUserHome'

module.exports = (appName) ->
 
  appPath = path.join process.cwd(), appName + "/"
  if (fs.existsSync appPath)
    log.error "#{appPath} already exists" 
    process.exit()
  # TODO: check if app exists on github
  shamanPath = path.join getUserHome(), 'shaman' 
  # TODO: support template overrides
  template = path.join __dirname, './template' 
  if !(fs.existsSync template)
    log.error "#{template} doesn't exist"  
    process.exit()

  appPath: appPath
  shamanPath: shamanPath
  templatePath: template