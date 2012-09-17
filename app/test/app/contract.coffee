module.exports  =

  name: "todos"
  goal: "keep track of todos"
  models:
    Todo:
      text: String
      done: Boolean
  archive: 'mongo'
  client: 
    uses: 
      css: 'vendor/bootstrap'
      js: ['jquery']
  views:
    index:   
      route: '/'
      #exe:
      #crud: 'Todo'
