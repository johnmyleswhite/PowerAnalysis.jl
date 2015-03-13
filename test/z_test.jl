module TestZTest
    using Base.Test
    using PowerAnalysis
    using HypothesisTests

    # OneSampleZTest tests
    # Loop over n, d, p, s, two_sided values
    # TODO: Test one-sided vs two-sided
    params = (
        (33.36712895331925, 0.5, 0.80, 0.05, false),
        (43.995480906737704, 0.5, 0.90, 0.05, false),
        (53.940614296961286, 0.5, 0.95, 0.05, false),
        (16, 0.7494656445134399, 0.8, 0.05, false),
        (32, 0.5112738234562735, 0.8, 0.05, false),
        (64, 0.35565012796825096, 0.8, 0.05, false),
        (16, 0.5, 0.46487, 0.05, false),
        (32, 0.5, 0.782276, 0.05, false),
        (64, 0.5, 0.9760556, 0.05, false),
    )

    for (n, d, p, s, one_sided) in params
        p_z = power(OneSampleZTest, n, d, 1.0, s, one_sided)
        p_t = power(OneSampleTTest, n, d, 1.0, s, one_sided)
        n_z = sample_size(OneSampleZTest, d, 1.0, p, s, one_sided)
        n_t = sample_size(OneSampleTTest, d, 1.0, p, s, one_sided)
        d_z = effect_size(OneSampleZTest, n, p, s, one_sided)
        d_t = effect_size(OneSampleTTest, n, p, s, one_sided)
        # TODO: Get non-stupid bounds here on gap between z-test and t-test
        @test 0.9 * p_z < p_t < p_z
        @test 0.8 * n_t < n_z < n_t
        @test 0.9 * d_t < d_z < d_t
    end

    # EqualVarianceZTest tests
    # Loop over n, d, p, s, two_sided values
    # TODO: Test one-sided vs two-sided
    params = (
        (63.76561019093564, 0.5, 0.80, 0.05, false),
        (85.03128413735288, 0.5, 0.90, 0.05, false),
        (104.92794298436287, 0.5, 0.95, 0.05, false),
        (16, 1.0236637440012688, 0.8, 0.05, false),
        (32, 0.7114799360863416, 0.8, 0.05, false),
        (64, 0.4990691779657755, 0.8, 0.05, false),
        (16, 0.5, 0.2777445, 0.05, false),
        (32, 0.5, 0.5036382, 0.05, false),
        (64, 0.5, 0.8014596, 0.05, false),
    )

    for (n, d, p, s, one_sided) in params
        p_z = power(EqualVarianceZTest, n, d, 1.0, s, one_sided)
        p_t = power(EqualVarianceTTest, n, d, 1.0, s, one_sided)
        n_z = sample_size(EqualVarianceZTest, d, 1.0, p, s, one_sided)
        n_t = sample_size(EqualVarianceTTest, d, 1.0, p, s, one_sided)
        d_z = effect_size(EqualVarianceZTest, n, p, s, one_sided)
        d_t = effect_size(EqualVarianceTTest, n, p, s, one_sided)
        # TODO: Get non-stupid bounds here on gap between z-test and t-test
        @test 0.9 * p_z < p_t < p_z
        @test 0.8 * n_t < n_z < n_t
        @test 0.9 * d_t < d_z < d_t
    end
end
