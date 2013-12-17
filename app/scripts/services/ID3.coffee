'use strict'

angular.module('neuralClassifierApp')
  .service 'Id3', () ->

entropy = (vals) ->
  uniqueVals = _.unique vals
  probs = uniqueVals.map (x) -> prob x, vals
  logVals = probs.map (p) -> -p*log2 p
  logVals.reduce (a,b) -> a+b

gain = (_s,target,feature) ->
  attrVals = _.unique _s.pluck feature
  setEntropy = entropy _s.pluck target
  setSize = _s.size()
  entropies = attrVals.map (n) ->
    subset = _s.filter (x) -> x[feature] is n
    (subset.length/setSize)*entropy(_.pluck(subset,target))

  sumOfEntropies =  entropies.reduce (a,b) -> a+b
  setEntropy - sumOfEntropies

maxGain = (_s,target,features) ->
  _.max features, (e) ->
    gain _s,target,e

prob = (val,vals) ->
    instances = _.filter vals, (x) ->
      x is val
    .length
    total = vals.length
    instances/total

log2 = (n) -> Math.log(n)/Math.log(2)


mostCommon = (l) ->
  _.sortBy l, (a) ->
	  count(a,l)
  .reverse()[0]

count = (a,l) ->
  _.filter l, 
    (b) -> b is a
  .length

randomTag = () ->
  "_r" + Math.round(Math.random()*1000000).toString()


id3 = (_s,target,features) ->
    targets = _.unique _s.pluck target
    if (targets.length == 1)
	    console.log("end node! "+targets[0])
	    return{
        type: "result"
        val: targets[0]
        name: targets[0]
        alias:targets[0]+randomTag()
      }

    if (features.length == 0)
      console.log "returning the most dominate feature!!!"
      topTarget = mostCommon targets
      return{
        type:"result"
        val: topTarget
        name: topTarget
        alias: topTarget+randomTag()
      }
    bestFeature = maxGain _s, target, features
    remainingFeatures = _.without features, bestFeature
    possibleValues = _.unique _s.pluck bestFeature
    console.log "node for " + bestFeature
    node =
      name: bestFeature
      alias: bestFeature+randomTag()
    node.type = "feature"
    node.vals = _.map possibleValues, (v) ->
      console.log "creating a branch for " + v
      _newS = _(_s.filter (x) ->
        x[bestFeature] == v
      )
      child_node =
        name:v
        alias:v+randomTag()
        type: "feature_value"
      child_node.child =  id3 _newS, target, remainingFeatures
      return child_node
    return node

predict = (id3Model, sample) ->
  root = id3Model
  while(root.type != "result")
	  attr = root.name
	  sampleVal = sample[attr]
	  childNode = _.detect root.vals, (x) -> x.name == sampleVal
	  root = childNode.child
  return root.val

