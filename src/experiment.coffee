class Experiment

  @store: null

  constructor: (@name, @store) ->
    @_variants = []

  variant: (name, pct, value) ->
    [value, pct] = [pct, 100] unless value?
    @_variants.push {name, pct, value}
    @

  run: ->
    if (variantName = @store?.get(@name))?
      @chosen = _(@_variants).find (v) -> v.name is variantName
      if @chosen?
        @chosen.value?()
    else
      variantsSum = 0
      variantsSum += variant.pct for variant in @_variants
      if variantsSum isnt 100
        throw new Error("experiment #{@name} has invalid percentages")

      # make the choice
      i = 0
      rand = Math.random() * (100 - 1) + 1
      for variant in @_variants
        i += variant.pct
        if i >= rand
          @chosen = variant
          @chosen.value?()
          break

    @store?.addResult @name, @chosen.name

    @chosen

module.exports = Experiment