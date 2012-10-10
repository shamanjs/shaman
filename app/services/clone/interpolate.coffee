ns2obj = require '../namespace/ns2obj'
module.exports = (tmpl, sandbox) -> 
  return new Error "shaman.interpolate: template required" unless tmpl
  return new Error "shaman.interpolate: sandbox required" unless sandbox  
  tmpl = tmpl?.replace /#{(.+?)}/g, (match, varname) -> 
    return ns2obj sandbox, varname if varname.indexOf('.') > -1
    return sandbox[varname]

