"""
Hybrid energy functional: A linear combination of the Hartree Fock energy term, and other terms
"""
struct Hybrid
    scaling_factor::Real
end
Hybrid() = Hybrid(1)
(K::Hybrid)(basis) = TermHybrid(basis; scaling_factor=K.scaling_factor)

struct TermHybrid <: Term
    basis::PlaneWaveBasis
    hartree_term::TermHartree
    linear_coeffs::Vector{Int} # Weighting for different terms
end

function TermHybrid(basis::PlaneWaveBasis; scaling_factor=1)
end
