'use strict'

angular.module('neuralClassifierApp')
  .service 'Eucliddistanceclassifier', () ->

    @classifier = (teacher) ->

      points = teacher.points
      classes = teacher.classes

      numberOfClass1 = classes.reduce (a, b) -> a + b
      numberOfClass0 = classes.length - numberOfClass1

      sum1 = points.reduce ((a,b, index) -> if classes[index] is 1 then [ a[0] + b[0], a[1] + b[1] ] else a), [0, 0]
      sum0 = points.reduce ((a,b, index) -> if classes[index] is 0 then [ a[0] + b[0], a[1] + b[1] ] else a), [0, 0]

      average0 = [ sum0[0] / numberOfClass0, sum0[1] / numberOfClass0 ]
      average1 = [ sum1[0] / numberOfClass1, sum1[1] / numberOfClass1 ]

      euclid =
        average0: average0
        average1: average1
        classifier: (point = []) ->
          e1 = Math.sqrt( Math.pow((average1[0] - point[0]), 2) + Math.pow((average1[1] - point[1]), 2) )
          e0 = Math.sqrt( Math.pow((average0[0] - point[0]), 2) + Math.pow((average0[1] - point[1]), 2) )
          console.log e1, e0
          if e1 < e0 then 1 else 0
