
using Dates


"""Possible type of tide."""
@enum TideType begin
    # Ocean tide
    kTide = 0
    # Radial tide
    kRadial = 1
end

"""Abstract class for a tidal wave model."""
abstract type AbstractTidalModel{T<:Real} end



"""
    function _evaluate_tide(
        self::AbstractTidalModel{T},
        date::DateTime,
        lon::Float64,
        lat::Float64,
        wave_table::WaveTable,
        w2nd::WaveOrder2
    )::Tuple{Float64,Float64,Int64} where {T<:Real}

Evaluate the tide at the given spatio-temporal point.
"""
function _evaluate_tide(
    self::AbstractTidalModel{T},
    date::DateTime,
    lon::Float64,
    lat::Float64,
    wave_table::WaveTable,
    w2nd::WaveOrder2
)::Tuple{Float64,Float64,Int64} where {T<:Real}
    # Adjusts nodal corrections to the tidal estimate date.
    angles = compute_nodal_corrections!(wave_table, date)

    # Interpolation, at the requested position, of the waves provided by the
    # model used.
    samples = interpolate(self, lon, lat, wave_table)

    # Initialization, depending on the type of tide calculated, of he long
    # period wave constituents of the tidal spectrum
    h_long_period = self.tide_type == kTide ? lpe_minus_n_waves(w2nd, angles, lat) : 0

    # Calculation of the missing waves of the model by admittance.
    admittance!(wave_table)

    # If the point is not defined by the model (samples == 0), the tide is
    # set to NaN.
    if samples == 0
        return NaN, h_long_period, 0
    end

    h = 0
    for wave in wave_table.waves
        phi = vu(wave)
        tide = wave.f * (wave.tide.re * cos(phi) + wave.tide.im * sin(phi))

        if wave.admittance || wave.dynamic
            wave.type == kShortPeriod ? h += tide : h_long_period += tide
        end
    end

    return (h, h_long_period, samples)
end


function _build_wave_table(
    self::AbstractTidalModel{T},
    equilibrium_long_period::Vector{Ident}
)::WaveTable where {T<:Real}
    wave_table = WaveTable()
    for id in keys(self.models)
        if isnothing(findfirst(x -> x == id, equilibrium_long_period))
            wave = wave_table.waves[Int64(id)]
            # Wave computed dynamically
            wave.dynamic = true
            # If the data are read from a grid so the wave is not computed by
            # admittance
            wave.admittance = false
        end
    end
    wave_table
end


"""
    function evaluate_tide(
        self::AbstractTidalModel{T},
        date::Vector{DateTime},
        lon::Vector{Float64},
        lat::Vector{Float64};
        equilibrium_long_period::Vector{Ident}=Vector{Ident}(),
    )::Tuple{Vector{Float64},Vector{Float64},Vector{Int64}} where {T<:Real}

Ocean tide calculation

# Arguments
* date: Date of the estimate
* lon: Longitude in degrees for the position at which tide is computed
* lat: Latitude in degrees (positive north) for the position at which
  tide is computed
* equilibrium_long_period: The list of long periods not to be taken
  into account in order to calculate the equilibrium tide.

# Returns
A tuble that contains
* Computed height of the diurnal and semi-diurnal constituents of the
  tidal spectrum (cm)
* Computed height of the long period wave constituents of the tidal
  spectrum (cm)
* The minimum number of valid data used in the bi-linear interpolation
  of tidal waves from their numerical models.

# Note
Computed height of the diurnal and semi-diurnal constituents is set to nan
if no data is available at the given position. the long period wave
constituents is always computed because this value does not depend on
input grids.
"""
function evaluate_tide(
    self::AbstractTidalModel{T},
    date::Vector{DateTime},
    lon::Vector{Float64},
    lat::Vector{Float64};
    equilibrium_long_period::Vector{Ident}=Vector{Ident}(),
)::Tuple{Vector{Float64},Vector{Float64},Vector{Int64}} where {T<:Real}
    n = length(date)
    if length(date) != length(lon)
        throw(DimensionMismatch("date, lon could not be broadcast together with shape " +
                                string(size(date)) + ", " + string(size(lon))))
    end
    if length(date) != length(lat)
        throw(DimensionMismatch("date, lat could not be broadcast together with shape " +
                                string(size(date)) + ", " + string(size(lat))))
    end

    nthreads = Threads.nthreads()
    wave_table = Vector{WaveTable}(undef, nthreads)
    w2nd = Vector{WaveOrder2}(undef, nthreads)

    # Setup the wave table and the wave order 2 for each thread.
    for ix in 1:nthreads
        wave_table[ix] = _build_wave_table(self, equilibrium_long_period)
        # Create the values of the second-order wave coefficients for the
        # calculation of long-period equilibrium ocean tides and deactivate the
        # waves used for this computation.
        w2nd[ix] = WaveOrder2()
        disable_dynamic_wave!(w2nd[ix], wave_table[ix])
    end

    # Allocate the result vectors.
    tide = Vector{Float64}(undef, n)
    samples = Vector{Int64}(undef, n)
    long_period = Vector{Float64}(undef, n)

    Threads.@threads for ix in 1:n
        tid = Threads.threadid()
        tide[ix], long_period[ix], samples[ix] = _evaluate_tide(
            self, date[ix], lon[ix], lat[ix], wave_table[tid], w2nd[tid])
    end
    (tide, long_period, samples)
end