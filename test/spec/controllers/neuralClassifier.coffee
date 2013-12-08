'use strict'

describe 'Controller: NeuralclassifierCtrl', () ->

  # load the controller's module
  beforeEach module 'neuralClassifierApp'

  NeuralclassifierCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    NeuralclassifierCtrl = $controller 'NeuralclassifierCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
