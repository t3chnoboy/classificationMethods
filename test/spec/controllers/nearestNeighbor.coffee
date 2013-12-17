'use strict'

describe 'Controller: NearestneighborCtrl', () ->

  # load the controller's module
  beforeEach module 'neuralClassifierApp'

  NearestneighborCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    NearestneighborCtrl = $controller 'NearestneighborCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3
