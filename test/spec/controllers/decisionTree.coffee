'use strict'

describe 'Controller: DecisiontreeCtrl', () ->

  # load the controller's module
  beforeEach module 'neuralClassifierApp'

  DecisiontreeCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DecisiontreeCtrl = $controller 'DecisiontreeCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
