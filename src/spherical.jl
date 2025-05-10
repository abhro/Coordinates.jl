"""
$(TYPEDEF)

3-dimensional spherical coordinates, denoted by ``(r, θ, φ)``.
"""
struct Spherical{T<:Real,A<:Real}
    r::T
    θ::A # polar angle
    φ::A # azimuthal angle
    function Spherical(r::T, θ::A, φ::T) where {T<:Real,A<:Real}
        nonnegative(r)
        return new{T,A}(r, mod2pi(θ), mod2pi(φ))
    end
end
LinearAlgebra.norm(x::Spherical) = x.r
