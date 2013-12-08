'use strict'

describe 'Service: Datagenerator', () ->

  # load the service's module
  beforeEach module 'neuralClassifierApp'

  # instantiate service
  Datagenerator = {}
  beforeEach inject (_Datagenerator_) ->
    Datagenerator = _Datagenerator_

  it 'should do something', () ->
    expect(!!Datagenerator).toBe true
