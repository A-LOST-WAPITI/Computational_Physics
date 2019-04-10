include(joinpath(@__DIR__,"Brent.jl"))

function main()
    h::Float64=0.5
    tolerance::Float64=10^(-8)
    maxIndex::UInt32=500

    f(x::Float64)=x*tan(x)-sqrt(h^2-x^2)

    Find(f,h,tolerance,maxIndex)
end

@time main()