"""
Determine the null and alternate hypotheses under t-tests given:

* `ns`: Per-group sample size(s)
* `δ`: Deviation from the null
* `σs`: Per-group standard deviations
"""
function hypotheses(::Type{OneSampleTTest}, n::Real, δ::Real, σ::Real)
    df = n - 1
    ncp = sqrt(n) * δ / σ
    null = TDist(df)
    alt = NoncentralT(df, ncp)
    return null, alt
end

"""
Determine the null and alternate hypotheses under t-tests given:

* `ns`: Per-group sample size(s)
* `δ`: Deviation from the null
* `σs`: Per-group standard deviations
"""
function hypotheses(::Type{EqualVarianceTTest}, n::Real, δ::Real, σ::Real)
    df = 2 * n - 2
    ncp = sqrt(n / 2) * δ / σ
    null = TDist(df)
    alt = NoncentralT(df, ncp)
    return null, alt
end

"""
Determine the null and alternate hypotheses under t-tests given:

* `ns`: Per-group sample size(s)
* `δ`: Deviation from the null
* `σs`: Per-group standard deviations
"""
function hypotheses(::Type{EqualVarianceTTest}, ns::Tuple, δ::Real, σ::Real)
    n1, n2 = ns[1], ns[2]
    df = n1 + n2 - 2
    ncp = (1 / sqrt(1 / n1 + 1 / n2)) * δ / σ
    null = TDist(df)
    alt = NoncentralT(df, ncp)
    return null, alt
end

# @doc """
# Determine the values of t that lead to overestimates of the magnitude of δ.
# """ ->
thresholds(alt::NoncentralT) = -alt.λ, alt.λ
