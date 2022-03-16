using Dates
using Test
using FES

include("math.jl")
include("axis.jl")
include("angle.jl")
include("astronomic_angle.jl")
include("wave.jl")
include("wave_table.jl")
include("wave_order2.jl")
include("tide.jl")

@testset verbose=true "FES.jl" begin
    @testset "mathematical functions" begin
        test_bilinear_interpolation()
    end
    @testset "axis containers" begin
        test_irregular_container()
        test_regular_container()
    end 
    @testset "axis" begin
        test_axis_singleton()
        test_axis_wrap_longitude()
        test_irregular_axis()
        test_search_indexes()
    end
    @testset "astronomic angle properties" begin
        test_speed()
        test_frequency()
    end
    @testset "astronomic angles" begin
        test_astronomic_angle()
    end
    @testset "tidal waves" begin
        test_wave()
    end
    @testset "wave table" begin
        test_wave_table()
    end
    @testset "wave order 2" begin
        test_wave_order2()
    end
    @testset "tide prediction" begin
        test_tide_prediction()
    end
end
