function test_speed()
    speed = FES.Speed()

    @test speed.tau ≈ 14.4920521070043 atol=1e-6
    @test speed.s ≈ 0.5490165320557 atol=1e-6
    @test speed.h ≈ 0.0410686390600 atol=1e-6
    @test speed.p ≈ 0.0046418343600 atol=1e-6
    @test speed.n ≈ -0.0022064134155 atol=1e-6
    @test speed.p1 ≈ 0.00000196098563 atol=1e-6
    nothing
end

function  test_frequency()
    freq = FES.Frequency()

    @test freq.tau ≈ 0.040255700297 atol=1e-6
    @test freq.s ≈ 0.001525045922 atol=1e-6
    @test freq.h ≈ 0.000114079553 atol=1e-6
    @test freq.p ≈ 0.000012893984 atol=1e-6
    @test freq.n ≈ -0.000006128926 atol=1e-6
    @test freq.p1 ≈ 0.000000005447 atol=1e-6
    nothing
end

