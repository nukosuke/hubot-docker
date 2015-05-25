chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'docker', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/docker')(@robot)

  it 'registers a respond listener: docker ps', ->
    expect(@robot.respond).to.have.been.calledWith(/docker ps/)
