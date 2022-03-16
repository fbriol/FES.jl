using LinearAlgebra

const W3RD = Matrix{Float64}([
    0.0 0.0 1.0 0.0 0.0 -0.00021
    0.0 2.0 -1.0 0.0 0.0 -0.00004
    1.0 -2.0 0.0 0.0 0.0 0.00004
    1.0 0.0 0.0 -1.0 0.0 0.00019
    1.0 0.0 0.0 0.0 0.0 -0.00375
    1.0 0.0 0.0 1.0 0.0 -0.00059
    1.0 0.0 0.0 2.0 0.0 0.00005
    2.0 -2.0 1.0 0.0 0.0 -0.00012
    2.0 0.0 -1.0 0.0 0.0 -0.00061
    2.0 0.0 -1.0 1.0 0.0 -0.00010
    3.0 -2.0 0.0 0.0 0.0 -0.00010
    3.0 0.0 -2.0 0.0 0.0 -0.00007
    3.0 0.0 0.0 0.0 0.0 -0.00030
    3.0 0.0 0.0 1.0 0.0 -0.00019
    3.0 0.0 0.0 2.0 0.0 -0.00004
    4.0 0.0 -1.0 0.0 0.0 -0.00008
    4.0 0.0 -1.0 1.0 0.0 -0.00005
])

"""
    WaveOrder2()

Properties of the wave order 2 coefficients values to compute the
long-period equilibrium ocean tides."""
struct WaveOrder2
    data::Matrix{Float64}

    function WaveOrder2()
        return new([
            0.0 0.0 0.0 1.0 0.0 0.02793  #      1
            0.0 0.0 0.0 2.0 0.0 -0.00027  #     2
            0.0 0.0 2.0 1.0 0.0 0.00004  #      3
            0.0 1.0 0.0 -1.0 -1.0 -0.00004  #   4
            0.0 1.0 0.0 0.0 -1.0 -0.00492  #    5
            0.0 1.0 0.0 0.0 1.0 0.00026  #      6
            0.0 1.0 0.0 1.0 -1.0 0.00005  #     7
            0.0 2.0 -2.0 -1.0 0.0 0.00002  #    8
            0.0 2.0 -2.0 0.0 0.0 -0.00031  #    9
            0.0 2.0 0.0 0.0 0.0 -0.03095  #    10 - Ssa
            0.0 2.0 0.0 0.0 -2.0 -0.00008  #   11
            0.0 2.0 0.0 1.0 0.0 0.00077  #     12 - Ssa
            0.0 2.0 0.0 2.0 0.0 0.00017  #     13 - Ssa
            0.0 3.0 0.0 0.0 -1.0 -0.00181  #   14
            0.0 3.0 0.0 1.0 -1.0 0.00003  #    15
            0.0 4.0 0.0 0.0 -2.0 -0.00007  #   16
            1.0 -3.0 1.0 -1.0 1.0 0.00002  #   17
            1.0 -3.0 1.0 0.0 1.0 -0.00029  #   18
            1.0 -3.0 1.0 1.0 1.0 0.00002  #    19
            1.0 -2.0 -1.0 -2.0 0.0 0.00003  #  20
            1.0 -2.0 -1.0 -1.0 0.0 0.00007  #  21
            1.0 -2.0 1.0 -1.0 0.0 0.00048  #   22
            1.0 -2.0 1.0 0.0 0.0 -0.00673  #   23
            1.0 -2.0 1.0 1.0 0.0 0.00043  #    24
            1.0 -1.0 -1.0 -1.0 1.0 0.00002  #  25
            1.0 -1.0 -1.0 0.0 1.0 -0.00021  #  26
            1.0 -1.0 -1.0 1.0 1.0 0.00000  #   27
            1.0 -1.0 0.0 0.0 0.0 0.00020  #    28
            1.0 -1.0 1.0 0.0 -1.0 0.00005  #   29
            1.0 0.0 -1.0 -2.0 0.0 -0.00003  #  30 - Mm for FES2014
            1.0 0.0 -1.0 -1.0 0.0 0.00231  #   31 - Mm for FES2014
            1.0 0.0 -1.0 0.0 0.0 -0.03518  #   32 - Mm
            1.0 0.0 -1.0 1.0 0.0 0.00228  #    33 - Mm
            1.0 0.0 1.0 0.0 0.0 0.00189  #     34
            1.0 0.0 1.0 1.0 0.0 0.00077  #     35
            1.0 0.0 1.0 2.0 0.0 0.00021  #     36
            1.0 1.0 -1.0 0.0 -1.0 0.00018  #   37
            1.0 2.0 -1.0 0.0 0.0 0.00049  #    38
            1.0 2.0 -1.0 1.0 0.0 0.00024  #    39
            1.0 2.0 -1.0 2.0 0.0 0.00004  #    40
            1.0 3.0 -1.0 0.0 -1.0 0.00003  #   41
            2.0 -4.0 2.0 0.0 0.0 -0.00011  #   42
            2.0 -3.0 0.0 0.0 1.0 -0.00038  #   43
            2.0 -3.0 0.0 1.0 1.0 0.00002  #    44
            2.0 -2.0 0.0 -1.0 0.0 -0.00042  #  45
            2.0 -2.0 0.0 0.0 0.0 -0.00582  #   46
            2.0 -2.0 0.0 1.0 0.0 0.00037  #    47
            2.0 -2.0 2.0 0.0 0.0 0.00004  #    48
            2.0 -1.0 -2.0 0.0 1.0 -0.00004  #  49
            2.0 -1.0 -1.0 0.0 0.0 0.00003  #   50
            2.0 -1.0 0.0 0.0 -1.0 0.00007  #   51
            2.0 -1.0 0.0 0.0 1.0 -0.00020  #   52
            2.0 -1.0 0.0 1.0 1.0 -0.00004  #   53
            2.0 0.0 -2.0 -1.0 0.0 0.00015  #   54
            2.0 0.0 -2.0 0.0 0.0 -0.00288  #   55
            2.0 0.0 -2.0 1.0 0.0 0.00019  #    56
            2.0 0.0 0.0 0.0 0.0 -0.06662  #    57 - Mf
            2.0 0.0 0.0 1.0 0.0 -0.02762  #    58 - Mf
            2.0 0.0 0.0 2.0 0.0 -0.00258  #    59 - Mf
            2.0 0.0 0.0 3.0 0.0 0.00007  #     60 - Mf
            2.0 1.0 -2.0 0.0 -1.0 0.00003  #   61
            2.0 1.0 0.0 0.0 -1.0 0.00023  #    62
            2.0 1.0 0.0 1.0 -1.0 0.00006  #    63
            2.0 2.0 -2.0 0.0 0.0 0.00020  #    64
            2.0 2.0 -2.0 1.0 0.0 0.00008  #    65
            2.0 2.0 0.0 2.0 0.0 0.00003  #     66
            3.0 -5.0 1.0 0.0 1.0 -0.00002  #   67
            3.0 -4.0 1.0 0.0 0.0 -0.00017  #   68
            3.0 -3.0 -1.0 0.0 1.0 -0.00007  #  69
            3.0 -3.0 1.0 0.0 1.0 -0.00012  #   70
            3.0 -3.0 1.0 1.0 1.0 -0.00004  #   71
            3.0 -2.0 -1.0 -1.0 0.0 -0.00010  # 72
            3.0 -2.0 -1.0 0.0 0.0 -0.00091  #  73
            3.0 -2.0 -1.0 1.0 0.0 0.00006  #   74
            3.0 -2.0 1.0 0.0 0.0 -0.00242  #   75
            3.0 -2.0 1.0 1.0 0.0 -0.00100  #   76
            3.0 -2.0 1.0 2.0 0.0 -0.00009  #   77
            3.0 -1.0 -1.0 0.0 1.0 -0.00013  #  78
            3.0 -1.0 -1.0 1.0 1.0 -0.00004  #  79
            3.0 -1.0 0.0 0.0 0.0 0.00006  #    80
            3.0 -1.0 0.0 1.0 0.0 0.00003  #    81
            3.0 -1.0 1.0 0.0 -1.0 0.00003  #   82
            3.0 0.0 -3.0 0.0 0.0 -0.00023  #   83
            3.0 0.0 -3.0 1.0 -1.0 0.00004  #   84
            3.0 0.0 -3.0 1.0 1.0 0.00004  #    85
            3.0 0.0 -1.0 0.0 0.0 -0.01275  #   86 - Mtm
            3.0 0.0 -1.0 1.0 0.0 -0.00528  #   87 - Mtm
            3.0 0.0 -1.0 2.0 0.0 -0.00051  #   88 - Mtm
            3.0 0.0 1.0 2.0 0.0 0.00005  #     89
            3.0 0.0 1.0 3.0 0.0 0.00002  #     90
            3.0 1.0 -1.0 0.0 -1.0 0.00011  #   91
            3.0 1.0 -1.0 1.0 -1.0 0.00004  #   92
            4.0 -4.0 0.0 0.0 0.0 -0.00008  #   93
            4.0 -4.0 2.0 0.0 0.0 -0.00006  #   94
            4.0 -4.0 2.0 1.0 0.0 -0.00002  #   95
            4.0 -3.0 0.0 0.0 1.0 -0.00014  #   96
            4.0 -3.0 0.0 1.0 1.0 -0.00006  #   97
            4.0 -2.0 -2.0 0.0 0.0 -0.00011  #  98
            4.0 -2.0 0.0 0.0 0.0 -0.00205  #   99 - Msqm
            4.0 -2.0 0.0 1.0 0.0 -0.00085  #  100 - Msqm
            4.0 -2.0 0.0 2.0 0.0 -0.00008  #  101 - Msqm for FES2001
            4.0 -1.0 -2.0 0.0 1.0 -0.00003  # 102
            4.0 -1.0 0.0 0.0 -1.0 0.00003  #  103
            4.0 0.0 -2.0 0.0 0.0 -0.00169  #  104
            4.0 0.0 -2.0 1.0 0.0 -0.00070  #  105
            4.0 0.0 -2.0 2.0 0.0 -0.00006  #  106
        ])
    end
end

"""
    function disable_dynamic_wave!(self::WaveOrder2, wt::WaveTable)::Nothing

Disable the dynamic wave used for the calculation of the long-period
equilibrium ocean tides."""
function disable_dynamic_wave!(self::WaveOrder2, wt::WaveTable)::Nothing
    # Indexes are the same as those defined starting from l.389
    if wt.waves[Int64(kMm)].dynamic
        self.data[30, :] .= 0
        self.data[31, :] .= 0
        self.data[32, :] .= 0
        self.data[33, :] .= 0
    end
    if wt.waves[Int64(kMf)].dynamic
        self.data[57, :] .= 0
        self.data[58, :] .= 0
        self.data[59, :] .= 0
        self.data[60, :] .= 0
    end
    if wt.waves[Int64(kMtm)].dynamic
        self.data[86, :] .= 0
        self.data[87, :] .= 0
        self.data[88, :] .= 0
    end
    if wt.waves[Int64(kMsqm)].dynamic
        self.data[99, :] .= 0
        self.data[100, :] .= 0
        self.data[101, :] .= 0
    end
    if wt.waves[Int64(kSsa)].dynamic
        self.data[9, :] .= 0
        self.data[11, :] .= 0
        self.data[12, :] .= 0
    end
    nothing
end

"""
    function lpe_minus_n_waves(
        self::WaveOrder2,
        a::AstronomicAngle,
        lat::Float64
    )::Float64

Computes the long-period equilibrium ocean tides in centimeters.

The complete tidal spectral lines from the Cartwright-Tayler-Edden
tables are summed over to compute the long-period tide.

Order 2 and order 3 of the tidal potential for the long period waves is
now taken into account.

The decomposition was validated compared to the potential proposed by
Tamura.

Waves computed dynamically are removed.

# Technical references:
* Cartwright & Tayler, Geophys. J. R.A.S., 23, 45, 1971.
* Cartwright & Edden, Geophys. J. R.A.S., 33, 253, 1973.
* Tamura Y., Bull. d'information des marees terrestres, Vol. 99, 1987.

# Arguments
* a: the astronomic angle, indicating the date on which the tide is to be
  calculated.
* lat: Latitude in degrees (positive north) for the position at which
  tide is computed.

# Returns
Computed long-period tide, in centimeters.
"""
function lpe_minus_n_waves(
    self::WaveOrder2,
    a::AstronomicAngle,
    lat::Float64
)::Float64
    # Vector containing the required nodal corrections.
    shpn = [a.s, a.h, a.p, -a.n, a.p1]

    # Tidal potential V20
    h20 = 0.0
    for row in eachrow(self.data)
        h20 += cos(dot(row[1:5], shpn)) * row[6]
    end

    # Tidal potential V30
    h30 = 0.0
    for row in eachrow(W3RD)
        h30 += sin(dot(row[1:5], shpn)) * row[6]
    end

    sy = sind(lat)
    sy2 = sy^2
    c20 = sqrt(5.0 / 4pi) * (1.5 * sy2 - 0.5)
    c30 = sqrt(7.0 / 4pi) * (2.5 * sy2 - 1.5) * sy

    # m -> cm
    # H2 = 0.609
    # H3 = 0.291
    # K2 = 0.302
    # K3 = 0.093
    ((1.0 - 0.609 + 0.302) * c20 * h20 + (1.0 - 0.291 + 0.093) * c30 * h30) * 100
end