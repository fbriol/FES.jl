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
            "2N2" => "../test/data/2N2_radial.nc",
            "K1" => "../test/data/K1_radial.nc",
            "K2" => "../test/data/K2_radial.nc",
            "M2" => "../test/data/M2_radial.nc",
            "N2" => "../test/data/N2_radial.nc",
            "O1" => "../test/data/O1_radial.nc",
            "P1" => "../test/data/P1_radial.nc",
            "Q1" => "../test/data/Q1_radial.nc",
            "S2" => "../test/data/S2_radial.nc"),
        FES.kRadial)

    model_tide = FES.CartesianTidalModel(
        Dict(
            "2N2" => "../test/data/2N2_tide.nc",
            "K1" => "../test/data/K1_tide.nc",
            "K2" => "../test/data/K2_tide.nc",
            "M2" => "../test/data/M2_tide.nc",
            "M4" => "../test/data/M4_tide.nc",
            "Mf" => "../test/data/Mf_tide.nc",
            "Mm" => "../test/data/Mm_tide.nc",
            "Msqm" => "../test/data/Msqm_tide.nc",
            "Mtm" => "../test/data/Mtm_tide.nc",
            "N2" => "../test/data/N2_tide.nc",
            "O1" => "../test/data/O1_tide.nc",
            "P1" => "../test/data/P1_tide.nc",
            "Q1" => "../test/data/Q1_tide.nc",
            "S1" => "../test/data/S1_tide.nc",
            "S2" => "../test/data/S2_tide.nc"),
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

### FES2014 configuration

```julia
import FES

function fes2014(
    load_tide::String, ocean_tide::String
)::Tuple{FES.CartesianTidalModel, FES.CartesianTidalModel}
    model_radial = FES.CartesianTidalModel(
        Dict(
            "2N2" => joinpath(load_tide, "2n2.nc"),
            "Eps2" => joinpath(load_tide, "eps2.nc"),
            "J1" => joinpath(load_tide, "j1.nc"),
            "K1" => joinpath(load_tide, "k1.nc"),
            "K2" => joinpath(load_tide, "k2.nc"),
            "L2" => joinpath(load_tide, "l2.nc"),
            "Lambda2" => joinpath(load_tide, "la2.nc"),
            "M2" => joinpath(load_tide, "m2.nc"),
            "M3" => joinpath(load_tide, "m3.nc"),
            "M4" => joinpath(load_tide, "m4.nc"),
            "M6" => joinpath(load_tide, "m6.nc"),
            "M8" => joinpath(load_tide, "m8.nc"),
            "Mf" => joinpath(load_tide, "mf.nc"),
            "MKS2" => joinpath(load_tide, "mks2.nc"),
            "Mm" => joinpath(load_tide, "mm.nc"),
            "MN4" => joinpath(load_tide, "mn4.nc"),
            "MS4" => joinpath(load_tide, "ms4.nc"),
            "MSf" => joinpath(load_tide, "msf.nc"),
            "Msqm" => joinpath(load_tide, "msqm.nc"),
            "Mtm" => joinpath(load_tide, "mtm.nc"),
            "Mu2" => joinpath(load_tide, "mu2.nc"),
            "N2" => joinpath(load_tide, "n2.nc"),
            "N4" => joinpath(load_tide, "n4.nc"),
            "Nu2" => joinpath(load_tide, "nu2.nc"),
            "O1" => joinpath(load_tide, "o1.nc"),
            "P1" => joinpath(load_tide, "p1.nc"),
            "Q1" => joinpath(load_tide, "q1.nc"),
            "R2" => joinpath(load_tide, "r2.nc"),
            "S1" => joinpath(load_tide, "s1.nc"),
            "S2" => joinpath(load_tide, "s2.nc"),
            "S4" => joinpath(load_tide, "s4.nc"),
            "Sa" => joinpath(load_tide, "sa.nc"),
            "Ssa" => joinpath(load_tide, "ssa.nc"),
            "T2" => joinpath(load_tide, "t2.nc)")),
        FES.kRadial)

    model_tide = FES.CartesianTidalModel(
        Dict(
            "2N2" => joinpath(ocean_tide, "2n2.nc"),
            "Eps2" => joinpath(ocean_tide, "eps2.nc"),
            "J1" => joinpath(ocean_tide, "j1.nc"),
            "K1" => joinpath(ocean_tide, "k1.nc"),
            "K2" => joinpath(ocean_tide, "k2.nc"),
            "L2" => joinpath(ocean_tide, "l2.nc"),
            "Lambda2" => joinpath(ocean_tide, "la2.nc"),
            "M2" => joinpath(ocean_tide, "m2.nc"),
            "M3" => joinpath(ocean_tide, "m3.nc"),
            "M4" => joinpath(ocean_tide, "m4.nc"),
            "M6" => joinpath(ocean_tide, "m6.nc"),
            "M8" => joinpath(ocean_tide, "m8.nc"),
            "Mf" => joinpath(ocean_tide, "mf.nc"),
            "MKS2" => joinpath(ocean_tide, "mks2.nc"),
            "Mm" => joinpath(ocean_tide, "mm.nc"),
            "MN4" => joinpath(ocean_tide, "mn4.nc"),
            "MS4" => joinpath(ocean_tide, "ms4.nc"),
            "MSf" => joinpath(ocean_tide, "msf.nc"),
            "Msqm" => joinpath(ocean_tide, "msqm.nc"),
            "Mtm" => joinpath(ocean_tide, "mtm.nc"),
            "Mu2" => joinpath(ocean_tide, "mu2.nc"),
            "N2" => joinpath(ocean_tide, "n2.nc"),
            "N4" => joinpath(ocean_tide, "n4.nc"),
            "Nu2" => joinpath(ocean_tide, "nu2.nc"),
            "O1" => joinpath(ocean_tide, "o1.nc"),
            "P1" => joinpath(ocean_tide, "p1.nc"),
            "Q1" => joinpath(ocean_tide, "q1.nc"),
            "R2" => joinpath(ocean_tide, "r2.nc"),
            "S1" => joinpath(ocean_tide, "s1.nc"),
            "S2" => joinpath(ocean_tide, "s2.nc"),
            "S4" => joinpath(ocean_tide, "s4.nc"),
            "Sa" => joinpath(ocean_tide, "sa.nc"),
            "Ssa" => joinpath(ocean_tide, "ssa.nc"),
            "T2" => joinpath(ocean_tide, "t2.nc")),
        FES.kTide)
    model_radial, model_tide
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
