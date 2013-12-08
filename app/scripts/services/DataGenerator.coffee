'use strict'

angular.module('neuralClassifierApp')
  .service 'Datagenerator', () ->

    randomFloat = (min, max) -> Math.random() * (max - min) + min

    @generateData = (minValue, maxValue, amount, classificationFunction) ->

      points = []
      classes = []
      pointsClass0 = []
      pointsClass1 = []

      for point in [1..amount]
        points.push [
          randomFloat minValue, maxValue
          randomFloat minValue, maxValue
        ]

      classes = points.map classificationFunction
      pointsClass1 = points.filter classificationFunction
      pointsClass0 = points.filter (element) -> ! classificationFunction(element)

      data =
        points: points
        classes: classes
        pointsClass0: pointsClass0
        pointsClass1: pointsClass1


    @
