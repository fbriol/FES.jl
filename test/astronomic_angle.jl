function test_astronomic_angle()
    a = FES.AstronomicAngle(DateTime(1900, 1, 1))

    @test a.t ≈ 3.14159265359 atol=1e-6
    @test a.h ≈ 4.8902293307 atol=1e-6
    @test a.s ≈ 4.83500919185 atol=1e-6
    @test a.p1 ≈ 4.90822987644 atol=1e-6
    @test a.p ≈ 5.8360969035 atol=1e-6
    @test a.i ≈ 0.401668407249 atol=1e-6
    @test a.xi ≈ -0.208946712189 atol=1e-6
    @test a.nu ≈ -0.227235371854 atol=1e-6
    @test a.x1ra ≈ 0.787307935551 atol=1e-6
    @test a.r ≈ -0.145318382345 atol=1e-6
    @test a.nuprim ≈ -0.155257427004 atol=1e-6
    @test a.nusec ≈ -0.154608130984 atol=1e-6
    
    a = FES.AstronomicAngle(DateTime(2000, 1, 1))
    
    @test a.h ≈ 4.886452089967941 atol=1e-6
    @test a.n ≈ 2.182860931126595 atol=1e-6
    @test a.nu ≈ 0.20722218671046477 atol=1e-6
    @test a.nuprim ≈ 0.13806065629468897 atol=1e-6
    @test a.nusec ≈ 0.13226438100551682 atol=1e-6
    @test a.p ≈ 1.4537576754171415 atol=1e-6
    @test a.p1 ≈ 4.938242223271549 atol=1e-6
    @test a.r ≈ 0.1010709894525481 atol=1e-6
    @test a.s ≈ 3.6956255851976114 atol=1e-6
    @test a.t ≈ 3.1415926536073755 atol=1e-6
    @test a.x1ra ≈ 1.1723206438502318 atol=1e-6
    @test a.xi ≈ 0.1920359426758722 atol=1e-6    
    nothing
end
