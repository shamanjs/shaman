module.exports = 
  (port, callback) ->
    tester = require("net").createServer()
    tester.once "error", (err) ->
      if err.code is "EADDRINUSE" then callback null, true
      else callback err
    tester.once "listening", ->
      tester.once "close", -> callback null, false
      tester.close()
    tester.listen port
