_ = require '../src/inv-loggers'

should = require 'should'
expect = require('chai').expect

describe 'loggers', ->
  describe 'log', ->
    it "should return the first argument", (done)->
      _.log({what: 'blop'}, 'whatever').should.be.an.Object
      _.log({what: 'blop'}).should.be.an.Object
      _.log('blob', 'whatever').should.be.an.String
      _.log(['blob'], 'whatever').should.be.an.Array
      _.log('blob').should.be.an.String
      done()

  describe 'BindingLoggers', ->
    it "should return a function", (done)->
      _.Log('whatever').should.be.a.Function
      _.Error('whatever').should.be.a.Function
      _.Warn('whatever').should.be.a.Function
      _.Info('whatever').should.be.a.Function
      _.Success('whatever').should.be.a.Function
      logger = _.Log('whatever')
      logger.should.be.a.Function
      console.log logger
      logger('wat').should.be.a.String
      logger(['wat']).should.be.a.Array
      logger({hello: 'wat'}).should.be.an.Object
      done()

  describe 'errorRethrow', ->
    it "should rethrow an error", (done)->
      _.errorRethrow.should.be.a.Function
      err = new Error('yo')
      (->_.errorRethrow(err)).should.throw(err)
      done()
    it "should rethrow an error in its partial form too", (done)->
      _.ErrorRethrow.should.be.a.Function
      fn = _.ErrorRethrow('hello')
      fn.should.be.a.Function
      err = new Error('yo')
      (-> fn(err)).should.throw(err)
      done()

  describe 'warn', ->
    it "should return undefined", (done)->
      expect(_.warn({what: 'blop'}, 'whatever')).to.be.undefined
      expect(_.warn({what: 'blop'})).to.be.undefined
      expect(_.warn('blob', 'whatever')).to.be.undefined
      expect(_.warn(['blob'], 'whatever')).to.be.undefined
      expect(_.Warn(['blob'])('whatever')).to.be.undefined
      expect(_.warn('blob')).to.be.undefined
      expect(_.Warn('blob')('hello')).to.be.undefined
      done()
