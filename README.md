[![Build Status](https://travis-ci.org/duereg/laboratory.png)](https://travis-ci.org/duereg/laboratory)
[![Dependencies](https://david-dm.org/duereg/laboratory.png)](https://david-dm.org/duereg/laboratory)
[![devDependencies](https://david-dm.org/duereg/laboratory/dev-status.png)](https://david-dm.org/duereg/laboratory#info=devDependencies&view=table)
[![NPM version](https://badge.fury.io/js/laboratory.svg)](http://badge.fury.io/js/laboratory)

Laboratory
==========

Simple A/B Testing Framework for both client and server environments.


### Example Usage ###

```coffeescript
laboratory = new Laboratory()

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

