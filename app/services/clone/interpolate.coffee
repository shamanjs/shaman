module.exports = (tmpl, sandbox) -> 
  return new Error "shaman.interpolate: template not given" unless tmpl
  return new Error "shaman.interpolate: sandbox not given" unless sandbox
  tmpl = tmpl?.replace /#{([\w]+)}/g, (match, varname) -> 
    sandbox[varname]

