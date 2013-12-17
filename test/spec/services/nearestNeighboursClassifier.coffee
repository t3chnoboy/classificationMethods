'use strict'

describe 'Service: Nearestneighboursclassifier', () ->

  # load the service's module
  beforeEach module 'neuralClassifierApp'

  # instantiate service
  Nearestneighboursclassifier = {}
  beforeEach inject (_Nearestneighboursclassifier_) ->
    Nearestneighboursclassifier = _Nearestneighboursclassifier_

  it 'should do something', () ->
    expect(!!Nearestneighboursclassifier).toBe true
