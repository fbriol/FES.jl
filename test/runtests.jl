using Dates
using Test
using FES


@testset "FES" begin
    include("math.jl")
    include("axis.jl")
    include("angle.jl")
    include("astronomic_angle.jl")
    include("wave.jl")
    include("wave_table.jl")
    include("wave_order2.jl")
    include("tide.jl")
end
nothing
