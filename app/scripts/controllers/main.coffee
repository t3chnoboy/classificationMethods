'use strict'

angular.module('neuralClassifierApp')
  .controller 'MainCtrl', ($scope, Neurone, Datagenerator, Classifier) ->

    neuron = new Neurone()

    data = Datagenerator.generateData -5, 20, 30

    func = (element) -> if element[0] > 0 then 1 else 0

    classes = Classifier.classify data, func
    pointsOfClass1 = Classifier.getPointsOfClass 1, data, func
    pointsOfClass0 = Classifier.getPointsOfClass 0, data, func


    $scope.points = [
      [0, 1], [2, 2], [3, 3], [3, 4], [7, 2],
      [5, 5], [3, 8], [6, 7], [6, 8], [8, 8], [1, 4], [6, 6], [1, 9]
    ]

    $scope.classes = [1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0]

    $scope.pointsClass0 = []
    $scope.pointsClass1 = []

    for cls, index in $scope.classes
      if cls == 1 then $scope.pointsClass1.push $scope.points[index]
      else $scope.pointsClass0.push $scope.points[index]


    $scope.randomWeights = ->
      $scope.wx = neuron.randomInt -20, 20
      $scope.wy = neuron.randomInt -20, 20
      $scope.wz = neuron.randomInt -20, 20

    $scope.randomWeights()
    $scope.learningRate = 0.5

    $scope.iterationsCount = 0
    $scope.resWx = 0
    $scope.resWy = 0
    $scope.resWz = 0

    plot = $.jqplot "plot", [$scope.pointsClass0, $scope.pointsClass1, [[0, 6.5], [8.4, 2]], []],
      series:[
          showLine: false
        ,
          showLine: false
        ,
          showMarker: false
        ,
          showMarker: false
      ]

    $scope.train = ->

      neuron.weight[0] = $scope.wx/0.9999
      neuron.weight[1] = $scope.wy/0.9999
      neuron.weight[2] = $scope.wz/0.9999

      teacher =
        points: $scope.points
        classes: $scope.classes

      $scope.iterationsCount = neuron.train($scope.learningRate, teacher)
      $scope.resWx = neuron.weight[0]
      $scope.resWy = neuron.weight[1]
      $scope.resWz = neuron.weight[2]
      # 0 = ax + by + c
      # x = (- by - c)/a
      # y = (- ax - c)/b
      y1 = (- neuron.weight[0] * 0 - neuron.weight[2])/neuron.weight[1]
      y2 = (- neuron.weight[0] * 8.4 - neuron.weight[2])/neuron.weight[1]
      plot.series[3].data = [[0, y1], [8.4, y2]]

      plot.replot()
      plot.redraw()

