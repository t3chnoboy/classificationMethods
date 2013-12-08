'use strict'

angular.module('neuralClassifierApp')
  .service 'Datagenerator', () ->

    randomFloat = (min, max) -> Math.random() * (max - min) + min

    @generateData = (minValue, maxValue, amount) ->

      (for point in [1..amount]
        [
          randomFloat minValue, maxValue
          randomFloat minValue, maxValue
        ])

    @
