Experiment = require '../src/experiment'
MemoryStore = require '../src/memory_store'

describe 'Experiment', ->
  {experiment, variant} = {}

  beforeEach ->
    experiment = new Experiment("fluffy_bunnies")

  describe '::variant', ->
    describe 'with a percent', ->
      beforeEach ->
        experiment.variant "cotton_tail", 50, "white"
        variant = experiment._variants[0]

      it 'stores a variant with the correct amounts', ->
        expect(variant.name).toEqual "cotton_tail"
        expect(variant.pct).toEqual 50
        expect(variant.value).toEqual "white"

    describe 'without a percent', ->
      beforeEach ->
        experiment.variant "peter_rabbit", "gray"
        variant = experiment._variants[0]

      it 'stores a variant with a 100%', ->
        expect(variant.name).toEqual "peter_rabbit"
        expect(variant.pct).toEqual 100
        expect(variant.value).toEqual "gray"

  describe '::run', ->
    describe 'where variants do not add up to 100%', ->
      beforeEach ->
        experiment.variant "cotton_tail", 50, "white"

      it 'throws', ->
        expect(experiment.run).toThrow()

    describe 'where variants add up to 100%', ->
      {retValue} = {}

      beforeEach ->
        experiment.variant "peter_rabbit", "gray"
        retValue = experiment.run()

      it 'returns a variant', ->
        expect(retValue).toBeTruthy()
        expect(retValue.name).toBe "peter_rabbit"
        expect(retValue.value).toEqual "gray"

      it 'populates a chosen field on the experiment', ->
        expect(experiment.chosen).toBeTruthy()
        expect(experiment.chosen.name).toBe "peter_rabbit"
        expect(experiment.chosen.value).toEqual "gray"

    describe 'when the experiment has a store', ->
      {store} = {}

      beforeEach ->
        store = new MemoryStore()
        experiment.store = store
        experiment.variant "peter_rabbit", "gray"
        experiment.run()

      it 'saves the chosen variant in the store', ->
        expect(store.get('fluffy_bunnies')).toBe experiment.chosen.name

    describe 'called multiple times', ->
      {uniqueVariants} = {}

      beforeEach ->
        experiment.variant "cotton_tail", 50, "white"
        experiment.variant "peter_rabbit", 50, "gray"

      run100Times = ->
        [1..100]
          .map(-> experiment.run().name)
          .reduce (uniqueVariants, variantName) ->
            uniqueVariants.push(variantName) unless uniqueVariants.indexOf(variantName) > -1
            uniqueVariants
          , []

      describe 'without a store', ->
        beforeEach ->
          uniqueVariants = run100Times()

        it 'returns a random variant each time', ->
          expect(uniqueVariants.length).toBeGreaterThan 1

      describe 'with a store', ->
        beforeEach ->
          store = new MemoryStore()
          store.addResult experiment.name, 'cotton_tail'
          experiment.store = store
          uniqueVariants = run100Times()

        it 'always returns the stored value', ->
          expect(uniqueVariants).toEqual ['cotton_tail']


      describe 'with a stored invalid variant', ->
        beforeEach ->
          store = new MemoryStore()
          store.addResult experiment.name, 'big_bad_bogus_wolf'
          experiment.store = store
          uniqueVariants = run100Times()

        it 'chooses a new variant', ->
          expect(uniqueVariants.length).toBe 1
          expect(uniqueVariants).not.toEqual ['big_bad_bogus_wolf']
