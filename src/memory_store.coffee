# A simple reference Store implementation

module.exports = class MemoryStore
  constructor: ->
    @results = {}

  get: (experimentName) ->
    @results[experimentName]

  addResult: (experimentName, chosenVariantName) ->
    @results[experimentName] = chosenVariantName
