'use strict'

angular.module('neuralClassifierApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/neuralClassifier',
        templateUrl: 'views/neuralClassifier.html'
        controller: 'NeuralclassifierCtrl'
      .when '/decisionTree',
        templateUrl: 'views/decisionTree.html'
        controller: 'DecisiontreeCtrl'
      .when '/nearestNeighbor',
        templateUrl: 'views/nearestNeighbor.html'
        controller: 'NearestneighborCtrl'
      .when '/euclidDistance',
        templateUrl: 'views/euclidDistance.html'
        controller: 'EucliddistanceCtrl'
      .otherwise
        redirectTo: '/'
