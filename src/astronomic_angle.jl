using Dates

"""
    AstronomicAngle(date::DateTime)

Astronomic angle

* t: Hour angle of mean sun.
* n: Longitude of moon's node
* h: Mean longitude of the sun.
* s: Mean longitude of the moon.
* p1: Mean longitude of solar perigee.
* p: Mean longitude of lunar perigee.
* i: Obliquity of lunar orbit with respect to earth's equator
* xi: Longitude in moon's orbit of lunar intersection
* nu: Right ascension of lunar intersection
* x1ra: Factor in amplitude of constituent L₂
* r: Term in argument of constituent L₂
* nuprim: Term in argument of lunisolar constituent K₁
* nusec: Term in argument of lunisolar constituent K₂
"""
struct AstronomicAngle
    t::Float64
    n::Float64
    h::Float64
    s::Float64
    p1::Float64
    p::Float64
    i::Float64
    xi::Float64
    nu::Float64
    x1ra::Float64
    r::Float64
    nuprim::Float64
    nusec::Float64

    function AstronomicAngle(date::DateTime)
        # 25567 number between 1900-01-01 and 1970-01-01
        jc = ((datetime2unix(date) / 86400.0) + 25567) / 36525.0

        jc_squared = jc^2

        # T mean solar angle relative to Greenwich
        t_ = (pi + 2pi * 36525 * jc) % 2pi

        # SCHUREMAN FORMULAE P. 162 (oder 2 is enough)

        # Longitude of moon's node (N)
        n_ = deg2rad(normalize_angle(
            259.1560564 - 1934.1423972 * jc + 0.0021056 * jc_squared))

        # Mean longitude of sun (h)
        h_ = deg2rad(normalize_angle(
            280.1895014 + 36000.768925 * jc + 0.0003025 * jc_squared))

        # Mean longitude of moon (s)
        s_ = deg2rad(normalize_angle(
            277.0256206 + 481267.892 * jc + 0.002525 * jc_squared))

        # Longitude of solar perigee (p₁)
        p1_ = deg2rad(normalize_angle(
            281.2208569 + 1.719175 * jc + 0.0004528 * jc_squared))

        # Longitude of lunar perigee (p)
        p_ = deg2rad(normalize_angle(
            334.3837215 + 4069.0322056 * jc - 0.0103444 * jc_squared))

        # SCHUREMAN FORMULAE P. 156
        u = 0.913694997 - 0.035692561 * cos(n_)

        # Inclination of the moon's orbit to the celestial equator
        i_ = acos(u)

        tgn2 = tan(n_ * 0.5)
        at1 = atan(1.01883 * tgn2)
        at2 = atan(0.64412 * tgn2)

        # Longitude in moon's orbit of lunar intersection
        xi_ = -at1 - at2 + n_

        if n_ > pi
            xi_ -= 2pi
        end

        # Right ascension of lunar intersection
        nu_ = at1 - at2

        # for constituents l2, k1, k2
        tgi2 = tan(i_ * 0.5)

        # SCHUREMAN P. 41 (191)
        # Mean longitude  of the lunar perigee reckoned from the lunar intersection
        p = p_ - xi_

        # SCHUREMAN P. 44 (213)
        x1ra_ = sqrt(1.0 - 12.0 * (tgi2^2) * cos(2.0 * p) +
                     36.0 * (tgi2^4))

        # SCHUREMAN P. 41 (196)
        r_ = atan(sin(2.0 * p) /
                  (1.0 / (6.0 * (tgi2^2)) - cos(2.0 * p)))

        # SCHUREMAN P. 45 (224)
        nuprim_ = atan(sin(2.0 * i_) * sin(nu_) /
                       (sin(2.0 * i_) * cos(nu_) + 0.3347))

        # SCHUREMAN P. 46 (232)
        nusec_ = 0.5 *
                 atan(((sin(i_)^2) * sin(2.0 * nu_)) /
                      ((sin(i_)^2) * cos(2.0 * nu_) + 0.0727))

        new(t_, n_, h_, s_, p1_, p_, i_, xi_, nu_, x1ra_, r_, nuprim_, nusec_)
    end
end

"""
    f_o1(self::AstronomicAngle)::Float64

f_o1 = sin I cos² ½I / 0.3800"""
f_o1(self::AstronomicAngle)::Float64 = sin(
    self.i) * cos(self.i * 0.5)^2 / 0.3800

"""
    f_oo1(self::AstronomicAngle)::Float64

f_oo1 = sin I sin² ½I / 0.0164"""
f_oo1(self::AstronomicAngle)::Float64 = sin(
    self.i) * sin(self.i * 0.5)^2 / 0.01640

"""
    f_1(self::AstronomicAngle)::Float64

f_1 = 1"""
f_1(self::AstronomicAngle)::Float64 = 1.0

"""
    f_j1(self::AstronomicAngle)::Float64

f_j1  = sin 2I / 0.7214"""
f_j1(self::AstronomicAngle)::Float64 = sin(2.0 * self.i) / 0.7214

"""
    f_m13(self::AstronomicAngle)::Float64

f_m13 = (1 -10 sin² ½I + 15 sin⁴ ½I) cos² ½I / 0.5873"""
f_m13(self::AstronomicAngle)::Float64 = f_o1(
    self) * sqrt(2.310 + 1.435 * cos(2.0 * (self.p - self.xi)))

"""
    f_m2(self::AstronomicAngle)::Float64

f_m2 = cos⁴ ½I / 0.9154"""
f_m2(self::AstronomicAngle)::Float64 = cos(self.i * 0.5)^4 / 0.9154

"""
    f_m3(self::AstronomicAngle)::Float64

f_m3 = cos⁶ ½I / 0.8758"""
f_m3(self::AstronomicAngle)::Float64 = cos(self.i * 0.5)^6 / 0.8758

"""
    f_mf(self::AstronomicAngle)::Float64

f_mf = sin² I / 0.1578"""
f_mf(self::AstronomicAngle)::Float64 = sin(self.i)^2 / 0.1578

"""
    f_mm(self::AstronomicAngle)::Float64

f_mm = (2/3 - sin² I) / 0.5021"""
f_mm(self::AstronomicAngle)::Float64 = (2.0 / 3.0 - sin(self.i)^2) / 0.5021

"""
    f_m22(self::AstronomicAngle)::Float64

f_m22 = f²(M₂)"""
f_m22(self::AstronomicAngle)::Float64 = f_m2(self)^2

"""
    f_m23(self::AstronomicAngle)::Float64

f_m23 = f(M₂)³"""
f_m23(self::AstronomicAngle)::Float64 = f_m2(self)^3

"""
    f_m24(self::AstronomicAngle)::Float64

f_m24 = f(M₂)⁴"""
f_m24(self::AstronomicAngle)::Float64 = f_m2(self)^4

"""
    f_k1(self::AstronomicAngle)::Float64

f_k1 = √(0.8965 sin² 2I+0.6001 sin 2I cos ν + 0.1006)"""
f_k1(self::AstronomicAngle)::Float64 = sqrt(
    0.8965 * sin(2.0 * self.i)^2 + 0.6001 * sin(2.0 * self.i) * cos(
                                       self.nu) + 0.1006)

"""
    f_k2(self::AstronomicAngle)::Float64

f_k2 = √(19.0444 sin⁴ I + 2.7702 sin² I cos 2ν + 0.0981)"""
f_k2(self::AstronomicAngle)::Float64 = sqrt(
    19.0444 * sin(self.i)^4 + 2.7702 * sin(self.i)^2 * cos(
                                  2.0 * self.nu) + 0.0981)

"""
    f_kj2(self::AstronomicAngle)::Float64

f_kj2 = sin² I / 0.1565 (formula #79)"""
f_kj2(self::AstronomicAngle)::Float64 = sin(self.i)^2 / 0.1565

"""f_l2 = _f_m2() * 1 / Ra"""
f_l2(self::AstronomicAngle)::Float64 = f_m2(self) * self.x1ra

"""
    f_m2_k2(self::AstronomicAngle)::Float64

f_m2_k2 = f(M₂) * f(K₂)"""
f_m2_k2(self::AstronomicAngle)::Float64 = f_m2(self) * f_k2(self)

"""
    f_m2_k1(self::AstronomicAngle)::Float64

f_m2_k1 = f(M₂) * f(K₁)"""
f_m2_k1(self::AstronomicAngle)::Float64 = f_m2(self) * f_k1(self)

"""
    f_m2_o1(self::AstronomicAngle)::Float64

f_m2_o1 = f(M₂) * f(O₁)"""
f_m2_o1(self::AstronomicAngle)::Float64 = f_m2(self) * f_o1(self)

"""
    f_m22_k1(self::AstronomicAngle)::Float64

f_m22_k1 = f(M₂)² * f(K₁)"""
f_m22_k1(self::AstronomicAngle)::Float64 = f_m22(self) * f_k1(self)

"""
    f_m23_k2(self::AstronomicAngle)::Float64

f_m23_k2 = f(M₂)³ * f(K₂)"""
f_m23_k2(self::AstronomicAngle)::Float64 = f_m23(self) * f_k2(self)
