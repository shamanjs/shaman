should      = load 'should'
{resolve}   = load 'path'
start       = load 'services.start'
paths       = load 'services.paths'
contract    = load 'test.app.contract'
isPortTaken = load 'services.util.isPortTaken'
module.exports =

  integration:
    "start new @agent with contract": ->
      isPortTaken 8080, (err, taken) ->
        if !taken
          contract.log = -> # mute log
          contract.web = port: 8080
          contract.paths = paths "#{app.paths.app}/test"
          @agent = start contract