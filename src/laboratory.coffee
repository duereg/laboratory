Experiment = require "./experiment"

class Laboratory
  constructor: (@store) ->
    @experiments = {}

  addExperiment: (name) ->
    experiment = new Experiment(name, @store)
    @experiments[name] = experiment
    experiment

  get: (name) ->
    throw new Error "Invalid Experiment Name" unless name?
    @experiments[name]

  run: (name) ->
    @get(name)?.run()

module.exports = Laboratory