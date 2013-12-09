'use strict'

angular.module('neuralClassifierApp')
  .service 'Classifiertester', (Datagenerator) ->

    @evaulate = (knownFunction, predictedFunction) ->

      data             = Datagenerator.generateData -20, 20, -20, 20, 100, no
      knownClasses     = data.map knownFunction
      predictedClasses = data.map predictedFunction

      console.log knownClasses
      console.log predictedClasses

      tp          = 0
      fp          = 0
      tn          = 0
      fn          = 0
      negatives   = 0
      positives   = 0
      rocPoints   = []


      for knownClass, index in knownClasses
        if knownClass is 1
          positives++
          if predictedClasses[index] is 1 then tp++ else fn++
        else
          negatives++
          if predictedClasses[index] is 0 then tn++ else fp++

        sensitivity = tp/(tp+fn)
        if isNaN(sensitivity) then sensitivity = 1
        specificity = tn/(tn+fp)
        if isNaN(specificity) then specificity = 1
        rocPoints.push [sensitivity, (1 - specificity)]

      tp: tp
      fp: fp
      tn: tn
      fn: fn
      realPositive: positives
      realNegative: negatives
      precision: tp/(tp+fp)
      recall: tp/(tp+fn)
      specificity: tn/(tn+fp)
      sensitivity: tp/(tp+fn)
      accuracy: (tp + tn)/(tp + fp + fn + tn)
      rocPoints: rocPoints

    @

