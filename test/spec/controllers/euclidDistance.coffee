'use strict'

describe 'Controller: EucliddistanceCtrl', () ->

  # load the controller's module
  beforeEach module 'neuralClassifierApp'

  EucliddistanceCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    EucliddistanceCtrl = $controller 'EucliddistanceCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
