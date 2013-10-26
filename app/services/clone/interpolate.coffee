ns2obj = require '../namespace/ns2obj'
module.exports = (tmpl, sandbox={}) -> 
  return "" unless tmpl
  #return unless sandbox  
  tmpl = tmpl?.replace /#{(.+?)}/g, (match, varname) -> 
    return ns2obj sandbox, varname if varname.indexOf('.') > -1
    return sandbox[varname]