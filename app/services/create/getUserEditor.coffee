module.exports = ->
  return process.env['EDITOR'] if process.env['EDITOR']?
  return 'nano'
