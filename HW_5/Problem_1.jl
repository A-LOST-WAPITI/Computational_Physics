using Plots;gr()

include("Brent.jl")

function main()
    h::Float64=0.5
    tolerance::Float64=10^(-8)
    maxIndex::UInt32=500

    f(x::Float64)=x*tan(x)-sqrt(h^2-x^2)

    root=Find(f,h,tolerance,maxIndex)
    println("$root")
end

@time main()

function Plot()
    N::UInt16=1000

    tolerance::Float64=10^(-8)
    maxIndex::UInt32=50
    H=Array{Float64}(LinRange(0.5,10,N))
    result=zeros(Float64,N)
  
    for i=1:N
        g(x::Float64)=x*cot(x)+sqrt(H[i]^2-x^2)
        result[i]=Find(g,H[i],tolerance,maxIndex)
    end
  
    plot(H,result,seriestype=:scatter,title="h-root distribution",label="roots")
    png(joinpath(@__DIR__,"h-root_distribution.png"))
end

@time Plot()