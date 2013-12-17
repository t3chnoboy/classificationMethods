'use strict'

angular.module('neuralClassifierApp')
  .controller 'HeaderController', ($scope, $location) ->

    $scope.isActive = (viewLocation) ->
      viewLocation == $location.path()
