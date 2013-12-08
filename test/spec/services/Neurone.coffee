'use strict'

describe 'Service: Neurone', () ->

  # load the service's module
  beforeEach module 'neuralClassifierApp'

  # instantiate service
  Neurone = {}
  beforeEach inject (_Neurone_) ->
    Neurone = _Neurone_

  it 'should do something', () ->
    expect(!!Neurone).toBe true
