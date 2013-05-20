module.exports = ->
  return process.env['USERPROFILE'] if process.platform is 'win32'
  return process.env['HOME']
