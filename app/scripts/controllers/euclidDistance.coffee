'use strict'

angular.module('neuralClassifierApp')
  .controller 'EucliddistanceCtrl', ($scope, Eucliddistanceclassifier, Datagenerator, Classifier, ClassificationFuncGenerator, Classifiertester) ->

    #Global variables
    data = []
    classes = []
    pointsOfClass1 = []
    pointsOfClass0 = []
    plot = {}
    knownFunction = ->
    predictedFunction = no
    average0 = [0, 0]
    average1 = [0, 0]

    $scope.init = ->
      $scope.minX = -20
      $scope.minY = -20
      $scope.maxX = 20
      $scope.maxY = 20
      $scope.rateA = 20
      $scope.rateB = 20
      $scope.rateC = 20
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
            showLine: false
            color: 'red'
        ]
      $scope.generateData()


    $scope.generateData = ->
      data = Datagenerator.generateData $scope.minX, $scope.maxX, $scope.minY, $scope.maxY, $scope.numberOfPoints, $scope.discretePoints
      knownFunction = ClassificationFuncGenerator.linearClassifier $scope.rateA, $scope.rateB, $scope.rateC
      classes = Classifier.classify data, knownFunction
      #separate arrays of points to draw them in different colors
      pointsOfClass1 = Classifier.getPointsOfClass 1, data, knownFunction
      pointsOfClass0 = Classifier.getPointsOfClass 0, data, knownFunction
      $scope.testClassifier()
      $scope.redrawPlot()


    $scope.redrawPlot = ->
      plot.series[0].data = pointsOfClass0
      plot.series[1].data = pointsOfClass1
      plot.series[2].data = [average0, average1]
      plot.axes.yaxis.min = $scope.minY - 2
      plot.axes.yaxis.max = $scope.maxY + 2
      plot.axes.xaxis.min = $scope.minX - 2
      plot.axes.xaxis.max = $scope.maxX + 2
      plot.axes.xaxis.ticks = [($scope.minX - 2)..($scope.maxX + 2)]
      plot.axes.yaxis.ticks = [($scope.minY - 2)..($scope.maxY + 2)]
      plot.replot()
      plot.redraw()


    $scope.train = ->
      sampleData = Datagenerator.generateData $scope.minX, $scope.maxX, $scope.minY, $scope.maxY, $scope.samplesNumber, $scope.discretePoints
      sampleClasses = Classifier.classify sampleData, knownFunction

      teacher =
        points: sampleData
        classes: sampleClasses

      euclide = Eucliddistanceclassifier teacher

      predictedFunction = euclide.classifier
      average0 = euclide.average0
      average1 = euclide.average1

      console.log average0
      console.log average1

      $scope.testClassifier()
      $scope.redrawPlot()

    $scope.testClassifier = ->
      if (predictedFunction)
        $scope.testResults = Classifiertester.evaulate knownFunction, predictedFunction, data
        # plot = $.jqplot "plotROC", [$scope.testResults.rocPoints, [[0,0],[1,1]]],
        #   series:[
        #     showMarker: false
        #   ,
        #     showMarker: false
        #   ]

    $scope.init()
