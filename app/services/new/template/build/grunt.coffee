coffee     = require 'coffee-script'
Mocha      = require 'mocha'
require './globals'
path = require 'path'

gruntConfig =
  pkg: "<json:package.json>"
  test:
    files: ["#{app.paths.app}/**/*.spec.coffee"]
  mocha: 
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
      src: [ "#{app.paths.client}/js/services/*.coffee" ]
      dest:  "#{app.paths.public}/js/services"
      options:
        bare: true
    vendor:
      src: [ "#{app.paths.client}/js/vendor/*.coffee" ]
      dest:  "#{app.paths.public}/js/vendor"
      options:
        bare: true
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
    test:
      files: "<config:test.files>"
      tasks: "test"
    services:
      files: "#{app.paths.app}/**/services/**/*.coffee"
      tasks: "test"
    client: 
      files: [
        "#{app.paths.client}/js/vendor/**",
        "#{app.paths.client}/css/**",
        "#{app.paths.client}/index.html"
      ]
      tasks: "copy reload"
    jaded:
      files: "build/webapp/client/templates/*.jade"
      tasks: "jaded reload"
    #jobs:
    #  files: "#{app.paths.app}/**/jobs/**/*.coffee"
    #  tasks: "test"
    util:
      files: "#{app.paths.app}/**/util/**/*.coffee"
      tasks: "test"
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

  ## default 
  grunt.registerTask "default", "test copy jaded coffee contract watch"

  grunt.registerMultiTask "contract", "parse agent contract", -> 
    file = grunt.file.expandFiles(@file.src)[0]
    contract = coffee.eval (grunt.file.read file), bare: true
    require('shaman').start contract, path.resolve(__dirname, '..')

  ## grunt-jaded
  grunt.registerTask "jaded", "compile jaded templates", ->
  jaded = require 'jaded'  
  {basename, extname}  = require 'path'
  src   = app.paths.client + '/templates'
  dest  = app.paths.public + '/templates'
  grunt.file.recurse src,
    (absolute, root, subdir, filename) ->
      name = basename filename, extname filename
      template = jaded.compile grunt.file.read(absolute), 
        development: true
        rivets: false
        amd: true
        filename: absolute
      grunt.file.write "#{dest}/#{name}.js", template

  ## grunt-mocha-node
  grunt.registerMultiTask "test", "Run unit tests with Mocha", ->
    # tell grunt this is an asynchronous task
    done = @async()

    for key of require.cache
      if require.cache[key]
        delete require.cache[key]

        console.warn "Mocha grunt task: Could not delete from require cache:\n" + key  if require.cache[key]
      else
        console.warn "Mocha grunt task: Could not find key in require cache:\n" + key

    # load the options if they are specified
    if typeof options is 'object'
      options = grunt.config(["mocha", @target, "options"])
    else
      options = grunt.config("mocha.options") 
    
    # create a mocha instance with our options
    mocha = new Mocha(options)

    # add files to mocha
    for file in grunt.file.expandFiles(@file.src)
      mocha.addFile file

    # run mocha asynchronously and catch errors!! (again, in case we are running this task in watch)

    try
      mocha.run (failureCount) ->
        console.log "Mocha completed with " + failureCount + " failing tests"
        done failureCount is 0
    catch e
      console.log "Mocha exploded!"
      console.log e.stack
      done false
