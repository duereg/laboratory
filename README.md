[![Build Status](https://travis-ci.org/duereg/laboratory.svg)](https://travis-ci.org/duereg/laboratory)
[![Dependencies](https://david-dm.org/duereg/laboratory.svg)](https://david-dm.org/duereg/laboratory)
[![devDependencies](https://david-dm.org/duereg/laboratory/dev-status.svg)](https://david-dm.org/duereg/laboratory#info=devDependencies&view=table)
[![NPM version](https://badge.fury.io/js/laboratory.svg)](http://badge.fury.io/js/laboratory)

Laboratory
==========

Simple A/B Testing Framework for both client and server environments.

Laboratory chooses a variant for each experiment based on a configurable probability.  Use the pluggable storage interface to serve users a consistent experience after they've been assigned a variant.

```sh
$ npm install laboratory
```

### Example Usage ###

Run a single Experiment:

``` coffeescript
{Experiment} = require "laboratory"

experiment = new Experiment("color")
  .variant "red", 50, "#FF0000"
  .variant "blue", 50, "#0000FF"

variant = experiment.run()
variant.name # Either red or blue
variant.value # Either FF0000 or 0000FF
```

Run a suite of experiments in a Laboratory:

```coffeescript
{Laboratory} = require "laboratory"
laboratory = new Laboratory()

laboratory.addExperiment("color")
  .variant "red", 50, "#FF0000"
  .variant "blue", 50, "#0000FF"

laboratory.addExperiment("FuzzyBunnies")
  .variant "variant0", 50,
    name: "Peter Rabbit"
    type: "Wooly"
  .variant "variant1", 50,
    subject: "Briar Rabbit"
    type: "Silky"

experiment = laboratory.run("FuzzyBunnies")
experiment.value # Either Peter or Briar Rabbit
```

Store the results per user in browser local storage:

``` coffeescript
store = new LocalStorageStore() # not included
laboratory = new Laboratory(store)

laboratory.addExperiment /* ... */
laboratory.run /* ... */
```
