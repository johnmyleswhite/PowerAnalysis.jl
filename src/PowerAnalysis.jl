module PowerAnalysis
    using Docile
    @docstrings

    using Distributions, HypothesisTests, Roots

    # TODO: Move z-tests into HypothesisTests
    abstract OneSampleZTest
    abstract EqualVarianceZTest
    export OneSampleZTest, EqualVarianceZTest

    export
        power,
        effect_size,
        sample_size,
        type_1,
        type_2,
        type_s,
        type_m,
        exaggeration_factor

    include("utils.jl")
    include("generics.jl")
    include("t_test.jl")
    include("z_test.jl")
end
