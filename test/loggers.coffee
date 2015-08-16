_ = require '../inv-loggers'

should = require 'should'

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