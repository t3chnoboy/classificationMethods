'use strict'

angular.module('neuralClassifierApp')
  .service 'Classifier', () ->

    @classify = (points, classificationFunction) ->
      classes = points.map classificationFunction

    @getPointsOfClass = (classNumber, points, classificationFunction) ->
      if classNumber is 0 then points.filter classificationFunction
      else points.filter (element) -> ! classificationFunction(element)

    @
