PowerAnalysis.jl
================

Tools for analyzing the power of proposed statistical designs.

# Core Concepts

The PowerAnalysis package exports several core functions:

* `power`: Compute the power of a design given a proposed sample size and
           effect size
* `effect_size`: Compute the smallest measurable effect size given a proposed
                 sample size and the desired level of power
* `sample_size`: Compute the smallest sample size that can measure a given
                 effect size with the desired level of power
* `type_1`: How often do we falsely reject the null when it's true?
* `type_2`: How often do we fail to reject the null when it's false?
* `type_s`: How often do we reject the null when our estimate of δ has the
            wrong sign?
* `type_m`: How often do we overestimate the magnitude of δ when we reject the
            the null?
* `exaggeration_factor`: How much larger is our estimate of δ than the true
                         value when we reject the null?

All of these functions assume that statistical designs are described in terms
of:

* `ns`: The per-group sample size(s)
* `δ`: The difference in means between groups or the difference from zero
* `σs`: The per-group standard deviation(s)
* `p`: The desired power
* `α`: The significance level at which the null would be rejected

# Examples

We consider comparing two groups using a t-test that assumes that both groups
have the same variance. We consider using 100 samples per-group to test
a difference of 0.01 in means between groups, each of which have variance 1.
We also determine what effect size and sample size would be required to reach
power 0.8 when rejecting the null with a significance level of 0.05:

```
using PowerAnalysis, HypothesisTests

n = 100
δ = 0.01
σs = 1.0
p = 0.8
α = 0.05

power(EqualVarianceTTest, n, δ, σs, α)

effect_size(EqualVarianceTTest, n, p, α)

sample_size(EqualVarianceTTest, δ, σs, p, α)

type_1(EqualVarianceTTest, n, δ, σs, α)

type_2(EqualVarianceTTest, n, δ, σs, α)

type_s(EqualVarianceTTest, n, δ, σs, α)

type_m(EqualVarianceTTest, n, δ, σs, α)

exaggeration_factor(EqualVarianceTTest, n, δ, σs, α)
```

As you can tell, attempting to measure an effect of size 0.01 is unwise.

# Caveats

* All methods assume that δ is strictly positive
* All methods assume that one-sided tests are "greater than null" tests

# Bibliography

* z-test calculations: "All of Statistics" by Larry Wasserman
* t-test calculations: "Sample size and power calculations using the
  noncentral t-distribution" by David A. Harrison and Anthony R. Brady
* Type S error: "Beyond power calculations: Assessing Type S (sign) and Type M
  (magnitude) errors" by Andrew Gelman and John Carlin
* Type M error: "Beyond power calculations: Assessing Type S (sign) and Type M
  (magnitude) errors" by Andrew Gelman and John Carlin
* Exaggeration factor: "Beyond power calculations: Assessing Type S (sign) and
  Type M (magnitude) errors" by Andrew Gelman and John Carlin
