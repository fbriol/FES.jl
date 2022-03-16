"""
    function remainder(x::Integer, y::Integer)::Integer

Computes the remainder of the operation x/y
Return a result with the same sign as its second operand
"""
function remainder(x::Integer, y::Integer)::Integer
    result = x % y
    return result != 0 && (result ⊻ y) < 0 ? result + y : result
end


"""
    function remainder(x::Real, y::Real)::Real

Computes the remainder of the operation x/y"""
function remainder(x::Real, y::Real)::Real
    result = x % y
    if result < 0
        result += y
    end
    return result
end

"""
    function normalize_angle(x::Real, min::Real=0.0, circle::Real=360.0)::Real

Normalize an angle between [min, min+circle["""
function normalize_angle(x::Real, min::Real=0.0, circle::Real=360.0)::Real
    return remainder(x - min, circle) + min
end

function _sum_weighting(x::Number, weight::Number)::Vector{Number}
    isnan(x) ? [0, 0, 0] : [1, x * weight, weight]
end


"""
    function bilinear_interpolation(
        x0::Number,
        x1::Number,
        y0::Number,
        y1::Number,
        x::Number,
        y::Number,
        v00::Number,
        v01::Number,
        v10::Number,
        v11::Number
    )::Tuple{Number,Int64} where T

Bilinear interpolation."""
function bilinear_interpolation(
    x0::Number,
    x1::Number,
    y0::Number,
    y1::Number,
    x::Number,
    y::Number,
    v00::Number,
    v01::Number,
    v10::Number,
    v11::Number
)::Tuple{Number,Int64} where T
    dx = 1 / (x1 - x0)
    dy = 1 / (y1 - y0)
    wx0 = (x1 - x) * dx
    wx1 = (x - x0) * dx
    wy0 = (y1 - y) * dy
    wy1 = (y - y0) * dy

    sum = _sum_weighting(v00, wx0 * wy0) + _sum_weighting(
        v01, wx0 * wy1) + _sum_weighting(
            v10, wx1 * wy0) + _sum_weighting(
                v11, wx1 * wy1)
    
    if sum[1] == 0
        return NaN, 0
    end
    sum[2] / sum[3], convert(Int64, sum[1])
end