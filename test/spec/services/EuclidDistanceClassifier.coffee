'use strict'

describe 'Service: Eucliddistanceclassifier', () ->

  # load the service's module
  beforeEach module 'neuralClassifierApp'

  # instantiate service
  Eucliddistanceclassifier = {}
  beforeEach inject (_Eucliddistanceclassifier_) ->
    Eucliddistanceclassifier = _Eucliddistanceclassifier_

  it 'should do something', () ->
    expect(!!Eucliddistanceclassifier).toBe true
