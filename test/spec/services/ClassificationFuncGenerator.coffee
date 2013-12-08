'use strict'

describe 'Service: Classificationfuncgenerator', () ->

  # load the service's module
  beforeEach module 'neuralClassifierApp'

  # instantiate service
  Classificationfuncgenerator = {}
  beforeEach inject (_Classificationfuncgenerator_) ->
    Classificationfuncgenerator = _Classificationfuncgenerator_

  it 'should do something', () ->
    expect(!!Classificationfuncgenerator).toBe true
