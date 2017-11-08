class Experiment

  @store: null

  constructor: (@name, @store) ->
    @_variants = []

  variant: (name, pct, value) ->
    [value, pct] = [pct, 100] unless value?
    @_variants.push {name, pct, value}
    @

  run: ->
    # Check for a previous run
    if (variantName = @store?.get(@name))?
      [chosen] = @_variants.filter (v) -> v.name is variantName

    # No value in the store, run the experiment fresh
    unless chosen?
      variantsSum = 0
      variantsSum += variant.pct for variant in @_variants
      if variantsSum isnt 100
        throw new Error("experiment #{@name} has invalid percentages")

      # make the choice
      i = 0
      rand = Math.random() * 100
      for variant in @_variants
        i += variant.pct
        if i > rand
          chosen = variant
          break

    chosen.value?() # Execute user's code if its a function, let it throw

    # Only set the value once we're done in case of errors thrown
    @store?.addResult @name, chosen.name
    @chosen = chosen

module.exports = Experiment
