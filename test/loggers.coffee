_ = require '../src/inv-loggers'

should = require 'should'

describe 'loggers', ->
  describe 'log', ->
    it "should return the first argument", (done)->
      _.log({what: 'blop'}, 'whatever').should.be.an.Object()
      _.log({what: 'blop'}).should.be.an.Object()
      _.log('blob', 'whatever').should.be.a.String()
      _.log(['blob'], 'whatever').should.be.an.Array()
      _.log('blob').should.be.an.String()
      done()

    it "should convert an arguments object to an array", (done)->
      _.log(arguments, 'args').should.be.an.Array()
      done()

    it "should not throw when passed a null object", (done)->
      (-> _.log(null, "it's a trap!")).should.not.throw()
      done()

  describe 'BindingLoggers', ->
    it "should return a function", (done)->
      _.Log('whatever').should.be.a.Function()
      _.Error('whatever').should.be.a.Function()
      _.Warn('whatever').should.be.a.Function()
      _.Info('whatever').should.be.a.Function()
      _.Success('whatever').should.be.a.Function()
      logger = _.Log('whatever')
      logger.should.be.a.Function()
      console.log logger
      logger('wat').should.be.a.String()
      logger(['wat']).should.be.a.Array()
      logger({hello: 'wat'}).should.be.an.Object()
      done()

  describe 'errorRethrow', ->
    it "should rethrow an error", (done)->
      _.errorRethrow.should.be.a.Function()
      err = new Error('yo')
      (->_.errorRethrow(err)).should.throw(err)
      done()
    it "should rethrow an error in its partial form too", (done)->
      _.ErrorRethrow.should.be.a.Function()
      fn = _.ErrorRethrow('hello')
      fn.should.be.a.Function()
      err = new Error('yo')
      (-> fn(err)).should.throw(err)
      done()

  describe 'warn', ->
    it "should return undefined", (done)->
      should(_.warn({what: 'blop'}, 'whatever')).not.be.ok()
      should(_.warn({what: 'blop'})).not.be.ok()
      should(_.warn('blob', 'whatever')).not.be.ok()
      should(_.warn(['blob'], 'whatever')).not.be.ok()
      should(_.Warn(['blob'])('whatever')).not.be.ok()
      should(_.warn('blob')).not.be.ok()
      should(_.Warn('blob')('hello')).not.be.ok()
      done()
