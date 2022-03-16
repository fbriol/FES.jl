using Dates

"""
    WaveTable()

Properties of tide waves computed
"""
struct WaveTable
    waves::Vector{Wave}

    function WaveTable()
        return new([Mm(), Mf(), Mtm(), Msqm(), _2Q1(), Sigma1(), Q1(), Rho1(),
            O1(), MP1(), M11(), M12(), M13(), Chi1(), Pi1(), P1(), S1(), K1(),
            Psi1(), Phi1(), Theta1(), J1(), OO1(), MNS2(), Eps2(), _2N2(),
            Mu2(), _2MS2(), N2(), Nu2(), M2(), MKS2(), Lambda2(), L2(), _2MN2(),
            T2(), S2(), R2(), K2(), MSN2(), Eta2(), _2SM2(), MO3(), _2MK3(),
            M3(), MK3(), N4(), MN4(), M4(), SN4(), MS4(), MK4(), S4(), SK4(),
            R4(), _2MN6(), M6(), MSN6(), _2MS6(), _2MK6(), _2SM6(), MSK6(),
            S6(), M8(), MSf(), Ssa(), Sa()])
    end
end

"""
    function nodal_a!(self::WaveTable, a::AstronomicAngle)::Nothing

Compute nodal corrections from SCHUREMAN (1958).

Indexes used in this routine are internal to the code
and corresponds to the "original" ondes.dat file.
"""
function nodal_a!(self::WaveTable, a::AstronomicAngle)::Nothing
    for item in self.waves
        nodal_a!(item, a)
    end
    nothing
end

"""
    function nodal_g!(self::WaveTable, a::AstronomicAngle)::Nothing

Compute nodal corrections from SCHUREMAN (1958).
Indexes used in this routine are internal to the code and corresponds to
the "original" ondes.dat file.
"""
function nodal_g!(self::WaveTable, a::AstronomicAngle)::Nothing
    for item in self.waves
        nodal_g!(item, a)
    end
    nothing
end

"""
    function admittance!(self::WaveTable)::Nothing

Compute waves by admittance from these 7 major ones : O1, Q1, K1,
2n2, N2, M2, K2."""
function admittance!(self::WaveTable)::Nothing
    # Arrays who contains the spline coefficients needed to compute MU2, NU2,
    # L2, T2 and Lambda2 by admittance.
    mu2 = [0.069439968323, 0.351535557706, -0.046278307672]
    nu2 = [-0.006104695053, 0.156878802427, 0.006755704028]
    l2 = [0.077137765667, -0.051653455134, 0.027869916824]
    t2 = [0.180480173707, -0.020101177502, 0.008331518844]
    lda2 = [0.016503557465, -0.013307812292, 0.007753383202]
    # infer additional constituents by admittance DIURNALS (from Richard Ray
    # perth2 program)

    # from Q1 and O1 (0-1)

    x = self.waves[Int64(kQ1)]
    y = self.waves[Int64(kO1)]
    z = self.waves[Int64(kK1)]

    # 2Q1
    item = self.waves[Int64(k2Q1)]
    if item.admittance
        item.tide = 0.263 * x.tide - 0.0252 * y.tide
    end
    # Sigma1
    item = self.waves[Int64(kSigma1)]
    if item.admittance
        item.tide = 0.297 * x.tide - 0.0264 * y.tide
    end
    # ro1
    item = self.waves[Int64(kRho1)]
    if item.admittance
        item.tide = 0.164 * x.tide + 0.0048 * y.tide
    end

    # from O1 and K1  (1-2)

    # M11
    item = self.waves[Int64(kM11)]
    if item.admittance
        item.tide = 0.0389 * y.tide + 0.0282 * z.tide
    end
    # M12
    item = self.waves[Int64(kM12)]
    if item.admittance
        item.tide = 0.0140 * y.tide + 0.0101 * z.tide
    end
    # CHI1
    item = self.waves[Int64(kChi1)]
    if item.admittance
        item.tide = 0.0064 * y.tide + 0.0060 * z.tide
    end
    # pi1
    item = self.waves[Int64(kPi1)]
    if item.admittance
        item.tide = 0.0030 * y.tide + 0.0171 * z.tide
    end
    # phi1
    item = self.waves[Int64(kPhi1)]
    if item.admittance
        item.tide = -0.0015 * y.tide + 0.0152 * z.tide
    end
    # teta1
    item = self.waves[Int64(kTheta1)]
    if item.admittance
        item.tide = -0.0065 * y.tide + 0.0155 * z.tide
    end
    # J1
    item = self.waves[Int64(kJ1)]
    if item.admittance
        item.tide = -0.0389 * y.tide + 0.0836 * z.tide
    end
    # OO1
    item = self.waves[Int64(kOO1)]
    if item.admittance
        item.tide = -0.0431 * y.tide + 0.0613 * z.tide
    end

    # infer additional constituents by admittance SEMI-DIURNALS
    # (from Richard Ray perth3 program)

    # from M2 - N2
    x = self.waves[Int64(kN2)]
    y = self.waves[Int64(kM2)]

    # 2N2
    item = self.waves[Int64(k2N2)]
    if item.admittance
        item.tide = 0.264 * x.tide - 0.0253 * y.tide
    end

    # SEMI-DIURNAL (from Grenoble to take advantage of 2N2)

    # from 2N2 -N2 (3-4)
    x = self.waves[Int64(k2N2)]
    y = self.waves[Int64(kN2)]

    # eps2
    item = self.waves[Int64(kEps2)]
    if item.admittance
        item.tide = 0.53285 * x.tide - 0.03304 * y.tide
    end

    # from M2 - K2 [5-6]
    x = self.waves[Int64(kN2)]
    y = self.waves[Int64(kM2)]
    z = self.waves[Int64(kK2)]

    # eta2
    item = self.waves[Int64(kEta2)]
    if item.admittance
        item.tide = -0.0034925 * y.tide + 0.0831707 * z.tide
    end

    # from N2 -M2- K2 by spline admittances [see GRL 18[5]:845-848,1991]

    # mu2
    item = self.waves[Int64(kMu2)]
    if item.admittance
        item.tide = mu2[1] * z.tide + mu2[2] * x.tide + mu2[3] * y.tide
    end
    # nu2
    item = self.waves[Int64(kNu2)]
    if item.admittance
        item.tide = nu2[1] * z.tide + nu2[2] * x.tide + nu2[3] * y.tide
    end
    # lambda2
    item = self.waves[Int64(kLambda2)]
    if item.admittance
        item.tide = lda2[1] * z.tide + lda2[2] * x.tide + lda2[3] * y.tide
    end
    # L2
    item = self.waves[Int64(kL2)]
    if item.admittance
        item.tide = l2[1] * z.tide + l2[2] * x.tide + l2[3] * y.tide
    end
    # T2
    item = self.waves[Int64(kT2)]
    if item.admittance
        item.tide = t2[1] * z.tide + t2[2] * x.tide + t2[3] * y.tide
    end
    nothing
end

"""
    function compute_nodal_corrections!(
        self::WaveTable,
        date::DateTime
    )::AstronomicAngle
    
Compute nodal corrections.

Return the astronomic angle, indicating the date on which the tide is to
be calculated.
"""
function compute_nodal_corrections!(
    self::WaveTable,
    date::DateTime
)::AstronomicAngle
    a = AstronomicAngle(date)

    nodal_a!(self, a)
    nodal_g!(self, a)
    a
end


"""
    function find(self::WaveTable, wave_name::String)::Union{Wave, Nothing}

Searches the properties of a wave from its name."""
function find(self::WaveTable, wave_name::String)::Union{Wave, Nothing}
    for item in self.waves
        if name(item) == wave_name
            return item
        end
    end
    nothing
end