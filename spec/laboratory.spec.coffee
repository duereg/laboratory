Laboratory = require '../src/laboratory'

describe 'Laboratory', ->
  {laboratory} = {}

  beforeEach ->
    laboratory = new Laboratory()

  describe '::addExperiment', ->
    beforeEach ->
      laboratory.addExperiment("addToOrder")

    it 'creates an experiment', ->
      expect(laboratory.experiments['addToOrder']).toBeTruthy()

  describe '::get', ->
    beforeEach ->
      laboratory.addExperiment("addToOrder")

    describe 'an added experiment', ->
      it 'retrieves the experiment', ->
        expect(laboratory.get('addToOrder')).toBeTruthy()

    describe 'an experiment that has not been added', ->
      it 'returns undefined', ->
        expect(laboratory.get('notYetAdded')).toBeFalsy()

    describe 'an undefined experiment', ->
      it 'throws', ->
        expect(laboratory.get).toThrow()

  describe '::run', ->
    {experiment} = {}

    beforeEach ->
      laboratory.addExperiment("addToOrder")
      experiment = laboratory.get("addToOrder")
      spyOn(experiment, 'run')
      laboratory.run("addToOrder")

    it 'calls through to experiment.run()', ->
      expect(experiment.run).toHaveBeenCalled()

    describe 'on undefined experiment', ->
      it 'returns undefined', ->
        expect(laboratory.run('somethingThatDoesNotExist')).toBeFalsy()

