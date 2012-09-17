mori = require 'mori'
_    = require 'underscore'
loadJob = require './loadJob'
async = require 'async'

module.exports = (agent) ->
  agent.jobs = mori.set ( agent.jobs or [] )
  # TODO break out to schema
  jobsMap =   
    models:   'archivist'
    archive:  'archivist'
    services: 'api'
    views:    'webapp'

  for key, job of jobsMap
    if agent[key]?
      agent.jobs = mori.conj agent.jobs, job
  agent.jobs = mori.into_array(agent.jobs)

  async.reduce agent.jobs, agent, loadJob, (err, agent) ->
    log.error "error with job #{err}" if err?
    return agent
