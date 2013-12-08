'use strict'

describe 'Service: Classifier', () ->

  # load the service's module
  beforeEach module 'neuralClassifierApp'

  # instantiate service
  Classifier = {}
  beforeEach inject (_Classifier_) ->
    Classifier = _Classifier_

  it 'should do something', () ->
    expect(!!Classifier).toBe true
