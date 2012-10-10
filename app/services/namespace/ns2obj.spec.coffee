ns2obj = require './ns2obj'
module.exports =

  ns2obj:

    "given a simple obj and ns should get value": ->

      obj =
        foo: 
          bar: 'baz'
      ns = "foo.bar"      
      ns2obj(obj, ns).should.equal 'baz'

    "given a deep nested obj and ns should get value": ->

      obj =
        foo: 
          bar:
            baz:
              zap: 'pow'
      ns = "foo.bar.baz.zap"      
      ns2obj(obj, ns).should.equal 'pow'
