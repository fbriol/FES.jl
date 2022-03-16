function test_wave_order2()
    a = FES.AstronomicAngle(DateTime(1950, 1, 1))
    w2nd = FES.WaveOrder2()
    @test size(w2nd.data) == (106, 6)
    @test FES.lpe_minus_n_waves(w2nd, a, 45.0) ≈ 1.28500737768 atol=1e-6

    wt = FES.WaveTable()
    wt.waves[Int64(FES.kMm)].dynamic = true
    wt.waves[Int64(FES.kMf)].dynamic = true
    wt.waves[Int64(FES.kMtm)].dynamic = true
    wt.waves[Int64(FES.kMsqm)].dynamic = true
    w2nd = FES.WaveOrder2();
    FES.disable_dynamic_wave!(w2nd, wt)
    a = FES.AstronomicAngle(DateTime(2000, 1, 1))
    @test FES.lpe_minus_n_waves(w2nd, a, 1.0) ≈ -0.340408192895 atol=1e-6
    nothing
end
