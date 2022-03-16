using Dates

function check_tide(
    tide::Tuple{Vector{Float64},Vector{Float64},Vector{Int64}},
    radial::Tuple{Vector{Float64},Vector{Float64},Vector{Int64}}
)::Nothing
    for hour in 0:23
        ix = hour + 1
        h = tide[1][ix]
        lp = tide[2][ix]
        load = radial[1][ix]
    
        if hour == 0
            @test h ≈ -100.983978400975 atol=1e-5
            @test lp ≈ 0.903038293353 atol=1e-5
            @test load ≈ 3.881054048693 atol=1e-5
        elseif hour == 1
            @test h ≈ -137.101460469580 atol=1e-5
            @test lp ≈ 0.876285406543 atol=1e-5
            @test load ≈ 4.328344578709 atol=1e-5
        elseif hour == 2
            @test h ≈ -138.484194621483 atol=1e-5
            @test lp ≈ 0.848913772112 atol=1e-5
            @test load ≈ 3.710821389515 atol=1e-5
        elseif hour == 3
            @test h ≈ -104.351336679673 atol=1e-5
            @test lp ≈ 0.820940936965 atol=1e-5
            @test load ≈ 2.134473322903 atol=1e-5
        elseif hour == 4
            @test h ≈ -42.524434821530 atol=1e-5
            @test lp ≈ 0.792384838644 atol=1e-5
            @test load ≈ -0.051794277190 atol=1e-5
        elseif hour == 5
            @test h ≈ 32.365092010417 atol=1e-5
            @test lp ≈ 0.763263790813 atol=1e-5
            @test load ≈ -2.341178298262 atol=1e-5
        elseif hour == 6
            @test h ≈ 102.159548893767 atol=1e-5
            @test lp ≈ 0.733596468450 atol=1e-5
            @test load ≈ -4.194103893494 atol=1e-5
        elseif hour == 7
            @test h ≈ 149.465212073534 atol=1e-5
            @test lp ≈ 0.703401892786 atol=1e-5
            @test load ≈ -5.171965523988 atol=1e-5
        elseif hour == 8
            @test h ≈ 162.103706634140 atol=1e-5
            @test lp ≈ 0.672699416016 atol=1e-5
            @test load ≈ -5.045812073864 atol=1e-5
        elseif hour == 9
            @test h ≈ 136.512106832385 atol=1e-5
            @test lp ≈ 0.641508705767 atol=1e-5
            @test load ≈ -3.852649029790 atol=1e-5
        elseif hour == 10
            @test h ≈ 78.905913825456 atol=1e-5
            @test lp ≈ 0.609849729311 atol=1e-5
            @test load ≈ -1.885280505514 atol=1e-5
        elseif hour == 11
            @test h ≈ 3.656357999550 atol=1e-5
            @test lp ≈ 0.577742737671 atol=1e-5
            @test load ≈ 0.381596499379 atol=1e-5
        elseif hour == 12
            @test h ≈ -70.648530911500 atol=1e-5
            @test lp ≈ 0.545208249468 atol=1e-5
            @test load ≈ 2.410262072488 atol=1e-5
        elseif hour == 13
            @test h ≈ -126.145266688589 atol=1e-5
            @test lp ≈ 0.512267034620 atol=1e-5
            @test load ≈ 3.733739559877 atol=1e-5
        elseif hour == 14
            @test h ≈ -150.113339558465 atol=1e-5
            @test lp ≈ 0.478940097904 atol=1e-5
            @test load ≈ 4.070738107339 atol=1e-5
        elseif hour == 15
            @test h ≈ -137.783564548063 atol=1e-5
            @test lp ≈ 0.445248662382 atol=1e-5
            @test load ≈ 3.392937330177 atol=1e-5
        elseif hour == 16
            @test h ≈ -93.140974692949 atol=1e-5
            @test lp ≈ 0.411214152707 atol=1e-5
            @test load ≈ 1.927941139951 atol=1e-5
        elseif hour == 17
            @test h ≈ -27.831120165675 atol=1e-5
            @test lp ≈ 0.376858178308 atol=1e-5
            @test load ≈ 0.097562692793 atol=1e-5
        elseif hour == 18
            @test h ≈ 41.529776474086 atol=1e-5
            @test lp ≈ 0.342202516502 atol=1e-5
            @test load ≈ -1.592539343409 atol=1e-5
        elseif hour == 19
            @test h ≈ 97.241003151333 atol=1e-5
            @test lp ≈ 0.307269095591 atol=1e-5
            @test load ≈ -2.683614304251 atol=1e-5
        elseif hour == 20
            @test h ≈ 124.935032598685 atol=1e-5
            @test lp ≈ 0.272079977816 atol=1e-5
            @test load ≈ -2.881669434244 atol=1e-5
        elseif hour == 21
            @test h ≈ 117.466204651387 atol=1e-5
            @test lp ≈ 0.236657342314 atol=1e-5
            @test load ≈ -2.132540527514 atol=1e-5
        elseif hour == 22
            @test h ≈ 77.032223025456 atol=1e-5
            @test lp ≈ 0.201023468099 atol=1e-5
            @test load ≈ -0.635279261554 atol=1e-5
        elseif hour == 23
            @test h ≈ 14.670252625413 atol=1e-5
            @test lp ≈ 0.165200716994 atol=1e-5
            @test load ≈ 1.209330141852 atol=1e-5
        end
    end
    nothing
end

function test_tide_prediction()::Nothing
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

    dates = Vector{DateTime}(undef, 24)
    lons = Vector{Float64}(undef, 24)
    lats = Vector{Float64}(undef, 24)
    for hour in 0:23
        idx = hour + 1
        dates[idx] = DateTime(1983, 1, 1, hour, 0, 0)
        lons[idx] = -7.688;
        lats[idx] = 59.195;
    end
    tide  = FES.evaluate_tide(model_tide, dates, lons, lats)
    radial  = FES.evaluate_tide(model_radial, dates, lons, lats)
    check_tide(tide, radial)
    nothing
end    

test_tide_prediction()

nothing