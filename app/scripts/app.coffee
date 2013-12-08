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
      .otherwise
        redirectTo: '/'
