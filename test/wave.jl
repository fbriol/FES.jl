function test_wave()
    wave = FES.Mm()
    @test wave.freq ≈ 0.00950113083934 atol=1e-6
    @test wave.type == FES.kLongPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "Mm"

    wave = FES.Mf()
    @test wave.freq ≈ 0.0191642922645 atol=1e-6
    @test wave.type == FES.kLongPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "Mf"

    wave = FES.Mtm()
    @test wave.freq ≈ 0.0286654231038 atol=1e-6
    @test wave.type == FES.kLongPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "Mtm"

    wave = FES.Msqm()
    @test wave.freq ≈ 0.0368950185872 atol=1e-6
    @test wave.type == FES.kLongPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "Msqm"

    wave = FES._2Q1()
    @test wave.freq ≈ 0.224349616827 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "2Q1"

    wave = FES.Sigma1()
    @test wave.freq ≈ 0.225621152183 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "Sigma1"

    wave = FES.Q1()
    @test wave.freq ≈ 0.233850747666 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "Q1"

    wave = FES.Rho1()
    @test wave.freq ≈ 0.235122283022 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "Rho1"

    wave = FES.O1()
    @test wave.freq ≈ 0.243351878506 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "O1"

    wave = FES.MP1()
    @test wave.freq ≈ 0.244785444447 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "MP1"

    wave = FES.M11()
    @test wave.freq ≈ 0.253015039931 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "M11"

    wave = FES.M12()
    @test wave.freq ≈ 0.252853009345 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "M12"

    wave = FES.M13()
    @test wave.freq ≈ 0.253015039931 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "M13"

    wave = FES.Chi1()
    @test wave.freq ≈ 0.254286575287 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "Chi1"

    wave = FES.Pi1()
    @test wave.freq ≈ 0.260365856083 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "Pi1"

    wave = FES.P1()
    @test wave.freq ≈ 0.261082604828 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "P1"

    wave = FES.S1()
    @test wave.freq ≈ 0.261799387799 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "S1"

    wave = FES.K1()
    @test wave.freq ≈ 0.26251617077 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "K1"

    wave = FES.Psi1()
    @test wave.freq ≈ 0.263232919515 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "Psi1"

    wave = FES.Phi1()
    @test wave.freq ≈ 0.263949736712 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "Phi1"

    wave = FES.Theta1()
    @test wave.freq ≈ 0.270745766253 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "Theta1"

    wave = FES.J1()
    @test wave.freq ≈ 0.272017301609 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "J1"

    wave = FES.OO1()
    @test wave.freq ≈ 0.281680463035 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "OO1"

    wave = FES.MNS2()
    @test wave.freq ≈ 0.478636192114 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "MNS2"

    wave = FES.Eps2()
    @test wave.freq ≈ 0.478636192114 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "Eps2"

    wave = FES._2N2()
    @test wave.freq ≈ 0.486865787597 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "2N2"

    wave = FES.Mu2()
    @test wave.freq ≈ 0.488137322953 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "Mu2"

    wave = FES._2MS2()
    @test wave.freq ≈ 0.488137322953 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "2MS2"

    wave = FES.N2()
    @test wave.freq ≈ 0.496366918436 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "N2"

    wave = FES.Nu2()
    @test wave.freq ≈ 0.497638453792 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "Nu2"

    wave = FES.M2()
    @test wave.freq ≈ 0.505868049276 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "M2"

    wave = FES.MKS2()
    @test wave.freq ≈ 0.507301615217 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "MKS2"

    wave = FES.Lambda2()
    @test wave.freq ≈ 0.514097644759 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "Lambda2"

    wave = FES.L2()
    @test wave.freq ≈ 0.515369180115 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "L2"

    wave = FES._2MN2()
    @test wave.freq ≈ 0.515369180115 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "2MN2"

    wave = FES.T2()
    @test wave.freq ≈ 0.522882026853 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "T2"

    wave = FES.S2()
    @test wave.freq ≈ 0.523598775598 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "S2"

    wave = FES.R2()
    @test wave.freq ≈ 0.524315524344 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "R2"

    wave = FES.K2()
    @test wave.freq ≈ 0.52503234154 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "K2"

    wave = FES.MSN2()
    @test wave.freq ≈ 0.533099906438 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "MSN2"

    wave = FES.Eta2()
    @test wave.freq ≈ 0.534533472379 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == true
    @test FES.name(wave) == "Eta2"

    wave = FES._2SM2()
    @test wave.freq ≈ 0.541329501921 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "2SM2"

    wave = FES.MO3()
    @test wave.freq ≈ 0.749219927781 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "MO3"

    wave = FES._2MK3()
    @test wave.freq ≈ 0.749219927781 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "2MK3"

    wave = FES.M3()
    @test wave.freq ≈ 0.758802073913 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "M3"

    wave = FES.MK3()
    @test wave.freq ≈ 0.768384220046 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "MK3"

    wave = FES.N4()
    @test wave.freq ≈ 0.992733836873 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "N4"

    wave = FES.MN4()
    @test wave.freq ≈ 1.00223496771 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "MN4"

    wave = FES.M4()
    @test wave.freq ≈ 1.01173609855 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "M4"

    wave = FES.SN4()
    @test wave.freq ≈ 1.01996569403 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "SN4"

    wave = FES.MS4()
    @test wave.freq ≈ 1.02946682487 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "MS4"

    wave = FES.MK4()
    @test wave.freq ≈ 1.03090039082 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "MK4"

    wave = FES.S4()
    @test wave.freq ≈ 1.0471975512 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "S4"

    wave = FES.SK4()
    @test wave.freq ≈ 1.04863111714 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "SK4"

    wave = FES.R4()
    @test wave.freq ≈ 1.04863104869 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "R4"

    wave = FES._2MN6()
    @test wave.freq ≈ 1.50810301699 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "2MN6"

    wave = FES.M6()
    @test wave.freq ≈ 1.51760414783 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "M6"

    wave = FES.MSN6()
    @test wave.freq ≈ 1.52583374331 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "MSN6"

    wave = FES._2MS6()
    @test wave.freq ≈ 1.53533487415 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "2MS6"

    wave = FES._2MK6()
    @test wave.freq ≈ 1.53676844009 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "2MK6"

    wave = FES._2SM6()
    @test wave.freq ≈ 1.55306560047 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "2SM6"

    wave = FES.MSK6()
    @test wave.freq ≈ 1.55449916641 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "MSK6"

    wave = FES.S6()
    @test wave.freq ≈ 1.57079632679 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "S6"

    wave = FES.M8()
    @test wave.freq ≈ 2.0234721971 atol=1e-6
    @test wave.type == FES.kShortPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "M8"

    wave = FES.MSf()
    @test wave.freq ≈ 0.0177307263227 atol=1e-6
    @test wave.type == FES.kLongPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "MSf"

    wave = FES.Ssa()
    @test wave.freq ≈ 0.00143356594182 atol=1e-6
    @test wave.type == FES.kLongPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "Ssa"

    wave = FES.Sa()
    @test wave.freq ≈ 0.00071678297091 atol=1e-6
    @test wave.type == FES.kLongPeriod
    @test wave.admittance == false
    @test FES.name(wave) == "Sa"

    a = FES.AstronomicAngle(DateTime(1950, 1, 1))

    wave = FES.Mm()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ -2.52125870567 atol=1e-6

    wave = FES.Mf()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 2.17644457879 atol=1e-6

    wave = FES.Mtm()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ -0.344814126883 atol=1e-6

    wave = FES.Msqm()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ -5.35280676417 atol=1e-6

    wave = FES._2Q1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 6.14417437068 atol=1e-6

    wave = FES.Sigma1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 2.34772299511 atol=1e-6

    wave = FES.Q1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 3.622915665 atol=1e-6

    wave = FES.Rho1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 6.10964959662 atol=1e-6

    wave = FES.O1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 1.10165695933 atol=1e-6

    wave = FES.MP1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 1.38257492031 atol=1e-6

    wave = FES.M11()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 2.6577675902 atol=1e-6

    wave = FES.M12()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 1.72199090725 atol=1e-6

    wave = FES.M13()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 2.64795126012 atol=1e-6

    wave = FES.Chi1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 5.14450152182 atol=1e-6

    wave = FES.Pi1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ -0.141055723739 atol=1e-6

    wave = FES.P1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ -0.175950409236 atol=1e-6

    wave = FES.S1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 3.1415926536 atol=1e-6

    wave = FES.K1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 0.147758109849 atol=1e-6

    wave = FES.Psi1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 0.141055723751 atol=1e-6

    wave = FES.Phi1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 3.66944388132 atol=1e-6

    wave = FES.Theta1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 1.41170155443 atol=1e-6

    wave = FES.J1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 3.89843548604 atol=1e-6

    wave = FES.OO1()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 2.31295346332 atol=1e-6

    wave = FES.MNS2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 4.99759039339 atol=1e-6

    wave = FES.Eps2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 5.00549058532 atol=1e-6

    wave = FES._2N2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 6.28068325521 atol=1e-6

    wave = FES.Mu2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 2.48423187964 atol=1e-6

    wave = FES._2MS2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 2.47633168771 atol=1e-6

    wave = FES.N2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 3.75942454954 atol=1e-6

    wave = FES.Nu2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 6.24615848115 atol=1e-6

    wave = FES.M2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 1.23816584386 atol=1e-6

    wave = FES.MKS2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 4.67185804768 atol=1e-6

    wave = FES.Lambda2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 5.65495116735 atol=1e-6

    wave = FES.L2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 1.47413521259 atol=1e-6

    wave = FES._2MN2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 1.85849979178 atol=1e-6

    wave = FES.T2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 0.0348946855095 atol=1e-6

    wave = FES.S2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 1.24558141579e-11 atol=1e-6

    wave = FES.R2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 3.10669796811 atol=1e-6

    wave = FES.K2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 3.43369220383 atol=1e-6

    wave = FES.MSN2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 3.76192660152 atol=1e-6

    wave = FES.Eta2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 0.89335171698 atol=1e-6

    wave = FES._2SM2()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ -1.2539662277 atol=1e-6

    wave = FES.MO3()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 2.3398228032 atol=1e-6

    wave = FES._2MK3()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 2.32857357788 atol=1e-6

    wave = FES.M3()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 1.8572487658 atol=1e-6

    wave = FES.MK3()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 1.38592395371 atol=1e-6

    wave = FES.N4()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 1.23566379189 atol=1e-6

    wave = FES.MN4()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 4.9975903934 atol=1e-6

    wave = FES.M4()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 2.47633168773 atol=1e-6

    wave = FES.SN4()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 3.75942454955 atol=1e-6

    wave = FES.MS4()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 1.23816584388 atol=1e-6

    wave = FES.MK4()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 4.67527471715 atol=1e-6

    wave = FES.S4()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 2.49116283157e-11 atol=1e-6

    wave = FES.SK4()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 3.43369220384 atol=1e-6

    wave = FES.R4()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 6.21339593621 atol=1e-6

    wave = FES._2MN6()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 6.23575623726 atol=1e-6

    wave = FES.M6()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 3.71449753159 atol=1e-6

    wave = FES.MSN6()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 4.99759039341 atol=1e-6

    wave = FES._2MS6()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 2.47633168774 atol=1e-6

    wave = FES._2MK6()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 5.91002389156 atol=1e-6

    wave = FES._2SM6()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 1.23816584389 atol=1e-6

    wave = FES.MSK6()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 4.67527471716 atol=1e-6

    wave = FES.S6()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 3.73674424736e-11 atol=1e-6

    wave = FES.M8()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 4.95266337545 atol=1e-6

    wave = FES.MSf()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ -1.25396622771 atol=1e-6

    wave = FES.Ssa()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 3.49349347207 atol=1e-6

    wave = FES.Sa()
    FES.nodal_g!(wave, a)
    @test FES.vu(wave) ≈ 4.88833938963 atol=1e-6

    wave = FES.Mm()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.874229757877 atol=1e-6

    wave = FES.Mf()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.44306657311 atol=1e-6

    wave = FES.Mtm()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.44306657311 atol=1e-6

    wave = FES.Msqm()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.44306657311 atol=1e-6

    wave = FES._2Q1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.17967653009 atol=1e-6

    wave = FES.Sigma1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.17967653009 atol=1e-6

    wave = FES.Q1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.17967653009 atol=1e-6

    wave = FES.Rho1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.17967653009 atol=1e-6

    wave = FES.O1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.17967653009 atol=1e-6

    wave = FES.MP1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.16262347004 atol=1e-6

    wave = FES.M11()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.16262347004 atol=1e-6

    wave = FES.M12()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.17967653009 atol=1e-6

    wave = FES.M13()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 2.09744776147 atol=1e-6

    wave = FES.Chi1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.16262347004 atol=1e-6

    wave = FES.Pi1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1 atol=1e-6

    wave = FES.P1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1 atol=1e-6

    wave = FES.S1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1 atol=1e-6

    wave = FES.K1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.11092810669 atol=1e-6

    wave = FES.Psi1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1 atol=1e-6

    wave = FES.Phi1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1 atol=1e-6

    wave = FES.Theta1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.16262347004 atol=1e-6

    wave = FES.J1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.16262347004 atol=1e-6

    wave = FES.OO1()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.76334120659 atol=1e-6

    wave = FES.MNS2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.929346344948 atol=1e-6

    wave = FES.Eps2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.964026112171 atol=1e-6

    wave = FES._2N2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.964026112171 atol=1e-6

    wave = FES.Mu2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.964026112171 atol=1e-6

    wave = FES._2MS2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.929346344948 atol=1e-6

    wave = FES.N2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.964026112171 atol=1e-6

    wave = FES.Nu2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.964026112171 atol=1e-6

    wave = FES.M2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.964026112171 atol=1e-6

    wave = FES.MKS2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.26228367661 atol=1e-6

    wave = FES.Lambda2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.964026112171 atol=1e-6

    wave = FES.L2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.801134230242 atol=1e-6

    wave = FES._2MN2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.895914143781 atol=1e-6

    wave = FES.T2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1 atol=1e-6

    wave = FES.S2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1 atol=1e-6

    wave = FES.R2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1 atol=1e-6

    wave = FES.K2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.30938743326 atol=1e-6

    wave = FES.MSN2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.929346344948 atol=1e-6

    wave = FES.Eta2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.45505370758 atol=1e-6

    wave = FES._2SM2()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.964026112171 atol=1e-6

    wave = FES.MO3()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.13723897892 atol=1e-6

    wave = FES._2MK3()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.03243697545 atol=1e-6

    wave = FES.M3()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.946552305667 atol=1e-6

    wave = FES.MK3()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.07096370359 atol=1e-6

    wave = FES.N4()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.929346344948 atol=1e-6

    wave = FES.MN4()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.929346344948 atol=1e-6

    wave = FES.M4()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.929346344948 atol=1e-6

    wave = FES.SN4()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.964026112171 atol=1e-6

    wave = FES.MS4()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.964026112171 atol=1e-6

    wave = FES.MK4()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.26228367661 atol=1e-6

    wave = FES.S4()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1 atol=1e-6

    wave = FES.SK4()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.30938743326 atol=1e-6

    wave = FES.R4()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1 atol=1e-6

    wave = FES._2MN6()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.895914143781 atol=1e-6

    wave = FES.M6()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.895914143781 atol=1e-6

    wave = FES.MSN6()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.929346344948 atol=1e-6

    wave = FES._2MS6()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.929346344948 atol=1e-6

    wave = FES._2MK6()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.17309872114 atol=1e-6

    wave = FES._2SM6()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.964026112171 atol=1e-6

    wave = FES.MSK6()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1.26228367661 atol=1e-6

    wave = FES.S6()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1 atol=1e-6

    wave = FES.M8()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.863684628868 atol=1e-6

    wave = FES.MSf()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 0.964026112171 atol=1e-6

    wave = FES.Ssa()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1 atol=1e-6

    wave = FES.Sa()
    FES.nodal_a!(wave, a)
    @test wave.f ≈ 1 atol=1e-6
    nothing
end

