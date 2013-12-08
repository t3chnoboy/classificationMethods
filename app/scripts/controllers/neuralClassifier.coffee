'use strict'

angular.module('neuralClassifierApp')
  .controller 'NeuralclassifierCtrl', ($scope, Neurone, Datagenerator, Classifier, ClassificationFuncGenerator) ->

    #Global variables
    data = []
    classes = []
    pointsOfClass1 = []
    pointsOfClass0 = []
    plot = {}
    neuron = {}
    classifier = ->
    y1 = 0
    y2 = 0


    $scope.generateData = ->
      data = Datagenerator.generateData -20, 20, 300
      classes = Classifier.classify data, classifier

      #separate arrays of points to draw them in different colors
      pointsOfClass1 = Classifier.getPointsOfClass 1, data, classifier
      pointsOfClass0 = Classifier.getPointsOfClass 0, data, classifier
      $scope.redrawPlot()


    $scope.redrawPlot = ->
      plot.series[0].data = pointsOfClass0
      plot.series[1].data = pointsOfClass1
      plot.series[2].data = [[0, y1], [10, y2]]
      plot.replot()
      plot.redraw()


    $scope.train = ->
      neuron = new Neurone()

      teacher =
        points: data
        classes: classes

      $scope.iterationsCount = neuron.train($scope.learningRate, teacher)

      y1 = (- neuron.weight[0] * 0 - neuron.weight[2])/neuron.weight[1]
      y2 = (- neuron.weight[0] * 10 - neuron.weight[2])/neuron.weight[1]
      $scope.redrawPlot()


    $scope.init = ->

      $scope.learningRate = 0.5

      classifier = ClassificationFuncGenerator.linearClassifier 2, 1, 20

      plot = $.jqplot "plot", [[[-20, -20], [20, 20]], [], []],
        series:[
            showLine: false
          ,
            showLine: false
          ,
            showMarker: false
        ]

      $scope.generateData()

    $scope.init()
