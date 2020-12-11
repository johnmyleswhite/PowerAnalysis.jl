"""
Determine the null and alternate hypotheses under z-tests given:

* `ns`: Per-group sample size(s)
* `δ`: Deviation from the null
* `σs`: Per-group standard deviations
"""
function hypotheses(::Type{OneSampleZTest}, n::Real, δ::Real, σ::Real)
    se = sqrt(1 / n) * σ
    null = Normal(0, se)
    alt = Normal(δ, se)
    return null, alt
end

"""
Determine the null and alternate hypotheses under t-tests given:

* `ns`: Per-group sample size(s)
* `δ`: Deviation from the null
* `σs`: Per-group standard deviations
"""
function hypotheses(::Type{EqualVarianceZTest}, n::Real, δ::Real, σ::Real)
    se = sqrt(2 / n) * σ
    null = Normal(0, se)
    alt = Normal(δ, se)
    return null, alt
end

# @doc """
# Determine the values of z that lead to overestimates of the magnitude of δ.
# """ ->
thresholds(alt::Normal) = -mean(alt), mean(alt)
