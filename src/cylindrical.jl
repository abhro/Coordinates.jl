struct Cylindrical{T<:Real,A<:Real}
    s::T
    φ::A # azimuthal angle
    z::T
    function Cylindrical(s::T, φ::A, z::T) where {T<:Real,A<:Real}
        nonnegative(s)
        return new{T,A}(s, mod2pi(φ), z)
    end
end
LinearAlgebra.norm(x::Cylindrical) = hypot(x.s, x.z)
Base.:-(x::Cylindrical) = Cylindrical(x.s, mod2pi(x.φ + π), -x.z)

function Base.:+(x₁::Cylindrical, x₂::Cylindrical)
    s₁, φ₁, z₁, s₂, φ₂, z₂ = x₁.s, x₁.φ, x₁.z, x₂.s, x₂.φ, x₂.z

    ssum = sqrt(s₁^2 + s₂^2 - 2*s₁*s₂*cos(φ₁-φ₂))
    # TODO simplify/expand?
    φsum = atan(s₁*sin(φ₁) + s₂*sin(φ₂), s₁*cos(φ₁) + s₂*cos(φ₂))
    zsum = z₁ + z₂

    return Cylindrical(ssum, φsum, zsum)
end

function Base.:-(x₁::Cylindrical, x₂::Cylindrical)
    s₁, φ₁, z₁, s₂, φ₂, z₂ = x₁.s, x₁.φ, x₁.z, x₂.s, x₂.φ, x₂.z

    sdiff = sqrt(s₁^2 + s₂^2 + 2*s₁*s₂*cos(φ₁-φ₂))
    # TODO simplify/expand?
    φdiff = atan(s₁*sin(φ₁) - s₂*sin(φ₂), s₁*cos(φ₁) - s₂*cos(φ₂))
    zdiff = z₁ - z₂

    return Cylindrical(sdiff, φdiff, zdiff)
end

# the +π trick is to take care of negative c
Base.:*(c::Real, x::Cylindrical) = Cylindrical(abs(c) * x.s, x.φ + π*(c<0), c * x.z)
Base.:*(x::Cylindrical, c::Real) = Cylindrical(x.s * abs(c), x.φ + π*(c<0), x.z * c)

Base.:/(x::Cylindrical, c::Real) = Cylindrical(x.s / abs(c), x.φ + π*(c<0), x.z / c)

