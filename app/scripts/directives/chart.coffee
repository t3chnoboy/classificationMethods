'use strict'

angular.module('neuralClassifierApp')
  .directive 'chart', () ->
    template: '<chart></chart>'
    restrict: 'E'
    link: (scope, element, attrs) ->
      chart = null
      opts = {}

      data = scope[attrs.ngModel]
      scope.$watch 'data', (v) ->
        if(!chart)
          chart = $.plot elem, v , opts
          elem.show()
        else
          chart.setData v
          chart.setupGrid()
          chart.draw()

