# follow convention of Griffth's Electrodynamics when naming coordinates
"""
$(TYPEDEF)

2-dimensional plane-polar coordinates, denoted by ``(s, φ)``.
"""
struct Polar{T<:Real,A<:Real}
    s::T
    φ::A
    function Polar(s::T, φ::A) where {T<:Real,A<:Real}
        nonnegative(s)
        return new{T,A}(s, mod2pi(φ))
    end
end

LinearAlgebra.norm(x::Polar) = x.s
Base.:-(x::Polar) = Polar(x.s, mod2pi(x.φ + π))

function Base.:+(x₁::Polar, x₂::Polar)
    s₁, φ₁, s₂, φ₂ = x₁.s, x₁.φ, x₂.s, x₂.φ

    s = sqrt(s₁^2 + s₂^2 - 2*s₁*s₂*cos(φ₁-φ₂))
    # TODO simplify/expand?
    φ = atan(s₁*sin(φ₁) + s₂*sin(φ₂), s₁*cos(φ₁) + s₂*cos(φ₂))

    return Polar(s, φ)
end

function Base.:-(x₁::Polar, x₂::Polar)
    s₁, φ₁, s₂, φ₂ = x₁.s, x₁.φ, x₂.s, x₂.φ

    s = sqrt(s₁^2 + s₂^2 + 2*s₁*s₂*cos(φ₁-φ₂))
    # TODO simplify/expand?
    φdiff = atan(s₁*sin(φ₁) - s₂*sin(φ₂), s₁*cos(φ₁) - s₂*cos(φ₂))

    return Polar(s, φdiff)
end

Base.:*(c::Real, x::Polar) = Polar(abs(c) * x.s, x.φ + π*(c<0))
Base.:*(x::Polar, c::Real) = Polar(x.s * abs(c), x.φ + π*(c<0))

Base.:/(x::Polar, c::Real) = Polar(x.s / abs(c), x.φ + π*(c<0))
