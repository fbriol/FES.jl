import Base: length, first, last, ==, !=

"""
    _is_evenly_spaced(
        points::Vector{T},
        epsilon::T
    )::Union{T,Nothing} where {T<:Real}


Determines whether the values contained in the vector are evenly spaced
from each other.
"""
function _is_evenly_spaced(
    points::Vector{T},
    epsilon::T
)::Union{T,Nothing} where {T<:Real}
    n = length(points)

    # The axis is defined by a single value.
    if n < 2
        return nothing
    end

    increment = (last(points) - first(points)) / (n - 1)

    # If the first two values are constant, the values are not evenly spaced.
    if abs(increment) <= epsilon
        return nothing
    end

    for ix in 2:n
        if !isapprox(points[ix] - points[ix-1], increment, atol = epsilon)
            return nothing
        end
    end
    return increment
end

"""Abstract class for an axis."""
abstract type AbstractAxis{T<:Real} end

"""
    RegularAxis(start::T, stop::T, size::Int64)

Represents a container for an regularly spaced axis."""
struct RegularAxis{T<:Real} <: AbstractAxis{T}
    size::Int64
    start::T
    step::T
    is_ascending::Bool

    function RegularAxis(start::T, stop::T, size::Int64) where {T<:Real}
        if size <= 0
            throw(DomainError(size, "size must be positive"))
        end
        step = size == 1 ? stop - start : (stop - start) / (size - 1)
        is_ascending = size < 2 ? true : start < stop
        new{T}(size, start, step, is_ascending)
    end
end

==(self::RegularAxis{T}, other::RegularAxis{T}) where {T<:Real} = (
    self.size == other.size &&
    self.start == other.start &&
    self.step == other.step &&
    self.is_ascending == other.is_ascending)

"""
    coordinate_value(self::RegularAxis, index::Int64)::Real

Get the ith coordinate value"""
function coordinate_value(self::RegularAxis, index::Int64)::Real
    if index < 1 || index >= self.size + 1
        throw(BoundsError(self, index))
    end
    self.start + (index - 1) * self.step
end

"""
    length(self::RegularAxis)::Int64

Return the number of coordinates in the axis."""
length(self::RegularAxis)::Int64 = self.size

"""
    min_value(self::RegularAxis)::Real

Return the minimum value in the axis."""
min_value(self::RegularAxis)::Real = coordinate_value(
    self, self.is_ascending ? 1 : self.size)

"""
    max_value(self::RegularAxis)::Real

Return the maximum value in the axis."""
max_value(self::RegularAxis)::Real = coordinate_value(
    self, self.is_ascending ? self.size : 1)

"""
    first(self::RegularAxis)::Real

Return the first value in the axis."""
first(self::RegularAxis)::Real = self.start

"""
    last(self::RegularAxis)::Real

Return the last value in the axis."""
last(self::RegularAxis)::Real = coordinate_value(self, self.size)

"""
    find_index(
        self::RegularAxis{T},
        coordinate::T,
        bounded::Bool = false
    ) where {T<:Real}

Search for the index corresponding to the requested value."""
function find_index(
    self::RegularAxis{T},
    coordinate::T,
    bounded::Bool = false
) where {T<:Real}
    index = Int64(round((coordinate - self.start) * (1 / self.step))) + 1

    if index < 1
        return bounded ? 1 : -1
    end

    if index > self.size
        return bounded ? self.size : -1
    end

    return index
end

"""
    IrregularAxis(points::Vector{T}) where {T<:Real}

Represents a container for an regularly spaced axis."""
struct IrregularAxis{T<:Real} <: AbstractAxis{T}
    points::Vector{T}
    is_ascending::Bool

    function IrregularAxis(points::Vector{T}) where {T<:Real}
        if length(points) == 0
            throw(DomainError(points, "points must be non-empty"))
        end
        is_ascending = length(points) > 2 ? points[1] < points[2] : true
        new{T}(points, is_ascending)
    end
end

==(self::IrregularAxis{T}, other::IrregularAxis{T}) where {T<:Real} = (
    self.points == other.points)

"""
    is_monotonic(self::IrregularAxis{T})::Bool where {T<:Real}

Test whether the axis is monotonic."""
function is_monotonic(self::IrregularAxis{T})::Bool where {T<:Real}
    if length(unique(self.points)) != length(self.points)
        return false
    end
    issorted(self.points, rev = !self.is_ascending)
end

"""
    coordinate_value(self::IrregularAxis, index::Int64)::Real

Get the ith coordinate value"""
coordinate_value(self::IrregularAxis, index::Int64)::Real = self.points[index]

"""
    length(self::IrregularAxis)::Int64

Return the number of coordinates in the axis."""
length(self::IrregularAxis)::Int64 = Base.length(self.points)


"""
    min_value(self::IrregularAxis)::Real

Return the minimum value in the axis."""
min_value(self::IrregularAxis)::Real = self.is_ascending ? first(
    self.points) : last(self.points)

"""
    max_value(self::IrregularAxis)::Real

Return the maximum value in the axis."""
max_value(self::IrregularAxis)::Real = self.is_ascending ? last(
    self.points) : first(self.points)

"""
    first(self::IrregularAxis)::Real

Return the first value in the axis."""

first(self::IrregularAxis)::Real = Base.first(self.points)

"""
    last(self::IrregularAxis)::Real

Return the last value in the axis."""
last(self::IrregularAxis)::Real = Base.last(self.points)

"""
    find_index(
        self::IrregularAxis{T},
        coordinate::T,
        bounded::Bool = false
    ) where {T<:Real}

Search for the index corresponding to the requested value."""
function find_index(
    self::IrregularAxis{T},
    coordinate::T,
    bounded::Bool = false
) where {T<:Real}
    if self.is_ascending
        if coordinate < first(self.points)
            return bounded ? 1 : -1
        end
        if coordinate > last(self.points)
            return bounded ? length(self.points) : -1
        end
    else
        if coordinate < last(self.points)
            return bounded ? length(self.points) : -1
        end
        if coordinate > first(self.points)
            return bounded ? 1 : -1
        end
    end

    i0 = searchsortedfirst(self.points, coordinate, rev = !self.is_ascending)
    if self.points[i0] == coordinate
        return i0
    end
    i1 = self.is_ascending ? i0 - 1 : i0 + 1
    abs(self.points[i0] - coordinate) < abs(self.points[i1] - coordinate) ? i0 : i1
end

"""
    Axis(
        values::Array{T,1},
        angular::Bool = false,
        epsilon::T = convert(T, 1e-6)
    ) where {T<:Real}

A coordinate axis is a Variable that specifies one of the coordinates
of a variable's values.
"""
struct Axis{T<:Real}
    container::AbstractAxis{T}
    circle::Union{T,Nothing}
    is_circle::Bool

    function Axis(
        values::Array{T,1},
        angular::Bool = false,
        epsilon::T = convert(T, 1e-6)
    ) where {T<:Real}
        if length(values) == 0
            throw(DomainError(values, "Axis must have at least one value"))
        end
        circle = angular ? 360 : nothing
        step = _is_evenly_spaced(values, epsilon)
        is_circle = false

        if isnothing(step)
            container = IrregularAxis(values)
            if !is_monotonic(container)
                throw(DomainError(values, "Axis must be monotonic"))
            end
            if !isnothing(circle)
                increment = (last(container) - first(container)) / (length(container) - 1)
                is_circle = abs((max_value(container) - min_value(container)) - circle) <= increment
            end
        else
            container = RegularAxis(first(values), last(values), length(values))
            if !isnothing(circle)
                is_circle = isapprox(abs(container.step * length(container)), circle, atol = epsilon)
            end
        end
        new{T}(container, circle, is_circle)
    end
end

==(self::Axis{T}, other::Axis{T}) where {T<:Real} = (self.container == other.container &&
                                                     self.circle == other.circle &&
                                                     self.is_circle == other.is_circle)

"""
    length(self::Axis)::Int64

Return the number of coordinates in the axis."""
length(self::Axis)::Int64 = Base.length(self.container)

"""
    min_value(self::Axis)::Real

Return the minimum value in the axis."""
min_value(self::Axis)::Real = min_value(self.container)

"""
    max_value(self::Axis)::Real

Return the maximum value in the axis."""
max_value(self::Axis)::Real = max_value(self.container)

"""
    first(self::Axis)::Real

Return the first value in the axis."""
first(self::Axis)::Real = first(self.container)

"""
    last(self::Axis)::Real

Return the last value in the axis."""
last(self::Axis)::Real = last(self.container)

"""
    is_ascending(self::Axis)::Bool

Return true if the values of the axis are ascending."""
is_ascending(self::Axis)::Bool = self.container.is_ascending

"""
    coordinate_value(self::Axis, index::Int64)::Real

Get the ith coordinate value"""
coordinate_value(self::Axis, index::Int64)::Real = coordinate_value(
    self.container, index)

"""
    step(self::Axis)::Real

Get the step between two successive values."""
function step(self::Axis)::Real
    if typeof(self.container) == RegularAxis
        return self.container.step
    end
    throw(ArgumentError("step() is only defined for regular axes"))
end

"""
    normalize_coordinate(
        self::Axis,
        coordinate::T,
        min::T
    )::Real where {T<:Real}

Returns the normalized value of the coordinate with the respect to the
axis definition."""
function normalize_coordinate(
    self::Axis,
    coordinate::T,
    min::T
)::Real where {T<:Real}
    if !isnothing(self.circle) && (coordinate >= min + self.circle || coordinate < min)
        return normalize_angle(coordinate, min, self.circle)
    end
    coordinate
end

"""
    find_index(
        self::Axis,
        coordinate::T,
        bounded::Bool
    )::Real where {T<:Real}

Given a coordinate position, find what axis element contains it or return
-1 if the coordinate is not in the axis."""
function find_index(
    self::Axis,
    coordinate::T,
    bounded::Bool
)::Real where {T<:Real}
    find_index(self.container, normalize_coordinate(
            self, coordinate, min_value(self.container)), bounded)
end

"""
    find_indexes(
        self::Axis{T},
        coordinate::T
    )::Union{Tuple{Int64,Int64},Nothing} where {T<:Real}

Given a coordinate position, find grids elements around it or return
nothing if the coordinate is not in the axis."""
function find_indexes(
    self::Axis{T},
    coordinate::T
)::Union{Tuple{Int64,Int64},Nothing} where {T<:Real}
    coordinate = normalize_coordinate(
        self, coordinate, min_value(self.container))
    n = length(self.container)
    i0 = find_index(self, coordinate, false)

    # If the value is outside the circle, then the value is between the last
    # and first index.
    if i0 == -1
        return self.is_circle ? (n, 1) : nothing
    end

    # Given the delta between the found coordinate and the given coordinate,
    # chose the other index that frames the coordinate
    delta = coordinate - coordinate_value(self.container, i0)
    i1 = i0

    if delta == 0
        # The requested coordinate is located on an element of the axis.
        i1 == n ? i0 -= 1 : i1 += 1
    else
        if delta < 0
            # The found point is located after the coordinate provided.
            self.container.is_ascending ? i0 -= 1 : i0 += 1
            if self.is_circle
                i0 = remainder(i0 - 1, n) + 1
            end
        else
            # The found point is located before the coordinate provided.
            self.container.is_ascending ? i1 += 1 : i1 -= 1
            if self.is_circle
                i1 = remainder(i1 - 1, n) + 1
            end
        end
    end

    if i0 >= 1 && i0 <= n && i1 >= 1 && i1 <= n
        return (i0, i1)
    end
    nothing
end