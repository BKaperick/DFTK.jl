"""
Exact exchange term: the Hartree-Fock exchange energy of the orbitals


-1/2 ∑ ∫ϕ_i^*(r)ϕ_j^*(r')ϕ_i(r')ϕ_j(r) / |r - r'| dr dr'

"""
struct ExactExchange
end
(K::ExactExchange)(basis) = TermExactExchange(basis)

struct TermExactExchange <: Term # TODO: maybe should be TermNonLinear ?
    basis::PlaneWaveBasis
end

function TermExactExchange(basis::PlaneWaveBasis)
end

function ene_ops(term::TermExactExchange, basis::PlaneWaveBasis, ψ, occ; kwargs...)
    # 1. Calculate energy integral, set as E
    # 2. 
    (E=, ops=[NoopOperator(basis, kpt) for kpt in basis.kpoints])
end
