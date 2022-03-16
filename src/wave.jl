
const freq = Frequency()

"""Possible type of tidal wave."""
@enum TidalType begin
    # Long period tidal waves
    kLongPeriod = 0
    # Short period tidal waves
    kShortPeriod = 1
end

"""Index to access the wave in the internal table."""
@enum Ident begin
    kMm = 1       # %Mm
    kMf = 2       # %Mf
    kMtm = 3      # %Mtm
    kMsqm = 4     # %Msqm
    k2Q1 = 5      # 2Q₁
    kSigma1 = 6   # σ₁
    kQ1 = 7       # Q₁
    kRho1 = 8     # ρ₁
    kO1 = 9       # O₁
    kMP1 = 10      # MP₁
    kM11 = 11     # M₁₁
    kM12 = 12     # M₁₂
    kM13 = 13     # M₁₃
    kChi1 = 14    # χ₁
    kPi1 = 15     # π₁
    kP1 = 16      # P₁
    kS1 = 17      # S₁
    kK1 = 18      # K₁
    kPsi1 = 19    # ψ₁
    kPhi1 = 20    # φ₁
    kTheta1 = 21  # θ₁
    kJ1 = 22      # J₁
    kOO1 = 23     # OO₁
    kMNS2 = 24    # MNS₂
    kEps2 = 25    # ε₂
    k2N2 = 26     # 2N₂
    kMu2 = 27     # µ₂
    k2MS2 = 28    # 2MS₂
    kN2 = 29      # N₂
    kNu2 = 30     # ν₂
    kM2 = 31      # M₂
    kMKS2 = 32    # MKS₂
    kLambda2 = 33 # λ₂
    kL2 = 34      # L₂
    k2MN2 = 35    # 2MN₂
    kT2 = 36      # T₂
    kS2 = 37      # S₂
    kR2 = 38      # R₂
    kK2 = 39      # K₂
    kMSN2 = 40    # MSN₂
    kEta2 = 41    # η₂
    k2SM2 = 42    # 2SM₂
    kMO3 = 43     # MO₃
    k2MK3 = 44    # 2MK₃
    kM3 = 45      # M₃
    kMK3 = 46     # MK₃
    kN4 = 47      # N₄
    kMN4 = 48     # MN₄
    kM4 = 49      # M₄
    kSN4 = 50     # SN₄
    kMS4 = 51     # MS₄
    kMK4 = 52     # MK₄
    kS4 = 53      # S₄
    kSK4 = 54     # SK₄
    kR4 = 55      # R₄
    k2MN6 = 56    # 2MN₆
    kM6 = 57      # M₆
    kMSN6 = 58    # MSN₆
    k2MS6 = 59    # 2MS₆
    k2MK6 = 60    # 2MK₆
    k2SM6 = 61    # 2SM₆
    kMSK6 = 62    # MSK₆
    kS6 = 63      # S₆
    kM8 = 64      # %M8
    kMSf = 65     # %MSf
    kSsa = 66     # %Ssa
    kSa = 67      # %Sa
end

"""
Computes the wave frequency from the doodson arguments

# Arguments
* t Mean solar angle relative to Greenwich
* s moon's mean longitude
* h sun's mean longitude
* p longitude of moon's perigee
* n longitude of moon's ascending node
* p1 longitude of sun's perigee
"""
frequency(
    t::Int64,
    s::Int64,
    h::Int64,
    p::Int64,
    n::Int64,
    p1::Int64
)::Float64 = ((freq.tau + freq.s - freq.h) * t + freq.s * s + freq.h * h +
              freq.p * p + freq.n * n + freq.p1 * p1) * 360.0

"""
    Wave(
        ident::Ident,
        admittance::Bool,
        t::Int64,
        s::Int64,
        h::Int64,
        p::Int64,
        n::Int64,
        p1::Int64,
        shift::Int64,
        eps::Int64,
        nu::Int64,
        nuprim::Int64,
        nusec::Int64,
        type::TidalType,
        calculate_node_factor::Function
    )

Describe the tidal wave

# Arguments
* ident: Index of the wave in the internal table
* admittance: True if the wave is computed by admittance
* t: Mean solar angle relative to Greenwich
* s: moon's mean longitude
* h: sun's mean longitude
* p: longitude of moon's perigee
* n: longitude of moon's ascending node
* p1: longitude of sun's perigee
* shift: TODO
* eps: Coefficient for the longitude in moon's orbit of lunar intersection
* nu: Coefficient for the right ascension of lunar intersection
* nuprim: Coefficient for the term in argument of lunisolar constituent K₁
* nusec: Coefficient for the term in argument of lunisolar constituent K₂
* tidal_type: Type of tidal wave
* calculate_node_factor: Function used to calculate the nodal factor
"""
mutable struct Wave
    """Wave ident"""
    ident::Ident

    """True if wave is computed by admittance."""
    admittance::Bool

    """True if wave is computed dynamically."""
    dynamic::Bool

    """Type of tide."""
    type::TidalType

    """Function to call for computing the node factor"""
    calculate_node_factor::Function

    """Wave frequency."""
    freq::Float64

    """greenwich argument"""
    v::Float64

    """Nodal correction for amplitude."""
    f::Float64

    """nodal correction for phase"""
    u::Float64

    """Tide value."""
    tide::ComplexF64

    """Harmonic constituents (T, s, h, p, N′, p₁, shift, ξ, ν, ν′, ν″)"""
    arg::Vector{Int8}

    function Wave(
        ident::Ident,
        admittance::Bool,
        t::Int64,
        s::Int64,
        h::Int64,
        p::Int64,
        n::Int64,
        p1::Int64,
        shift::Int64,
        eps::Int64,
        nu::Int64,
        nuprim::Int64,
        nusec::Int64,
        type::TidalType,
        calculate_node_factor::Function)
        args = [convert(Int8, t),
            convert(Int8, s),
            convert(Int8, h),
            convert(Int8, p),
            convert(Int8, n),
            convert(Int8, p1),
            convert(Int8, shift),
            convert(Int8, eps),
            convert(Int8, nu),
            convert(Int8, nuprim),
            convert(Int8, nusec)]
        return new(ident, admittance, false, type, calculate_node_factor,
            deg2rad(frequency(t, s, h, p, n, p1)), NaN, NaN, NaN,
            ComplexF64(0, 0), args)
    end
end

"""
    nodal_a!(self::Wave, a::AstronomicAngle)::Nothing

Compute nodal corrections from SCHUREMAN (1958)."""
function nodal_a!(self::Wave, a::AstronomicAngle)::Nothing
    self.f = self.calculate_node_factor(a)
    nothing
end

"""
    function nodal_g!(self::Wave, a::AstronomicAngle)::Nothing

Compute nodal corrections from SCHUREMAN (1958)."""
function nodal_g!(self::Wave, a::AstronomicAngle)::Nothing
    self.v = (self.arg[1] * a.t + self.arg[2] * a.s + self.arg[3] * a.h +
              self.arg[4] * a.p + self.arg[6] * a.p1 + self.arg[7] * pi * 0.5)
    self.u = (self.arg[8] * a.xi + self.arg[9] * a.nu +
              self.arg[10] * a.nuprim + self.arg[11] * a.nusec)
    if self.ident == kL2
        self.u -= a.r
    elseif self.ident == kM13
        self.u -= deg2rad(1.0 / sqrt(2.310 + 1.435 * cos(2 * (a.p - a.xi))))
    end
    nothing
end

"""
    vu(self::Wave)

Gets v (greenwich argument) + u (nodal correction for phase)"""
vu(self::Wave) = (self.v + self.u) % (pi * 2.0)

"""Mm

* V = s - p;
* u = 0;
* f = f(Mm)
"""
Mm() = Wave(kMm, false, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, kLongPeriod, f_mm)

"""Mf

* V = 2s
* u = -2ξ
* f = f(Mf)
"""
Mf() = Wave(kMf, false, 0, 2, 0, 0, 0, 0, 0, -2, 0, 0, 0, kLongPeriod, f_mf)

"""Mtm

* V = 3s - p
* u = -2ξ
* f = f(Mf)
"""
Mtm() = Wave(kMtm, false, 0, 3, 0, -1, 0, 0, 0, -2, 0, 0, 0, kLongPeriod, f_mf)

"""Msqm

* V = 4s - 2h
* u = -2ξ
* f = f(Mf)
"""
Msqm() = Wave(kMsqm, false, 0, 4, -2, 0, 0, 0, 0, -2, 0, 0, 0, kLongPeriod, f_mf)

"""Ssa

* V = 2h
* u = 0
* f = 1
"""
Ssa() = Wave(kSsa, false, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, kLongPeriod, f_1)

"""Sa

* V = h
* u = 0
* f = 1
"""
Sa() = Wave(kSa, false, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, kLongPeriod, f_1)

"""2Q₁

* V = T - 4s + h + 2p + 90°
* u = +2ξ - ν
* f = f(O₁)
"""
_2Q1() = Wave(k2Q1, true, 1, -4, 1, 2, 0, 0, 1, 2, -1, 0, 0, kShortPeriod, f_o1)

"""σ₁

* V = T - 4s + 3h + 90°
* u = +2ξ - ν
* f = f(O₁)
"""
Sigma1() = Wave(kSigma1, true, 1, -4, 3, 0, 0, 0, 1, 2, -1, 0, 0, kShortPeriod, f_o1)

"""
Q₁

* V = T - 3s + h + p + 90°
* u = +2ξ - ν
* f = f(O₁)
"""
Q1() = Wave(kQ1, false, 1, -3, 1, 1, 0, 0, 1, 2, -1, 0, 0, kShortPeriod, f_o1)

"""
ρ₁

* V = T - 3s + 3h - p + 90°
* u = +2ξ - ν
* f = f(O₁)
"""
Rho1() = Wave(kRho1, true, 1, -3, 3, -1, 0, 0, 1, 2, -1, 0, 0, kShortPeriod, f_o1)

"""O₁

* V = T - 2s + h + 90°
* u = +2ξ - ν
* f = f(O₁)
"""
O1() = Wave(kO1, false, 1, -2, 1, 0, 0, 0, 1, 2, -1, 0, 0, kShortPeriod, f_o1)

"""MP₁

* V = T - 2s + 3h - 90°
* u = -ν
* f = f(J₁)
"""
MP1() = Wave(kMP1, false, 1, -2, 3, 0, 0, 0, -1, 0, -1, 0, 0, kShortPeriod, f_j1)

"""M₁₂ (Formula A16)

* V = T - s + h - p - 90°
* u = +2ξ - ν
* f = f(O₁)
"""
M12() = Wave(kM12, true, 1, -1, 1, -1, 0, 0, -1, 2, -1, 0, 0, kShortPeriod, f_o1)

"""M₁₃ (= M11 + M12)

* V = T - s + h + p - 90
* u = -ν
* f = f(M₁₃)
"""
M13() = Wave(kM13, false, 1, -1, 1, 1, 0, 0, -1, 0, -1, 0, 0, kShortPeriod, f_m13)

"""M₁₁ (Formula A23)

* V = T - s + h + p - 90°
* u = -ν
* f = f(J₁)
"""
M11() = Wave(kM11, true, 1, -1, 1, 1, 0, 0, -1, 0, -1, 0, 0, kShortPeriod, f_j1)

"""χ₁

* V = T - s + 3h - p - 90°
* u = -ν
* f = f(J₁)
"""
Chi1() = Wave(kChi1, true, 1, -1, 3, -1, 0, 0, -1, 0, -1, 0, 0, kShortPeriod, f_j1)

"""π₁

* V = T - 2h + p1 + 90°
* u = 0
* f = 1
"""
Pi1() = Wave(kPi1, true, 1, 0, -2, 0, 0, 1, 1, 0, 0, 0, 0, kShortPeriod, f_1)

"""P₁

* V = T - h + 90°
* u = 0
* f = 1
"""
P1() = Wave(kP1, false, 1, 0, -1, 0, 0, 0, 1, 0, 0, 0, 0, kShortPeriod, f_1)

"""S₁

* V = T
* u = 0
* f = 1
"""
S1() = Wave(kS1, false, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, kShortPeriod, f_1)

"""K₁

* V = T + h - 90°
* u = - ν'
* f = f(k₁)
"""
K1() = Wave(kK1, false, 1, 0, 1, 0, 0, 0, -1, 0, 0, -1, 0, kShortPeriod, f_k1)

"""ψ₁

* V = T + 2h - p1 - 90°
* u = 0
* f = 1
"""
Psi1() = Wave(kPsi1, false, 1, 0, 2, 0, 0, -1, -1, 0, 0, 0, 0, kShortPeriod, f_1)

"""φ₁

* V = T + 3h - 90°
* u = 0
* f = 1
"""
Phi1() = Wave(kPhi1, true, 1, 0, 3, 0, 0, 0, -1, 0, 0, 0, 0, kShortPeriod, f_1)

"""θ₁

* V = T + s - h + p - 90°
* u = -ν
* f = f(J₁)
"""
Theta1() = Wave(kTheta1, true, 1, 1, -1, 1, 0, 0, -1, 0, -1, 0, 0, kShortPeriod, f_j1)

"""J₁

* V = T + s + h - p - 90°
* u = -ν
* f = f(J₁)
"""
J1() = Wave(kJ1, true, 1, 1, 1, -1, 0, 0, -1, 0, -1, 0, 0, kShortPeriod, f_j1)

"""OO₁

* V = T + 2s + h - 90°
* u = -2ξ - ν
* f = f(OO₁)
"""
OO1() = Wave(kOO1, true, 1, 2, 1, 0, 0, 0, -1, -2, -1, 0, 0, kShortPeriod, f_oo1)

"""MNS₂ = M₂ + N₂ + S₂

* V = 2T - 5s + 4h + p
* u = +4ξ - 4ν
* f = f(M₂)²
"""
MNS2() = Wave(kMNS2, false, 2, -5, 4, 1, 0, 0, 0, 4, -4, 0, 0, kShortPeriod, f_m22)

"""ε₂

* V = 2T - 5s + 4h + p
* u = +2ξ - 2ν
* f = f(M₂)
"""
Eps2() = Wave(kEps2, true, 2, -5, 4, 1, 0, 0, 0, 2, -2, 0, 0, kShortPeriod, f_m2)

"""2N₂

* V = 2T - 4s + 2h + 2p
* u = +2ξ - 2ν
* f = f(M₂)
"""
_2N2() = Wave(k2N2, true, 2, -4, 2, 2, 0, 0, 0, 2, -2, 0, 0, kShortPeriod, f_m2)


"""µ₂

* V = 2T - 4s + 4h
* u = +2ξ - 2ν
* f = f(M₂)
"""
Mu2() = Wave(kMu2, true, 2, -4, 4, 0, 0, 0, 0, 2, -2, 0, 0, kShortPeriod, f_m2)


"""2MS₂ = 2M₂ - S₂

* V = 2T - 4s + 4h
* u = +4ξ - 4ν
* f = f(M₂)²
"""
_2MS2() = Wave(k2MS2, false, 2, -4, 4, 0, 0, 0, 0, 4, -4, 0, 0, kShortPeriod, f_m22)

"""N₂

* V = 2T - 3s + 2h + p
* u = +2ξ - 2ν
* f = f(M₂)
"""
N2() = Wave(kN2, false, 2, -3, 2, 1, 0, 0, 0, 2, -2, 0, 0, kShortPeriod, f_m2)

"""ν₂

* V = 2T - 3s + 4h - p
* u = +2ξ - 2ν
* f = f(M₂)
"""
Nu2() = Wave(kNu2, true, 2, -3, 4, -1, 0, 0, 0, 2, -2, 0, 0, kShortPeriod, f_m2)


"""M₂

* V = 2T - 2s + 2h
* u = +2ξ - 2ν
* f = f(M₂)
# class M2 : public Wave {
"""
M2() = Wave(kM2, false, 2, -2, 2, 0, 0, 0, 0, 2, -2, 0, 0, kShortPeriod, f_m2)

"""MKS₂ = M₂ + K₂ - S₂

* V = 2T - 2s + 4h
* u = +2ξ - 2ν -2ν''
* f = f(M₂) × f(K₂)
"""
MKS2() = Wave(kMKS2, false, 2, -2, 4, 0, 0, 0, 0, 2, -2, 0, -2, kShortPeriod, f_m2_k2)

"""λ₂

* V = 2T - s + p + 180°
* u = +2ξ - 2ν
* f = f(M₂)
"""
Lambda2() = Wave(kLambda2, true, 2, -1, 0, 1, 0, 0, 2, 2, -2, 0, 0, kShortPeriod, f_m2)

"""L₂

* V = 2T - s + 2h - p + 180°
* u = +2ξ - 2ν - R
* f = f(L₂)
"""
L2() = Wave(kL2, true, 2, -1, 2, -1, 0, 0, 2, 2, -2, 0, 0, kShortPeriod, f_l2)

"""2MN₂ = 2M₂ - N₂

* V = 2T - s + 2h - p + 180°
* u = +2ξ - 2ν
* f = f(M₂)³
"""
_2MN2() = Wave(k2MN2, false, 2, -1, 2, -1, 0, 0, 2, 2, -2, 0, 0, kShortPeriod, f_m23)

"""T₂

* V = 2T - h + p₁
* u = 0
* f = 1
"""
T2() = Wave(kT2, true, 2, 0, -1, 0, 0, 1, 0, 0, 0, 0, 0, kShortPeriod, f_1)

"""S₂

* V = 2T
* u = 0
* f = 1
"""
S2() = Wave(kS2, false, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, kShortPeriod, f_1)


"""R₂

* V = 2T + h - p1 + 180°
* u = 0
* f = 1
"""
R2() = Wave(kR2, false, 2, 0, 1, 0, 0, -1, 2, 0, 0, 0, 0, kShortPeriod, f_1)


"""K₂

* V = 2T + 2h
* u = -2ν″
* f = f(K₂)
"""
K2() = Wave(kK2, false, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, -2, kShortPeriod, f_k2)

"""MSN₂ = M2 + S2 - N2

* V = 2T + s -p
* u = 0
* f = f(M₂)²
"""
MSN2() = Wave(kMSN2, false, 2, 1, 0, -1, 0, 0, 0, 0, 0, 0, 0, kShortPeriod, f_m22)

"""η₂ = KJ₂

* V = 2T + s + 2h - p
* u = -2ν
* f = f(KJ₂)
"""
Eta2() = Wave(kEta2, true, 2, 1, 2, -1, 0, 0, 0, 0, -2, 0, 0, kShortPeriod, f_kj2)

"""2SM₂ = 2S₂ - M₂

* V = 2T + 2s - 2h
* u = -2ξ + 2ν
* f = f(M₂)
"""
_2SM2() = Wave(k2SM2, false, 2, 2, -2, 0, 0, 0, 0, 2, -2, 0, 0, kShortPeriod, f_m2)

"""MO₃ = M₂ + O₁

* V = 3T - 4s + 3h + 90°
* u = 4ξ - 3ν
* f = f(M₂) × f(O₁)
"""
MO3() = Wave(kMO3, false, 3, -4, 3, 0, 0, 0, 1, 4, -3, 0, 0, kShortPeriod, f_m2_o1)


"""2MK₃ = 2M₂ - K₁

* V = 3T - 4s + 3h + 90°
* u = 4ξ - 4ν + ν′
* f = f(M₂)² × f(K₁)
"""
_2MK3() = Wave(k2MK3, false, 3, -4, 3, 0, 0, 0, 1, 4, -4, 1, 0, kShortPeriod, f_m22_k1)

"""M₃

* V = 3T - 3s + 3h
* u = +3ξ - 3ν
* f = f(M₃)
"""
M3() = Wave(kM3, false, 3, -3, 3, 0, 0, 0, 0, 3, -3, 0, 0, kShortPeriod, f_m3)

"""MK₃ = M₂ + K₁

* V = 3T - 2s + 3h - 90°
* u = 2ξ - 2ν - ν′
* f = f(M₂) × f(K₁)
"""
MK3() = Wave(kMK3, false, 3, -2, 3, 0, 0, 0, -1, 2, -2, -1, 0, kShortPeriod, f_m2_k1)

"""N4 = N₂ + N₂

* V = 4T - 6s + 4h + 2p
* u = +4ξ - 4ν
* f = f(M₂)²
"""
N4() = Wave(kN4, false, 4, -6, 4, 2, 0, 0, 0, 4, -4, 0, 0, kShortPeriod, f_m22)

"""MN₄ = M₂ + N₂

* V = 4T - 5s + 4h + p
* u = +4ξ - 4ν
* f = f(M₂)²
"""
MN4() = Wave(kMN4, false, 4, -5, 4, 1, 0, 0, 0, 4, -4, 0, 0, kShortPeriod, f_m22)

"""M₄ = 2M₂

* V = 4T - 4s + 4h
* u = +4ξ - 4ν
* f = f²(M₂)
"""
M4() = Wave(kM4, false, 4, -4, 4, 0, 0, 0, 0, 4, -4, 0, 0, kShortPeriod, f_m22)

"""SN₄ = S₂ + N₂

* V = 4T - 3s + 2h + p
* u = 2ξ - 2ν
* f = f(M₂)
"""
SN4() = Wave(kSN4, false, 4, -3, 2, 1, 0, 0, 0, 2, -2, 0, 0, kShortPeriod, f_m2)

"""MS₄ = M₂ + S₂

* V = 4T - 2s + 2h
* u = +2ξ - 2ν
* f = f(M₂)
"""
MS4() = Wave(kMS4, false, 4, -2, 2, 0, 0, 0, 0, 2, -2, 0, 0, kShortPeriod, f_m2)

"""MK₄ = M₂ + K₂

* V = 4T - 2s + 4h
* u = 2ξ - 2ν - 2ν''
* f = f(MK₄)
"""
MK4() = Wave(kMK4, false, 4, -2, 4, 0, 0, 0, 0, 2, -2, -2, 0, kShortPeriod, f_m2_k2)

"""S₄ = S₂ + S₂

* V = 4T
* u = 0
* f = 1
"""
S4() = Wave(kS4, false, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, kShortPeriod, f_1)

"""SK₄ = S₂ + K₂

* V = 4T + 2h
* u = -2ν''
* f = f(K₂)
"""
SK4() = Wave(kSK4, false, 4, 0, 2, 0, 0, 0, 0, 0, 0, 0, -2, kShortPeriod, f_k2)

"""R₄ = R₂ + R₂

* V = 4T + 2h - 2p1
* u = 0
* f = 1
"""
R4() = Wave(kR4, false, 4, 0, 2, 0, 0, -2, 0, 0, 0, 0, 0, kShortPeriod, f_1)

"""2MN₆ = 2M₂ + N₂

* V = 6T - 7s + 6h + p
* u = 6ξ - 6ν
* f = f(M₂)³
"""
_2MN6() = Wave(k2MN6, false, 6, -7, 6, 1, 0, 0, 0, 6, -6, 0, 0, kShortPeriod, f_m23)

"""M₆ = 3M₂

* V = 6T - 6s + 6h
* u = +6ξ - 6ν
* f = f(M₂)³
"""
M6() = Wave(kM6, false, 6, -6, 6, 0, 0, 0, 0, 6, -6, 0, 0, kShortPeriod, f_m23)

"""MSN₆ = M₂ + S₂ + N₂

* V = 6T - 5s + 4h + p
* u = 4ξ - 4ν
* f = f(M₂)²
"""
MSN6() = Wave(kMSN6, false, 6, -5, 4, 1, 0, 0, 0, 4, -4, 0, 0, kShortPeriod, f_m22)

"""2MS₆ = 2M₂ + S₂

* V = 6T - 4s + 4h
* u = 4ξ - 4ν
* f = f(M₂)²
"""
_2MS6() = Wave(k2MS6, false, 6, -4, 4, 0, 0, 0, 0, 4, -4, 0, 0, kShortPeriod, f_m22)

"""2MK₆ = 2M₂ + K₂

* V = 6T - 4s + 6h
* u = 4ξ - 4ν - 2ν''
* f = f(M₂)² × f(K₂)
"""
_2MK6() = Wave(k2MK6, false, 6, -4, 6, 0, 0, 0, 0, 4, -4, 0, -2, kShortPeriod, f_m23_k2)

"""2SM₆ = 2S₂ + M₂

* V = 6T - 2s + 2h
* u = 2ξ - 2ν
* f = f(M₂)
"""
_2SM6() = Wave(k2SM6, false, 6, -2, 2, 0, 0, 0, 0, 2, -2, 0, 0, kShortPeriod, f_m2)

"""MSK₆ = M₂ + K₂ + S₂

* V = 6T - 2s + 4h
* u = 2ξ - 2ν - 2ν''
* f = f(M₂) × f(K₂)
"""
MSK6() = Wave(kMSK6, false, 6, -2, 4, 0, 0, 0, 0, 2, -2, -2, 0, kShortPeriod, f_m2_k2)

"""S₆ = 3S₂

* V = 6T
* u = 0
* f = 1
"""
S6() = Wave(kS6, false, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, kShortPeriod, f_1)

"""M₈ = 4M₂

* V = 8T - 8s + 8h
* u = 8ξ - 8ν
* f = f(M₂)⁴
"""
M8() = Wave(kM8, false, 8, -8, 8, 0, 0, 0, 0, 8, -8, 0, 0, kShortPeriod, f_m24)

"""MSf = M₂ - S₂

* V = 2s - 2h
* u = 2ξ - 2ν
* f = f(M₂) * f(S2) = f(M₂)

___
Same frequency as MSf LP : 2s -2h
"""
MSf() = Wave(kMSf, false, 0, 2, -2, 0, 0, 0, 0, 2, -2, 0, 0, kLongPeriod, f_m2)

"""
    function name(self::Wave)::String

Gets the wave name"""
function name(self::Wave)::String
    if self.ident == kO1
        return "O1"
    elseif self.ident == kP1
        return "P1"
    elseif self.ident == kK1
        return "K1"
    elseif self.ident == k2N2
        return "2N2"
    elseif self.ident == kMu2
        return "Mu2"
    elseif self.ident == kN2
        return "N2"
    elseif self.ident == kNu2
        return "Nu2"
    elseif self.ident == kM2
        return "M2"
    elseif self.ident == kL2
        return "L2"
    elseif self.ident == kT2
        return "T2"
    elseif self.ident == kS2
        return "S2"
    elseif self.ident == kK2
        return "K2"
    elseif self.ident == kM4
        return "M4"
    elseif self.ident == kS1
        return "S1"
    elseif self.ident == kQ1
        return "Q1"
    elseif self.ident == kMm
        return "Mm"
    elseif self.ident == kMf
        return "Mf"
    elseif self.ident == kMtm
        return "Mtm"
    elseif self.ident == kMsqm
        return "Msqm"
    elseif self.ident == kEps2
        return "Eps2"
    elseif self.ident == kLambda2
        return "Lambda2"
    elseif self.ident == kEta2
        return "Eta2"
    elseif self.ident == k2Q1
        return "2Q1"
    elseif self.ident == kSigma1
        return "Sigma1"
    elseif self.ident == kRho1
        return "Rho1"
    elseif self.ident == kM11
        return "M11"
    elseif self.ident == kM12
        return "M12"
    elseif self.ident == kChi1
        return "Chi1"
    elseif self.ident == kPi1
        return "Pi1"
    elseif self.ident == kPhi1
        return "Phi1"
    elseif self.ident == kTheta1
        return "Theta1"
    elseif self.ident == kJ1
        return "J1"
    elseif self.ident == kOO1
        return "OO1"
    elseif self.ident == kM3
        return "M3"
    elseif self.ident == kM6
        return "M6"
    elseif self.ident == kMN4
        return "MN4"
    elseif self.ident == kMS4
        return "MS4"
    elseif self.ident == kN4
        return "N4"
    elseif self.ident == kR2
        return "R2"
    elseif self.ident == kR4
        return "R4"
    elseif self.ident == kS4
        return "S4"
    elseif self.ident == kMNS2
        return "MNS2"
    elseif self.ident == kM13
        return "M13"
    elseif self.ident == kMK4
        return "MK4"
    elseif self.ident == kSN4
        return "SN4"
    elseif self.ident == kSK4
        return "SK4"
    elseif self.ident == k2MN6
        return "2MN6"
    elseif self.ident == k2MS6
        return "2MS6"
    elseif self.ident == k2MK6
        return "2MK6"
    elseif self.ident == kMSN6
        return "MSN6"
    elseif self.ident == k2SM6
        return "2SM6"
    elseif self.ident == kMSK6
        return "MSK6"
    elseif self.ident == kMP1
        return "MP1"
    elseif self.ident == k2SM2
        return "2SM2"
    elseif self.ident == kPsi1
        return "Psi1"
    elseif self.ident == k2MS2
        return "2MS2"
    elseif self.ident == kMKS2
        return "MKS2"
    elseif self.ident == k2MN2
        return "2MN2"
    elseif self.ident == kMSN2
        return "MSN2"
    elseif self.ident == kMO3
        return "MO3"
    elseif self.ident == k2MK3
        return "2MK3"
    elseif self.ident == kMK3
        return "MK3"
    elseif self.ident == kS6
        return "S6"
    elseif self.ident == kM8
        return "M8"
    elseif self.ident == kMSf
        return "MSf"
    elseif self.ident == kSsa
        return "Ssa"
    elseif self.ident == kSa
        return "Sa"
    end
    return "unknown"
end