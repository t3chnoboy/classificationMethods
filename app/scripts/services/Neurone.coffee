'use strict'

angular.module('neuralClassifierApp')
  .service 'Neurone', () ->

    class Neuron

      constructor: () ->
        @weight = [@randomInt(-100,100), @randomInt(-100,100), @randomInt(-100,100)]


      randomInt: (min, max) ->
        Math.floor Math.random() * (max - min + 1) + min


      #returns class of a point
      classify: (point = [0, 0]) ->
        y = @weight[0] * point[0] + @weight[1] * point[1] + @weight[2]
        if y >= 0 then 1
        else if y < 0 then 0


      #returns firs mismatch
      compareToTeacher: (teacher)->
        for teacherClass, index in teacher.classes
          neuronClass = @classify teacher.points[index]

          if teacherClass != neuronClass
            return index
        -1


      #trains neuron
      #returns iterations number
      train: (learningRate = 0.9, teacher) ->
        iterationsCount = 0

        while 1

          firstMismatch = @compareToTeacher(teacher)
          if firstMismatch == -1 then break

          wrongClass = @classify teacher.points[firstMismatch]
          correctClass = teacher.classes[firstMismatch]

          @weight[0] += learningRate * teacher.points[firstMismatch][0] * (correctClass - wrongClass)
          @weight[1] += learningRate * teacher.points[firstMismatch][1] * (correctClass - wrongClass)
          @weight[2] += learningRate * (correctClass - wrongClass)

          iterationsCount++

        iterationsCount


    Neuron
