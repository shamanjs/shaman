name: "#{appName}"
goal: ""
models: 
  Todo:
    txt: String
    done: Boolean
views:
  index:
    route: '/'
    crud: 'Todo'