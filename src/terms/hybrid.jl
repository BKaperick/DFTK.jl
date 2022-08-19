# E_xc[{\psi_i}] = (1 - a) * E_x[\rho] + a*E_{XX}[{\psi_i}] + E_C[\rho]

# https://mattermodeling.stackexchange.com/questions/4298/exchange-in-hartree-fock-and-kohn-sham-dft?rq=1

# In insulators, "range of exchange interaction" (I think this means decay off diagonal of density matrix) is exponential (a^n for some fixed a)
# Meanwhile for metals (or small/no gap systems, so I guess semi-conductors as well) the decay is only algebraic (n^b for some fixed b)

# Implementation notes:
#  HF exchange is calculated in real space as the sum over all significant interactions in the unit cell and between the unit cell and its neighbors

# PBE0: a*E_x^HF + (1-a)*E_x^PBE

"""
A correlation term, as well as the mixture of the Hartree-Fock exchange energy (exact exchange) with another exchange term
"""
struct Hybrid
    exchange::Term
    correlation::Term
    mixing_factor::Real
    scaling_factor::Real # For constructing the Hartree term
end
abstract type TermHybrid <: TermNonlinear end


function ene_ops(term::TermHybrid, basis::PlaneWaveBasis{T}, ψ, occ; kwargs...) where T
    exact_exchange = TermHartree(term.scaling_factor)
    E = (1-term.mixing_factor) * term.exchange + term.mixing_factor * exact_exchange + term.correlation;

    # Hartree ops example:
    # ρtot_fourier = r_to_G(basis, total_density(ρ))
    # pot_fourier = term.poisson_green_coeffs .* ρtot_fourier
    # pot_real = G_to_r(basis, pot_fourier)
    # E = real(dot(pot_fourier, ρtot_fourier) / 2)

    # ops = [RealSpaceMultiplication(basis, kpt, pot_real) for kpt in basis.kpoints]

    (E=E, ops=[TODO for kpt in basis.kpoints])
end