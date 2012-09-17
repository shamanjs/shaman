module.exports = (tmpl, sandbox) -> 
  tmpl = tmpl.replace /#{([\w]+)}/g, (match, varname) -> 
    sandbox[varname]

