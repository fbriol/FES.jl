function test_bilinear_interpolation()
    r, n = FES.bilinear_interpolation(
        0.0, 1.0, 0.0, 1.0, 0.5, 0.5, 0.0, 1.0, 2.0, 3.0)
    @test r == 1.5
    @test n == 4

    r, n = FES.bilinear_interpolation(
        0.0, 1.0, 0.0, 1.0, 0.5, 0.5, NaN, 1.0, 2.0, 3.0)
    @test r == 2
    @test n == 3


    r, n = FES.bilinear_interpolation(
        0.0, 1.0, 0.0, 1.0, 0.5, 0.5, 0 + 0im, 1.0 + 0im, 2.0 + 0im, 3.0 + 0im)
    @test r == 1.5 + 0im
    @test n == 4
end

test_bilinear_interpolation()