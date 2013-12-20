'use strict'

angular.module('neuralClassifierApp')
  .controller 'DecisiontreeCtrl', ($scope, Datagenerator, Classifier, ClassificationFuncGenerator) ->

    #Global variables
    data = [ [0, 1], [2, 2], [3, 3], [3, 4], [7, 2], [5, 5], [3, 8], [6, 7], [6, 8], [8, 8] ]
    classes = [1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0]
    pointsOfClass1 = [ [0, 1], [2, 2], [3, 3], [3, 4], [7, 2] ]
    pointsOfClass0 = [ [5, 5], [3, 8], [6, 7], [6, 8], [8, 8] ]
    plot = {}
    knownFunction = ->
    predictedFunction = ->
    average0 = [0, 0]
    average1 = [0, 0]

    $scope.init = ->
      $scope.minX = 0
      $scope.minY = 1
      $scope.maxX = 8
      $scope.maxY = 8
      $scope.rateA = 20
      $scope.rateB = 20
      $scope.rateC = 20
      $scope.samplesNumber = 50
      $scope.numberOfPoints = 100
      $scope.discretePoints = yes
      knownFunction = ClassificationFuncGenerator.linearClassifier 4, 5, -30

      plot = $.jqplot "plot", [[[$scope.minX, $scope.minY], [$scope.maxX, $scope.maxY]], [], [ [2, $scope.minY], [2, $scope.maxY] ], [], [[0, 30], [8, -2]] ],
        series:[
            showLine: false
          ,
            showLine: false
          ,
            showMarker: false
          ,
            showMarker: false
        ]
      # $scope.generateData()
      $scope.redrawPlot()


    $scope.generateData = ->
      data = Datagenerator.generateData $scope.minX, $scope.maxX, $scope.minY, $scope.maxY, $scope.numberOfPoints, $scope.discretePoints
      classes = Classifier.classify data, knownFunction
      #separate arrays of points to draw them in different colors
      pointsOfClass1 = Classifier.getPointsOfClass 1, data, knownFunction
      pointsOfClass0 = Classifier.getPointsOfClass 0, data, knownFunction
      $scope.redrawPlot()


    $scope.redrawPlot = ->
      plot.series[0].data = pointsOfClass0
      plot.series[1].data = pointsOfClass1
      plot.series[2].data = [[2, $scope.minY - 2], [2, $scope.maxY + 2]]
      plot.series[3].data = [[2, 5], [$scope.maxX + 2, 5]]
      # 4x + 5y = 30
      # y = 30 - 4x
      plot.series[4].data = [[0, 30], [8, -2]]
      plot.axes.yaxis.min = $scope.minY - 2
      plot.axes.yaxis.max = $scope.maxY + 2
      plot.axes.xaxis.min = $scope.minX - 2
      plot.axes.xaxis.max = $scope.maxX + 2
      plot.axes.xaxis.ticks = [($scope.minX - 2)..($scope.maxX + 2)]
      plot.axes.yaxis.ticks = [($scope.minY - 2)..($scope.maxY + 2)]
      plot.replot()
      plot.redraw()


    $scope.init()
