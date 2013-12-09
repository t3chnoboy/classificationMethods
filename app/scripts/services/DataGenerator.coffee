'use strict'

angular.module('neuralClassifierApp')
  .service 'Datagenerator', () ->

    randomFloat = (min, max) -> Math.random() * (max - min) + min

    randomInt = (min, max) -> Math.floor Math.random() * (max - min + 1) + min

    @generateData = (minX = -10, maxX = 10, minY = 10, maxY = 10, amount = 10, discrete = yes) ->

      (for point in [1..amount]
        [
          if discrete then randomInt minX, maxX else randomFloat minX, maxX
          if discrete then randomInt minY, maxY else randomFloat minY, maxY
        ])

    @
