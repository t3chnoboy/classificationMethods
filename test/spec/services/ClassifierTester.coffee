'use strict'

describe 'Service: Classifiertester', () ->

  # load the service's module
  beforeEach module 'neuralClassifierApp'

  # instantiate service
  Classifiertester = {}
  beforeEach inject (_Classifiertester_) ->
    Classifiertester = _Classifiertester_

  it 'should do something', () ->
    expect(!!Classifiertester).toBe true
