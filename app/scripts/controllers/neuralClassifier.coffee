'use strict'

angular.module('neuralClassifierApp')
  .controller 'NeuralclassifierCtrl', ($scope, Neurone, Datagenerator, Classifier, ClassificationFuncGenerator, Classifiertester) ->

    #Global variables
    data = []
    classes = []
    pointsOfClass1 = []
    pointsOfClass0 = []
    plot = {}
    neuron = {}
    knownFunction = ->
    predictedFunction = ->
    y1 = 0
    y2 = 0

    $scope.init = ->
      $scope.minX = -20
      $scope.minY = -20
      $scope.maxX = 20
      $scope.maxY = 20
      $scope.rateA = 20
      $scope.rateB = 20
      $scope.rateC = 20
      $scope.learningRate = 0.5
      $scope.samplesNumber = 50
      $scope.numberOfPoints = 100
      $scope.discretePoints = yes
      knownFunction = ClassificationFuncGenerator.linearClassifier $scope.rateA, $scope.rateB, $scope.rateC
      plot = $.jqplot "plot", [[[$scope.minX, $scope.minY], [$scope.maxX, $scope.maxY]], [], []],
        series:[
            showLine: false
          ,
            showLine: false
          ,
            showMarker: false
        ]
      $scope.generateData()


    $scope.generateData = ->
      data = Datagenerator.generateData $scope.minX, $scope.maxX, $scope.minY, $scope.maxY, $scope.numberOfPoints, $scope.discretePoints
      knownFunction = ClassificationFuncGenerator.linearClassifier $scope.rateA, $scope.rateB, $scope.rateC
      classes = Classifier.classify data, knownFunction
      #separate arrays of points to draw them in different colors
      pointsOfClass1 = Classifier.getPointsOfClass 1, data, knownFunction
      pointsOfClass0 = Classifier.getPointsOfClass 0, data, knownFunction
      $scope.redrawPlot()


    $scope.redrawPlot = ->
      plot.series[0].data = pointsOfClass0
      plot.series[1].data = pointsOfClass1
      plot.series[2].data = [[$scope.minX, y1], [$scope.maxX, y2]]
      plot.axes.yaxis.min = $scope.minY - 2
      plot.axes.yaxis.max = $scope.maxY + 2
      plot.axes.xaxis.min = $scope.minX - 2
      plot.axes.xaxis.max = $scope.maxX + 2
      plot.axes.xaxis.ticks = [($scope.minX - 2)..($scope.maxX + 2)]
      plot.axes.yaxis.ticks = [($scope.minY - 2)..($scope.maxY + 2)]
      plot.replot()
      plot.redraw()


    $scope.train = ->
      neuron = new Neurone()
      sampleData = Datagenerator.generateData $scope.minX, $scope.maxX, $scope.minY, $scope.maxY, $scope.samplesNumber, $scope.discretePoints
      sampleClasses = Classifier.classify sampleData, knownFunction

      teacher =
        points: sampleData
        classes: sampleClasses

      $scope.iterationsCount = neuron.train($scope.learningRate, teacher)

      predictedFunction = ClassificationFuncGenerator.linearClassifier neuron.weight[0], neuron.weight[1], neuron.weight[2]

      y1 = (- neuron.weight[0] * ($scope.minX) - neuron.weight[2])/neuron.weight[1]
      y2 = (- neuron.weight[0] * $scope.maxX - neuron.weight[2])/neuron.weight[1]
      $scope.redrawPlot()
      $scope.testNeurone()


    $scope.testNeurone = ->
      results = Classifiertester.evaulate knownFunction, predictedFunction
      plot = $.jqplot "plotROC", [results.rocPoints]
      console.log results

    $scope.init()
