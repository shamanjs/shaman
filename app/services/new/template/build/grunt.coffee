coffee     = require 'coffee-script'
Mocha      = require 'mocha'
require './globals'
path = require 'path'

gruntConfig =
  pkg: "<json:package.json>"
  simplemocha: 
    all:
      src: ["#{app.paths.app}/**/*.spec.coffee"]
      options: 
        reporter:    'spec'
        ui:          'exports'
        ignoreLeaks: 'true'
  contract:
    files: "#{app.paths.app}/**/contract.coffee"
  coffee:
    app:
      src: [ "#{app.paths.client}/js/*.coffee" ]
      dest:  "#{app.paths.public}/js"
      options:
        bare: true
    services:
      src: [ "#{app.paths.app}/views/**/*.coffee" ]
      dest:  "#{app.paths.public}/js/routes"
      options:
        bare: true
    vendor:
      src: [ "#{app.paths.client}/js/vendor/*.coffee" ]
      dest:  "#{app.paths.public}/js/vendor"
      options:
        bare: true
  jaded:
    app:
      src: [ "#{app.paths.app}/views/**/*.jade" ]
      dest:  "#{app.paths.public}/templates"
      options:
        amd: true
        development: false
        rivets: true
  # dest: src 
  copy:
    dist: 
      files: 
        "build/webapp/public/js/vendor/": "#{app.paths.client}/js/vendor/**"
        "build/webapp/public/css/":       "#{app.paths.client}/css/**"
        "build/webapp/public/img/":       "#{app.paths.client}/img/**"
        "build/webapp/public/dev/":       "#{app.paths.client}/dev/**"
        "build/webapp/public/":           "#{app.paths.client}/index.html"
  reload: {}  
  watch:
    services:
      files: "#{app.paths.app}/**/services/**/*.coffee"
      tasks: "mocha"
    client: 
      files: [
        "#{app.paths.client}/js/vendor/**",
        "#{app.paths.client}/css/**",
        "#{app.paths.client}/index.html"
      ]
      tasks: "copy reload"
    jaded:
      files: "<config:jaded.app.src>"
      tasks: "jaded reload"
    contract:
      files: "<config:contract.files>"
      tasks: "contract"
    coffee:
      files: [ "<config:coffee.app.src>",
               "<config:coffee.services.src>",
               "<config:coffee.vendor.src>" ]
      tasks: "coffee reload" 

  globals:
    exports: true


module.exports = (grunt) ->

  ## init config  
  grunt.initConfig gruntConfig
  grunt.loadTasks './build'
  grunt.loadNpmTasks "grunt-contrib"
  grunt.loadNpmTasks "grunt-reload"
  grunt.loadNpmTasks "grunt-coffee"
  grunt.loadNpmTasks "grunt-jaded"
  grunt.loadNpmTasks "grunt-simple-mocha"

  ## default 
  grunt.registerTask "default", "simplemocha copy jaded coffee contract watch"

  #grunt.registerTask "wipePublic", ""

  grunt.registerMultiTask "contract", "parse agent contract", -> 
    file = grunt.file.expandFiles(@file.src)[0]
    contract = coffee.eval (grunt.file.read file), bare: true
    require('shaman').start contract, path.resolve(__dirname, '..')
