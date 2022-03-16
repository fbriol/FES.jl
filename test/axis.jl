function test_irregular_container()
    values = [0., 1., 4., 8., 20.]
    a1 = FES.IrregularAxis(values)
    @test FES.length(a1) == 5
    @test FES.first(a1) == 0
    @test FES.last(a1) == 20
    @test FES.min_value(a1) == 0
    @test FES.max_value(a1) == 20
    @test FES.coordinate_value(a1, 3) == 4
    @test FES.find_index(a1, 8.0, false) == 4
    @test FES.find_index(a1, 8.3, false) == 4
    @test FES.find_index(a1, 30.0, true) == 5
    @test FES.find_index(a1, 20.1, true) == 5
    @test FES.find_index(a1, 30.0, false) == -1
    @test FES.IrregularAxis(values) == a1
    @test FES.IrregularAxis(values) != FES.IrregularAxis([0., 1., 4., 8.])
    
    a1 = FES.IrregularAxis(reverse(values))
    @test FES.length(a1) == 5
    @test FES.first(a1) == 20
    @test FES.last(a1) == 0
    @test FES.min_value(a1) == 0
    @test FES.max_value(a1) == 20
    @test FES.coordinate_value(a1, 2) == 8
    @test FES.find_index(a1, 8.0, false) == 2
    @test FES.find_index(a1, 8.3, false) == 2
    @test FES.find_index(a1, 30.0, true) == 1
    @test FES.find_index(a1, 20.1, true) == 1
    @test FES.find_index(a1, 30.0, false) == -1

    @test_throws DomainError FES.IrregularAxis(Vector{Float64}(undef, 0))
end

function test_regular_container()
    @test_throws DomainError a1 = FES.RegularAxis(0, 10, 0)
    a1 = FES.RegularAxis(0.0, 359.0, 360)
    @test FES.length(a1) == 360.0
    @test FES.first(a1) == 0.0
    @test FES.last(a1) == 359.0
    @test FES.min_value(a1) == 0.0
    @test FES.max_value(a1) == 359.0
    @test FES.coordinate_value(a1, 2) == 1.0
    @test FES.find_index(a1, 180.0, false) == 181
    @test FES.find_index(a1, 360.0, false) == -1
    @test FES.find_index(a1, 360.0, true) == 360
    @test FES.RegularAxis(0.0, 359.0, 360) == a1
    a1 = FES.RegularAxis(359.0, 0.0, 360)
    @test FES.RegularAxis(0.0, 359.0, 360) != a1
    @test FES.length(a1) == 360.0
    @test FES.first(a1) == 359.0
    @test FES.last(a1) == 0.0
    @test FES.min_value(a1) == 0.0
    @test FES.max_value(a1) == 359.0
    @test FES.coordinate_value(a1, 2) == 358.0
    @test FES.find_index(a1, 180.0, false) == 180
    @test FES.find_index(a1, 360.0, false) == -1
    @test FES.find_index(a1, 360.0, true) == 1
    nothing
end

function test_axis_singleton()
    a1 = FES.Axis([1.0])
    @test FES.find_index(a1, 1.0, false) == 1
    @test FES.find_index(a1, 0.0, false) == -1
    @test FES.find_index(a1, 0.0, true) == 1
    @test isnothing(FES.find_indexes(a1, 1.0)) == true
    @test FES.is_ascending(a1) == true
    @test a1.is_circle == false
    @test FES.length(a1) == 1
    @test FES.first(a1) == 1.0
    @test FES.last(a1) == 1.0
    @test FES.min_value(a1) == 1.0
    @test FES.max_value(a1) == 1.0
    @test FES.coordinate_value(a1, 1) == 1.0
    @test_throws ArgumentError FES.step(a1)
    nothing
end

# function test_axis_binary()
#     a1 = FES.Axis([0.0, 1.0])
#     indexes = FES.find_indexes(a1, 0.0)
#     @test isnothing(indexes) == false
# end

function test_axis_wrap_longitude()
    a1 = FES.Axis(Vector{Float64}(range(0, 359, 360)), true)
    @test a1 == FES.Axis(Vector{Float64}(range(0, 359, 360)), true)
    @test a1.is_circle == true
    @test a1.circle == 360
    @test FES.length(a1) == 360
    @test FES.first(a1) == 0
    @test FES.last(a1) == 359
    @test FES.min_value(a1) == 0
    @test FES.max_value(a1) == 359
    @test FES.is_ascending(a1) == true
    @test FES.coordinate_value(a1, 1) == 0.0
    @test FES.coordinate_value(a1, 181) == 180.0
    @test_throws BoundsError FES.coordinate_value(a1, 759)
    i1 = FES.find_index(a1, 0.0, false)
    @test i1 == 1
    i2 = FES.find_index(a1, 360.0, false)
    @test i2 == 1
    indexes = FES.find_indexes(a1, 360.0)
    @test indexes == (1, 2)
    indexes = FES.find_indexes(a1, 370.0)
    @test indexes == (11, 12)
    indexes = FES.find_indexes(a1, -9.5)
    @test indexes == (351, 352)

    a1 = FES.Axis(Vector{Float64}(range(359, 0, 360)), true)
    @test a1 != FES.Axis(Vector{Float64}(range(0, 359, 360)), true)
    @test a1.is_circle == true
    @test a1.circle == 360
    @test FES.length(a1) == 360
    @test FES.first(a1) == 359
    @test FES.last(a1) == 0
    @test FES.min_value(a1) == 0
    @test FES.max_value(a1) == 359
    @test FES.is_ascending(a1) == false
    @test FES.coordinate_value(a1, 1) == 359.0
    @test FES.coordinate_value(a1, 180) == 180.0
    @test_throws BoundsError FES.coordinate_value(a1, 759)
    i1 = FES.find_index(a1, 0.0, false)
    @test i1 == 360
    i2 = FES.find_index(a1, 360.0, false)
    @test i2 == 360
    i2 = FES.find_index(a1, 359.0, false)
    @test i2 == 1
    indexes = FES.find_indexes(a1, 359.5)
    @test indexes == (1, 360)
    indexes = FES.find_indexes(a1, 370.0)
    @test indexes == (350, 351)
    indexes = FES.find_indexes(a1, -9.5)
    @test indexes == (10, 9)

    a1 = FES.Axis(Vector{Float64}(range(-180, 179, 360)), true)
    @test a1.is_circle == true
    @test a1.circle == 360
    @test FES.length(a1) == 360
    @test FES.first(a1) == -180
    @test FES.last(a1) == 179
    @test FES.min_value(a1) == -180
    @test FES.max_value(a1) == 179
    @test FES.is_ascending(a1) == true
    @test FES.coordinate_value(a1, 1) == -180.0
    indexes = FES.find_indexes(a1, 370.0)
    @test indexes == (191, 192)
    @test FES.coordinate_value(a1, 190) == 9

    a1 = FES.Axis(Vector{Float64}(range(180, -179, 360)), true)
    @test a1.is_circle == true
    @test a1.circle == 360
    @test FES.length(a1) == 360
    @test FES.first(a1) == 180
    @test FES.last(a1) == -179
    @test FES.min_value(a1) == -179
    @test FES.max_value(a1) == 180
    @test FES.coordinate_value(a1, 1) == 180.0
    @test FES.coordinate_value(a1, 181) == 0
    nothing
end

function test_irregular_axis()
    points = [-89.000000, -88.908818, -88.809323, -88.700757, -88.582294,
        -88.453032, -88.311987, -88.158087, -87.990161, -87.806932, -87.607008,
        -87.388869, -87.150861, -86.891178, -86.607851, -86.298736, -85.961495,
        -85.593582, -85.192224, -84.754402, -84.276831, -83.755939, -83.187844,
        -82.568330, -81.892820, -81.156357, -80.353575, -79.478674, -78.525397,
        -77.487013, -76.356296, -75.125518, -73.786444, -72.330344, -70.748017,
        -69.029837, -67.165823, -65.145744, -62.959262, -60.596124, -58.046413,
        -55.300856, -52.351206, -49.190700, -45.814573, -42.220632, -38.409866,
        -34.387043, -30.161252, -25.746331, -21.161107, -16.429384, -11.579629,
        -6.644331, -1.659041, 3.338836, 8.311423, 13.221792, 18.035297,
        22.720709, 27.251074, 31.604243, 35.763079, 39.715378, 43.453560,
        46.974192, 50.277423, 53.366377, 56.246554, 58.925270, 61.411164,
        63.713764, 65.843134, 67.809578, 69.623418, 71.294813, 72.833637,
        74.249378, 75.551083, 76.747318, 77.846146, 78.855128, 79.781321,
        80.631294, 81.411149, 82.126535, 82.782681, 83.384411, 83.936179,
        84.442084, 84.905904, 85.331111, 85.720897, 86.078198, 86.405707,
        86.705898, 86.981044, 87.233227, 87.464359, 87.676195, 87.870342,
        88.048275, 88.211348, 88.360799, 88.497766, 88.623291, 88.738328,
        88.843755, 88.940374]
    a1 = FES.Axis(points, false)
    @test_throws ArgumentError FES.step(a1)
    @test FES.first(a1) == first(points)
    @test FES.last(a1) == last(points)
    @test FES.length(a1) == length(points)
    @test FES.min_value(a1) == minimum(points)
    @test FES.max_value(a1) == maximum(points)
    @test a1.is_circle == false
    @test isnothing(a1.circle) == true
    @test FES.is_ascending(a1) == true
    @test FES.coordinate_value(a1, 1) == first(points)
    @test FES.coordinate_value(a1, length(points)) == last(points)
    @test FES.coordinate_value(a1, 108) == points[108]
    i1 = FES.find_index(a1, -1.659041, false)
    @test i1 == 55
    i1 = FES.find_index(a1, -88.700757, false)
    @test i1 == 4
    i1 = FES.find_index(a1, 88.497766, false)
    @test i1 == 105
    i1 = FES.find_index(a1, 0.0, false)
    @test i1 == 55
    i1 = FES.find_index(a1, -90.0, false)
    @test i1 == -1
    i1 = FES.find_index(a1, -90.0, true)
    @test i1 == 1
    i1 = FES.find_index(a1, 90.0, false)
    @test i1 == -1
    i1 = FES.find_index(a1, 90.0, true)
    @test i1 == 109
    indexes = FES.find_indexes(a1, 60.0)
    @test indexes == (70, 71)

    a1 = FES.Axis(reverse(points))
    @test_throws ArgumentError FES.step(a1)
    @test FES.first(a1) == last(points)
    @test FES.last(a1) == first(points)
    @test FES.length(a1) == length(points)
    @test FES.min_value(a1) == minimum(points)
    @test FES.max_value(a1) == maximum(points)
    @test a1.is_circle == false
    @test isnothing(a1.circle) == true
    @test FES.is_ascending(a1) == false
    @test FES.coordinate_value(a1, 1) == last(points)
    @test FES.coordinate_value(a1, length(points)) == first(points)
    @test FES.coordinate_value(a1, 108) == points[length(points) - 108 + 1]
    i1 = FES.find_index(a1, -1.659041, false)
    @test i1 == 55
    i1 = FES.find_index(a1, -88.700757, false)
    @test i1 == 106
    i1 = FES.find_index(a1, 88.497766, false)
    @test i1 == 5
    i1 = FES.find_index(a1, 0.0, false)
    @test i1 == 55
    i1 = FES.find_index(a1, -90.0, false)
    @test i1 == -1
    i1 = FES.find_index(a1, -90.0, true)
    @test i1 == 109
    i1 = FES.find_index(a1, 90.0, false)
    @test i1 == -1
    i1 = FES.find_index(a1, 90.0, true)
    @test i1 == 1
    indexes = FES.find_indexes(a1, 60.0)
    @test indexes == (40, 39)
    nothing
end

function test_search_indexes()
    a1 = FES.Axis(Vector(range(0, 359, 360)), true)
    indexes = FES.find_indexes(a1, 359.4)
    @test indexes == (360, 1)
    indexes = FES.find_indexes(a1, 359.6)
    @test indexes == (360, 1)
    indexes = FES.find_indexes(a1, -0.1)
    @test indexes == (360, 1)
    indexes = FES.find_indexes(a1, 359.9)
    @test indexes == (360, 1)
    indexes = FES.find_indexes(a1, 0.1)
    @test indexes == (1, 2)    
    indexes = FES.find_indexes(a1, 358.9)
    @test indexes == (359, 360)

    a1 = FES.Axis(Vector(range(359, 0, 360)), true)
    indexes = FES.find_indexes(a1, 359.4)
    @test indexes == (1, 360)
    indexes = FES.find_indexes(a1, 359.6)
    @test indexes == (360, 1)
    indexes = FES.find_indexes(a1, -0.1)
    @test indexes == (360, 1)
    indexes = FES.find_indexes(a1, 359.9)
    @test indexes == (360, 1)
    indexes = FES.find_indexes(a1, 0.1)
    @test indexes == (360, 359)    
    indexes = FES.find_indexes(a1, 358.9)
    @test indexes == (2, 1)
    nothing
end
