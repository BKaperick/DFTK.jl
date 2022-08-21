"""
Hybrid term
"""
struct Hybrid
end

(Hybrid::Hybrid)(basis)   = TermHybrid(basis, Hybrid.scaling_factor)
function Base.show(io::IO, Hybrid::Hybrid)
    print(io, "Hybrid()")
end

struct TermHybrid <: TermNonlinear
end
function TermHybrid(basis::PlaneWaveBasis{T}) where T
    model = basis.model

    TermHybrid()
end

@timing "ene_ops: Hybrid" function ene_ops(term::TermHybrid, basis::PlaneWaveBasis{T},
                                            ψ, occ; ρ, kwargs...) where {T}
    ρtot_fourier = r_to_G(basis, total_density(ρ))
    pot_fourier = term.poisson_green_coeffs .* ρtot_fourier
    pot_real = G_to_r(basis, pot_fourier)
    E = real(dot(pot_fourier, ρtot_fourier) / 2)

    ops = [RealSpaceMultiplication(basis, kpt, pot_real) for kpt in basis.kpoints]
    (E=E, ops=ops)
end

function compute_kernel(term::TermHybrid, basis::PlaneWaveBasis; kwargs...)
end

function apply_kernel(term::TermHybrid, basis::PlaneWaveBasis, δρ; kwargs...)
end
