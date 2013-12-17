'use strict'

describe 'Service: Classificationtree', () ->

  # load the service's module
  beforeEach module 'neuralClassifierApp'

  # instantiate service
  Classificationtree = {}
  beforeEach inject (_Classificationtree_) ->
    Classificationtree = _Classificationtree_

  it 'should do something', () ->
    expect(!!Classificationtree).toBe true
