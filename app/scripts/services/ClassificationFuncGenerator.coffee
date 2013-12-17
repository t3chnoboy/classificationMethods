'use strict'

angular.module('neuralClassifierApp')
  .factory 'ClassificationFuncGenerator', () ->

    {
      linearClassifier: (a, b, c) ->
        # f = ax + by + c
        # if f < 0 then class is 0, otherwise class is 1
        (elem = []) ->
          if a*elem[0] + b*elem[1] + c >= 0 then 1
          else 0

      euclidClassifier: (average0, average1) ->
        (point = []) ->
          e1 = Math.sqrt( Math.pow((average1[0] - point[0]), 2) + Math.pow((average1[1] - point[1]), 2) )
          e0 = Math.sqrt( Math.pow((average0[0] - point[0]), 2) + Math.pow((average0[1] - point[1]), 2) )
          if e1 < e0 then 1 else 0
    }
