'use strict'

angular.module('neuralClassifierApp')
  .service 'Classifiertester', (Datagenerator) ->


    @evaulate = (knownFunction, predictedFunction, data = []) ->

      knownClasses     = data.map knownFunction
      predictedClasses = data.map predictedFunction

      positives = knownClasses.reduce (previousElement, currentElement) -> previousElement + currentElement
      negatives = data.length - positives


      tp          = 0
      fp          = 0
      tn          = 0
      fn          = 0
      p = 0
      n = 0
      rocPoints   = []


      for knownClass, index in knownClasses
        if knownClass is 1
          p++
          if predictedClasses[index] is 1 then tp++ else fn++
        else
          n++
          if predictedClasses[index] is 0 then tn++ else fp++

        # sensitivity = tp/(tp+fn)
        # if isNaN(sensitivity) then sensitivity = 1
        # specificity = tn/(tn+fp)
        # if isNaN(specificity) then specificity = 1
        # rocPoints.push [(1 - specificity), sensitivity]

        tpr = tp / positives
        fpr = fp / negatives
        rocPoints.push [fpr, tpr]

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

