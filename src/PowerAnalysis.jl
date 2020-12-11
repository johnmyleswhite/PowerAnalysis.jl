module PowerAnalysis
    using Distributions
    using HypothesisTests
    using Roots

    # TODO: Move z-tests into HypothesisTests
    abstract type OneSampleZTest end
    abstract type EqualVarianceZTest end
    
    export OneSampleZTest
           EqualVarianceZTest

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
