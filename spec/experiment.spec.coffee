Experiment = require '../src/experiment'

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



