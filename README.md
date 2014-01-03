laboratory
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

