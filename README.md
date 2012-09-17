shaman 

```
  module.exports =

    default:
      name:    "Fractal" 
      github:  "wearefractal"
      website: "www.wearefractal.com"
      email:   "contact@wearefractal.com"
    
      new: (jobs) ->
        exec 'git init'
        exec 'npm install'
        exec 'npm link shaman'
        exec 'sublime . &'
        setTimeout -> exec 'grunt', 300