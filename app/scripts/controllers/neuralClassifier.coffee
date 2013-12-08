'use strict'

angular.module('neuralClassifierApp')
  .controller 'NeuralclassifierCtrl', ($scope, Neurone, Datagenerator, Classifier) ->

    data = []
    classes = []
    pointsOfClass1 = []
    pointsOfClass0 = []
    plot = {}
    neuron = {}
    func = ->
    y1 = 0
    y2 = 0

    $scope.generateData = ->
      data = Datagenerator.generateData -5, 20, 300
      classes = Classifier.classify data, func
      pointsOfClass1 = Classifier.getPointsOfClass 1, data, func
      pointsOfClass0 = Classifier.getPointsOfClass 0, data, func
      $scope.redrawPlot()


    $scope.redrawPlot = ->
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

    $scope.init = ->
      $scope.learningRate = 0.5
      func = (element) -> if element[0] > 0 then 1 else 0
      $scope.generateData()
      plot = $.jqplot "plot", [pointsOfClass0, pointsOfClass1, []],
        series:[
            showLine: false
          ,
            showLine: false
          ,
            showMarker: false
        ]

    $scope.init()
