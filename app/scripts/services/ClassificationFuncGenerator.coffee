'use strict'

angular.module('neuralClassifierApp')
  .factory 'ClassificationFuncGenerator', () ->

    {
      linearClassifier: (a, b, c) ->
        # f = ax + by + c
        # if f < 0 then class is 0, otherwise class is 1
        (elem = []) ->
          if a*elem[0] + b*elem[1] + c >= 0 then 0
          else 1
    }
