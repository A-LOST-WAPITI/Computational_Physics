include("Brent.jl")

function BalanceFunc(r::Float64)
    G::Float64=6.674e-11
    M::Float64=5.974e24
    m::Float64=7.348e22
    R::Float64=3.844e8
    ω::Float64=2.662e-6
    
    result::Float64=G*M/r^2-G*m/(R-r)^2-ω^2*r
    return result
end

function main()
    h::Float64=3.844e8
    tolerance::Float64=10^2
    maxIndex::UInt32=500

    Find(BalanceFunc,h,tolerance,maxIndex)
end

@time main()