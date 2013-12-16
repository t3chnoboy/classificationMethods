'use strict'

describe 'Service: Id3', () ->

  # load the service's module
  beforeEach module 'neuralClassifierApp'

  # instantiate service
  Id3 = {}
  beforeEach inject (_Id3_) ->
    Id3 = _Id3_

  it 'should do something', () ->
    expect(!!Id3).toBe true
