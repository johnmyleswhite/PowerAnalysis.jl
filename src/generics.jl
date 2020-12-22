"""
Compute the power of a test without checking arguments. Useful inside of loops
that need to evaluate the power of many proposed designs.
"""
function analytic_power(
    ::Type{T},
    ns::Union{Real, Tuple},
    δ::Real,
    σs::Union{Real, Tuple},
    α::Real,
    one_sided::Bool,
) where {T}
    null, alt = hypotheses(T, ns, δ, σs)
    if one_sided
        c_r = cquantile(null, α)
        return ccdf(alt, c_r)
    else
        c_l = quantile(null, α / 2)
        c_r = cquantile(null, α / 2)
        return cdf(alt, c_l) + ccdf(alt, c_r)
    end
end

"""
Compute the power of a test. Users must specify:

* `ns`: Per-group sample size(s)
* `δ`: Deviation from the null
* `σs`: Per-group standard deviations
* `α`: Significance level (defaults to 0.05)
* `one_sided`: Is the test one-sided? (defaults to false)
"""
function power(
    ::Type{T},
    ns::Union{Real, Tuple},
    δ::Real,
    σs::Union{Real, Tuple},
    α::Real = 0.05,
    one_sided::Bool = false,
) where {T}
    check_args(ns, δ, σs, 0.8, α)
    return analytic_power(T, ns, δ, σs, α, one_sided)
end

"""
Compute the smallest effect size measurable using a test. Users must specify:

* `ns`: Per-group sample size(s)
* `p`: Desired power
* `α`: Significance level (defaults to 0.05)
* `one_sided`: Is the test one-sided? (defaults to false)
"""
function effect_size(
    ::Type{T},
    ns::Union{Real, Tuple},
    p::Real,
    α::Real = 0.05,
    one_sided::Bool = false,
) where {T}
    check_args(ns, 1.0, 1.0, p, α)
    gap(δ::Real) = analytic_power(T, ns, δ, 1.0, α, one_sided) - p
    return fzero(gap, 1e-8, 100.0)
end

"""
Compute the smallest sample size that allows using a test to measure a
specified effect. Users must specify:

* `δ`: Deviation from the null
* `σs`: Per-group standard deviations
* `p`: Desired power
* `α`: Significance level (defaults to 0.05)
* `one_sided`: Is the test one-sided? (defaults to false)
"""
function sample_size(
    ::Type{T},
    δ::Real,
    σs::Union{Real, Tuple},
    p::Real,
    α::Real = 0.05,
    one_sided::Bool = false,
) where {T}
    check_args(2, δ, σs, p, α)
    gap(n::Real) = analytic_power(T, n, δ, σs, α, one_sided) - p
    return fzero(gap, 2.0, 1.0e12)
end

"""
Compute the type 1 error rate of a test. Users must specify:

* `ns`: Per-group sample size(s)
* `δ`: Deviation from the null
* `σs`: Per-group standard deviations
* `α`: Significance level (defaults to 0.05)
* `one_sided`: Is the test one-sided? (defaults to false)
"""
function type_1(
    ::Type{T},
    ns::Union{Real, Tuple},
    δ::Real,
    σs::Union{Real, Tuple},
    α::Real = 0.05,
    one_sided::Bool = false,
) where {T}
    check_args(ns, δ, σs, 0.8, α)
    return α
end

"""
Compute the type 2 error rate of a test. Users must specify:

* `ns`: Per-group sample size(s)
* `δ`: Deviation from the null
* `σs`: Per-group standard deviations
* `α`: Significance level (defaults to 0.05)
* `one_sided`: Is the test one-sided? (defaults to false)
"""
function type_2(
    ::Type{T},
    ns::Union{Real, Tuple},
    δ::Real,
    σs::Union{Real, Tuple},
    α::Real = 0.05,
    one_sided::Bool = false,
) where {T}
    check_args(ns, δ, σs, 0.8, α)
    return 1 - power(T, ns, δ, σs, α, one_sided)
end

"""
Compute the type S error rate of a test. Users must specify:

* `ns`: Per-group sample size(s)
* `δ`: Deviation from the null
* `σs`: Per-group standard deviations
* `α`: Significance level (defaults to 0.05)
* `one_sided`: Is the test one-sided? (defaults to false)
"""
function type_s(
    ::Type{T},
    ns::Union{Real, Tuple},
    δ::Real,
    σs::Union{Real, Tuple},
    α::Real = 0.05,
) where {T}
    check_args(ns, δ, σs, 0.8, α)
    null, alt = hypotheses(T, ns, δ, σs)
    c_l, c_r = quantile(null, α / 2), cquantile(null, α / 2)
    p_l, p_r = cdf(alt, c_l), ccdf(alt, c_r)
    return p_l / (p_l + p_r)
end

"""
Compute the type M error rate of a test. Users must specify:

* `ns`: Per-group sample size(s)
* `δ`: Deviation from the null
* `σs`: Per-group standard deviations
* `α`: Significance level (defaults to 0.05)
* `one_sided`: Is the test one-sided? (defaults to false)
"""
function type_m(
    ::Type{T},
    ns::Union{Real, Tuple},
    δ::Real,
    σs::Union{Real, Tuple},
    α::Real = 0.05,
    one_sided::Bool = false,
) where {T}
    check_args(ns, δ, σs, 0.8, α)
    null, alt = hypotheses(T, ns, δ, σs)
    if one_sided
        c_r = cquantile(null, α)
        t_l, t_r = thresholds(alt)
        p_significant = ccdf(alt, c_r)
        p_overestimate = ccdf(alt, max(c_r, t_r))
        return p_overestimate / p_significant
    else
        c_l, c_r = quantile(null, α / 2), cquantile(null, α / 2)
        t_l, t_r = thresholds(alt)
        p_significant = cdf(alt, c_l) + ccdf(alt, c_r)
        p_overestimate = cdf(alt, min(c_l, t_l)) + ccdf(alt, max(c_r, t_r))
        return p_overestimate / p_significant
    end
end

"""
Compute the average exaggeration factor of a test. Users must specify:

* `ns`: Per-group sample size(s)
* `δ`: Deviation from the null
* `σs`: Per-group standard deviations
* `α`: Significance level (defaults to 0.05)
* `one_sided`: Is the test one-sided? (defaults to false)
"""
function exaggeration_factor(
    ::Type{T},
    ns::Union{Real, Tuple},
    δ::Real,
    σs::Union{Real, Tuple},
    α::Real = 0.05,
    one_sided::Bool = false,
    bounds::Real = 1e-8,
    tol::Real = 1e-8,
) where {T}
    check_args(ns, δ, σs, 0.8, α)
    null, alt = hypotheses(T, ns, δ, σs)
    if one_sided
        c_r = cquantile(null, α)
        t_l, t_r = thresholds(alt)
        p_significant = ccdf(alt, c_r)
        f0(t) = (t / t_r) * (pdf(alt, t) / p_significant)
        i_r = cquantile(alt, bounds)
        e_r = gauss(f0, c_r, i_r, rtol = tol)[1]
        return e_r
    else
        c_l, c_r = quantile(null, α / 2), cquantile(null, α / 2)
        t_l, t_r = thresholds(alt)
        p_significant = cdf(alt, c_l) + ccdf(alt, c_r)
        f1(t) = (t / t_l) * (pdf(alt, t) / p_significant)
        f2(t) = (t / t_r) * (pdf(alt, t) / p_significant)
        i_l, i_r = quantile(alt, bounds), cquantile(alt, bounds)
        e_l = gauss(f1, i_l, c_l, rtol = tol)[1]
        e_r = gauss(f2, c_r, i_r, rtol = tol)[1]
        return e_l + e_r
    end
end
