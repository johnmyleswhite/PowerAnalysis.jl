@testset "TestTTest" begin

    # OneSampleTTest tests
    # Loop over n, d, p, s and one_sided
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
        p_est = power(OneSampleTTest, n, d, 1.0, s, one_sided)
        n_est = sample_size(OneSampleTTest, d, 1.0, p, s, one_sided)
        d_est = effect_size(OneSampleTTest, n, p, s, one_sided)

        @test abs(p_est - p) < 1e-4
        @test abs(n_est - n) < 1e-4
        @test abs(d_est - d) < 1e-4
    end

    # EqualVarianceTTest tests
    # Loop over n, d, p, s and one_sided
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
        p_est = power(EqualVarianceTTest, n, d, 1.0, s, one_sided)
        n_est = sample_size(EqualVarianceTTest, d, 1.0, p, s, one_sided)
        d_est = effect_size(EqualVarianceTTest, n, p, s, one_sided)

        @test abs(p_est - p) < 1e-4
        @test abs(n_est - n) < 1e-4
        @test abs(d_est - d) < 1e-4
    end
end
