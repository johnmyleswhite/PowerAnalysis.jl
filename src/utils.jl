"""
Check that user-facing function arguments satisfy assumptions made in code:

* Per-group sample size is at least 2
* The deviation from the null is strictly positive
* The variance in each group is strictly positive
* The power is between 0 and 1
* The significance level is between 0 and 1
"""
function check_args(
    ns::Union{Real, Tuple},
    δ::Real,
    σs::Union{Real, Tuple},
    p::Real,
    α::Real,
)
    if isa(ns, Real)
        if !(2.0 <= ns < Inf)
            error("sample size must be in [2.0, Inf)")
        end
    else
        if !(2.0 <= min(ns...) < Inf)
            error("sample sizes must both be in [2.0, Inf)")
        end
    end

    if !(0.0 < δ < Inf)
        error("δ must be in (0.0, Inf)")
    end

    if isa(σs, Real)
        if !(0.0 < σs < Inf)
            error("σ must be in (0.0, Inf)")
        end
    else
        if !(0.0 < min(σs...) < Inf)
            error("σs must both be in (0.0, Inf)")
        end
    end

    if !(0.0 < p < 1.0)
        error("power must be in (0.0, 1.0)")
    end

    if !(0.0 < α < 1.0)
        error("α must be in (0.0, 1.0)")
    end
end
