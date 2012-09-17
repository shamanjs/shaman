should   = load 'should'
start    = load 'services.start'
paths    = load 'services.paths'
contract = load 'test.app.contract'
module.exports =

  start:
    "start new @agent": ->
      contract.log = -> # mute log
      contract.web = port: 8105     
      contract.paths = paths "#{app.paths.app}/test"
      @agent = start contract
    'cleanup': ->
      @agent.web.server.close()
