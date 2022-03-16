"""Number of seconds in one Julian century."""
const JULIAN_CENTURY = 3155760000.0

"""

    Speed()

Orbital parameters of the speeds of the moon and the sun.

* s : speed in degree by hour for the moon's mean longitude
* h : speed in degree by hour for the sun's mean longitude
* p : speed in degree by hour for the longitude of moon's perigee
* N' : speed in degree by hour for the longitude of moon's ascending node 
* p₁ : speed in degree by hour for the longitude of sun's perigee 
* τ : speed in degree by hour for the local mean lunar time
"""
struct Speed
    s::Float64
    h::Float64
    p::Float64
    n::Float64
    p1::Float64
    tau::Float64

    function Speed()
        s = (((1336.0 * 360.0 + 307.892) / JULIAN_CENTURY)) * 3600.0
        h = (((100.0 * 360.0 + 0.769) / JULIAN_CENTURY)) * 3600.0
        new(
            s,
            h,
            (((11.0 * 360.0 + 109.032) / JULIAN_CENTURY)) * 3600.0,
            (((-5.0 * 360.0 - 134.142) / JULIAN_CENTURY)) * 3600.0,
            ((1.719 / JULIAN_CENTURY)) * 3600,
            15.0 - s + h)
    end
end

"""
    Frequency()

Orbital parameters of the frequencies of the moon and the sun.

* s : frequency in degree by hour for the moon's mean longitude
* h : frequency in degree by hour for the sun's mean longitude
* p : frequency in degree by hour for the longitude of moon's perigee
* N' : frequency in degree by hour for the longitude of moon's ascending node 
* p₁ : frequency in degree by hour for the longitude of sun's perigee 
* τ : frequency in degree by hour for the local mean lunar time
"""
struct Frequency
    s::Float64
    h::Float64
    p::Float64
    n::Float64
    p1::Float64
    tau::Float64

    function Frequency()
        speed = Speed()
        new(
            1.0 / ((15.0 / speed.s) * 24.0),
            1.0 / ((15.0 / speed.h) * 24.0),
            1.0 / ((15.0 / speed.p) * 24.0),
            1.0 / ((15.0 / speed.n) * 24.0),
            1.0 / ((15.0 / speed.p1) * 24.0),
            1.0 / ((15.0 / speed.tau) * 24.0))
    end
end
