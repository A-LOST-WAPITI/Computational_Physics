include("../Brent.jl")

function P(x::Float64)
    par::Array{Int32}=[924,-2772,3150,-1680,420,-42,1]
    X::Array{Float64}=[x^(i) for i=6:-1:0]
    result::Float64=sum(X.*par)
    return result
end
function main()
    starts::Array{Float64}=[0,0.1,0.3,0.6,0.8,0.9]
    h::Float64=0.1
    maxIndex::UInt32=50
    tolerance::Float64=10^(-8)
    result=zeros(Float64,6)
    
    result.=Find.((P,),(h,),(tolerance,),(maxIndex,),starts)
end

@time main()