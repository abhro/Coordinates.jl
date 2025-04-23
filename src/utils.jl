nonnegative(x::Real) = x < 0 && throw(DomainError(x, "Value must be ≥ 0"))
positive(x::Real) = x ≤ 0 && throw(DomainError(x, "Value must be > 0"))
