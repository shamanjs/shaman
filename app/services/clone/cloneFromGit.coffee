require 'shelljs'
fs    = require 'fs' 
gift  = require 'gift'
clone = require './index'

module.exports = (dest, sandbox, next) ->

  # clone boilerplate to /var/tmp
  # TODO: fuck off windows
  # and clone

  tmp = "/tmp/shaman-boilerplate"

  if fs.existsSync tmp then rm '-rf', tmp

  gift.clone "git@github.com:shamanjs/shaman-boilerplate.git", tmp, (err, repo) ->
    clone tmp, dest, sandbox, next
