# FES.jl

Documentation for FES.jl, a Julia package for calculating ocean tide.

It is based on the [FES/AVISO](https://github.com/CNES/aviso-fes) library.

## Installation

Inside the Julia shell, you can download and install using the following commands:

```julia
using Pkg
Pkg.add("FES")
```

## Example of usage

```julia
    using Dates
    import Printf
    import FES

    # To initialize a model, a dictionary must be built between the identifier
    # of a wave and the NetCDF-4 file describing it.
    model_radial = FES.CartesianTidalModel(
        Dict(
            FES.k2N2 => "../test/data/2N2_radial.nc",
            FES.kK1 => "../test/data/K1_radial.nc",
            FES.kK2 => "../test/data/K2_radial.nc",
            FES.kM2 => "../test/data/M2_radial.nc",
            FES.kN2 => "../test/data/N2_radial.nc",
            FES.kO1 => "../test/data/O1_radial.nc",
            FES.kP1 => "../test/data/P1_radial.nc",
            FES.kQ1 => "../test/data/Q1_radial.nc",
            FES.kS2 => "../test/data/S2_radial.nc"),
        FES.kRadial)

    model_tide = FES.CartesianTidalModel(
        Dict(
            FES.k2N2 => "../test/data/2N2_tide.nc",
            FES.kK1 => "../test/data/K1_tide.nc",
            FES.kK2 => "../test/data/K2_tide.nc",
            FES.kM2 => "../test/data/M2_tide.nc",
            FES.kM4 => "../test/data/M4_tide.nc",
            FES.kMf => "../test/data/Mf_tide.nc",
            FES.kMm => "../test/data/Mm_tide.nc",
            FES.kMsqm => "../test/data/Msqm_tide.nc",
            FES.kMtm => "../test/data/Mtm_tide.nc",
            FES.kN2 => "../test/data/N2_tide.nc",
            FES.kO1 => "../test/data/O1_tide.nc",
            FES.kP1 => "../test/data/P1_tide.nc",
            FES.kQ1 => "../test/data/Q1_tide.nc",
            FES.kS1 => "../test/data/S1_tide.nc",
            FES.kS2 => "../test/data/S2_tide.nc"),
        FES.kTide)

    # Construction of the positions to be estimated.
    dates = Vector{DateTime}(undef, 24)
    lons = Vector{Float64}(undef, 24)
    lats = Vector{Float64}(undef, 24)
    for hour in 0:23
        idx = hour + 1
        dates[idx] = DateTime(1983, 1, 1, hour, 0, 0)
        lons[idx] = -7.688;
        lats[idx] = 59.195;
    end

    # Compute ocean tide
    tide, lp, _  = FES.evaluate_tide(model_tide, dates, lons, lats)
    # Compute oading tide
    load, load_lp, _  = FES.evaluate_tide(model_radial, dates, lons, lats)
    @Printf.printf(
        "%17s %9s %9s %9s %9s %9s %9s %9s\n",
        "Date",
        "Latitude",
        "Longitude",
        "Short_tid",
        "LP_tid",
        "Pure_Tide",
        "Geo_Tide",
        "Rad_Tide")
    for ix in 1:24
        @Printf.printf(
            "%17s %9.3f %9.3f %9.3f %9.3f %9.3f %9.3f %9.3f\n",
           dates[ix],
           lats[ix],
           lons[ix],
           tide[ix],
           lp[ix],
           tide[ix] + lp[ix],
           tide[ix] + lp[ix] + load[ix],
           load[ix])
    end
```

## Module Index

```@index
Modules = [FES]
Order   = [:constant, :type, :function, :macro]
```
## Detailed API

```@autodocs
Modules = [FES]
Order   = [:constant, :type, :function, :macro]
```
