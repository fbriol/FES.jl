function check_admittance(r::Float64, index::Int64, wt::FES.WaveTable)
    FES.admittance!(wt)
    @test wt.waves[index].tide ≈ r + r * im atol=1e-6

    wt.waves[index].admittance = false
    wt.waves[index].tide = 1 + 1im
    FES.admittance!(wt)
    @test wt.waves[index].tide == 1 + 1im
  
    wt.waves[index].admittance = true      
end

function test_wave_table()
    wt = FES.WaveTable()
    @test length(wt.waves) == 67
    @test FES.find(wt, "M2") == wt.waves[Int64(FES.kM2)]

    for item in wt.waves
        item.tide = 1 + 1im
    end

    check_admittance(0.2378, Int64(FES.k2Q1), wt)
    check_admittance(0.2706, Int64(FES.kSigma1), wt)
    check_admittance(0.1688, Int64(FES.kRho1), wt)
    check_admittance(0.0671, Int64(FES.kM11), wt)
    check_admittance(0.0241, Int64(FES.kM12), wt)
    check_admittance(0.0124, Int64(FES.kChi1), wt)
    check_admittance(0.0201, Int64(FES.kPi1), wt)
    check_admittance(0.0137, Int64(FES.kPhi1), wt)
    check_admittance(0.009, Int64(FES.kTheta1), wt)
    check_admittance(0.0447, Int64(FES.kJ1), wt)
    check_admittance(0.0182, Int64(FES.kOO1), wt)
    check_admittance(0.0796782, Int64(FES.kEta2), wt)
    check_admittance(0.374697218357, Int64(FES.kMu2), wt)
    check_admittance(0.157529811402, Int64(FES.kNu2), wt)
    check_admittance(0.010949128375, Int64(FES.kLambda2), wt)
    check_admittance(0.053354227357, Int64(FES.kL2), wt)
    check_admittance(0.16871051505, Int64(FES.kT2), wt)
    check_admittance(0.2387, Int64(FES.k2N2), wt)
    check_admittance(0.094151295, Int64(FES.kEps2), wt)
    # force 2N2 to be calculated in dynamically
    wt.waves[Int64(FES.k2N2)].admittance = false
    wt.waves[Int64(FES.k2N2)].tide = 1 + 1im
    check_admittance(0.499810, Int64(FES.kEps2), wt)
    nothing
end

