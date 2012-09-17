log = require 'node-log'

module.exports = (shamanPath) -> 
  
  try
    # grab first profile (default)
    return require("#{shamanPath}/profile").default
  catch e
    #console.log e
    log.error "#{shamanPath}/profile.coffee doesn't exist"
    process.exit()
    #return log.error "create now? [y/n]" 
    #mkdir '#{getUserHome()}/shaman'
