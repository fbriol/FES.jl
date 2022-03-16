import HDF5

"""
    function CartesianTidalModel(
        tide_type::TideType,
        x_axis::Axis{Float64},
        y_axis::Axis{Float64},
        models::Dict{Ident,Matrix{Complex{T}}}
    ) where {T<:Real}

Represents a Tidal Wave stored in a Cartesian grid.

# Arguments
* tide_type: Type of tide stored in the model.
* x_axis: X axis of the model.
* y_axis: Y axis of the model.
* models: Dictionary of wave models.
"""
struct CartesianTidalModel{T<:Real} <: AbstractTidalModel{T}
    tide_type::TideType
    x_axis::Axis{Float64}
    y_axis::Axis{Float64}
    models::Dict{Ident,Matrix{Complex{T}}}

    function CartesianTidalModel(
        tide_type::TideType,
        x_axis::Axis{Float64},
        y_axis::Axis{Float64},
        models::Dict{Ident,Matrix{Complex{T}}}
    ) where {T<:Real}
        expected_shape = (length(x_axis), length(y_axis))
        for grid in values(models)
            if size(grid) != expected_shape
                raise(DimensionMismatch(
                    "Expected shape {expected_shape}, got {size(grid)}."))
            end
        end
        new{T}(tide_type, x_axis, y_axis, models)
    end
end

"""
    function interpolate(
        self::CartesianTidalModel{T},
        lon::Float64,
        lat::Float64,
        wave_table::WaveTable
    )::Int64 where {T<:Real}

Interpolate the tide at the given longitude and latitude from
the waves handled by the model.
"""
function interpolate(
    self::CartesianTidalModel{T},
    lon::Float64,
    lat::Float64,
    wave_table::WaveTable
)::Int64 where {T<:Real}
    samples = 4
    x_indexes = find_indexes(self.x_axis, lon)
    y_indexes = find_indexes(self.y_axis, lat)
    if isnothing(x_indexes) || isnothing(y_indexes)
        return 0
    end
    i0, i1 = x_indexes
    j0, j1 = y_indexes
    x0 = coordinate_value(self.x_axis, x_indexes[1])
    x1 = coordinate_value(self.x_axis, x_indexes[2])
    y0 = coordinate_value(self.y_axis, y_indexes[1])
    y1 = coordinate_value(self.y_axis, y_indexes[2])

    for (id, array) in self.models
        wave = wave_table.waves[Int64(id)]

        tide, n = bilinear_interpolation(
            x0, x1, y0, y1, normalize_angle(lon, x0), lat,
            array[i0, j0], array[i0, j1], array[i1, j0], array[i1, j1])
        samples = min(n, samples)
        if samples == 0
            return 0
        end
        wave.tide = tide
    end
    return samples
end

"""
    _fill_missing(variable::HDF5.Dataset)::Tuple{Matrix, Type}

Load data from a dataset and replace missing values with NaN. Return 
the data and the type of the data loaded.
"""
function _fill_missing(
    variable::HDF5.Dataset,
    expected_unit::String
)::Tuple{Matrix, Type}
    dtype = eltype(variable)
    # Doesn't support packed data (variable with scale_factor and
    # add_offset attributes)
    if dtype ∉ [Float64, Float32]
        throw(TypeError(
            :_fill_missing, "", Union{Float64, Float32}, dtype))
    end
    array = HDF5.read(variable)
    attrs = HDF5.attributes(variable)
    fill_val = HDF5.read(attrs["_FillValue"])[1]
    unit = HDF5.read(attrs["units"])
    if unit != expected_unit
        varname = replace(HDF5.name(variable), "/" => "")
        throw(ErrorException(
            varname * " must be in " * expected_unit * " not " * unit))
    end
    replace!(array, fill_val => convert(dtype, NaN))
    array, dtype
end

function _get_wave_ident(wt::WaveTable, wave_name::String)::Ident
    wave = find(wt, wave_name)
    if isnothing(wave)
        throw(ArgumentError("unknown wave: " * wave_name))
    end
    wave.ident
end

"""
    function CartesianTidalModel(
        paths::Dict{String, String},
        tide_type::TideType,
        amp_varname::String="amplitude",
        pha_varname::String="phase",
        lon_varname::String="lon",
        lat_varname::String="lat"
    )::CartesianTidalModel

Load a tidal model from a set of HDF5 files.

# Arguments
* paths: Dictionary of wave models.
* tide_type: Type of tide stored in the model.
* amp_varname: Name of the variable containing the amplitude.
* pha_varname: Name of the variable containing the phase.
* lon_varname: Name of the variable containing the longitude.
* lat_varname: Name of the variable containing the latitude.

# Returns
A CartesianTidalModel.
"""
function CartesianTidalModel(
    paths::Dict{String, String},
    tide_type::TideType,
    amp_varname::String="amplitude",
    pha_varname::String="phase",
    lon_varname::String="lon",
    lat_varname::String="lat"
)::CartesianTidalModel

    # Numerical grids loaded in memory for each wave of the model.
    waves = Dict()

    # X-axis and Y-axis
    x_axis = nothing
    y_axis = nothing

    # Floating point precision of the data
    expected_dtype = nothing

    # List of known wave models
    wt = WaveTable()

    for (wave_name, path) in paths
        ident = _get_wave_ident(wt, wave_name)
        ds = HDF5.h5open(path)
        try
            # Load amplitude
            amp, dtype = _fill_missing(ds[amp_varname], "cm")
            if isnothing(expected_dtype)
                expected_dtype = dtype
            elseif dtype ≠ expected_dtype
                throw(TypeError(
                    :load_data, "", expected_dtype, dtype))
            end        
            # Load phase
            pha, dtype = _fill_missing(ds[pha_varname], "degrees")
            if dtype ≠ expected_dtype
                throw(TypeError(
                    :load_data, "", expected_dtype, dtype))
            end
            # Load longitude axis
            lon = convert(Vector{Float64}, ds[lon_varname][:])
            if isnothing(x_axis)
                x_axis = FES.Axis(lon, true)
            else
                if FES.Axis(lon, true) != x_axis
                    throw(ErrorException(
                        "longitude axis mismatch between datasets"))
                end
            end
            # Load latitude axis
            lat = convert(Vector{Float64}, ds[lat_varname][:])
            if isnothing(y_axis)
                y_axis = FES.Axis(lat)
            else
                if FES.Axis(lat) != y_axis
                    throw(ErrorException(
                        "latitude axis mismatch between datasets"))
                end
            end
            waves[ident] = amp .* cosd.(pha) + amp .* sind.(pha) .* 1im
        finally
            HDF5.close(ds)
        end
    end
    waves = convert(Dict{FES.Ident, Matrix{Complex{expected_dtype}}}, waves)
    CartesianTidalModel(tide_type, x_axis, y_axis, waves)
end
