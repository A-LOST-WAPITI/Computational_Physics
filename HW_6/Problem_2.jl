using Plots;gr()

include("Lagrange.jl")

g(x::Float64)=1/(1+16x^2)
function main()
    anim=@animate for i::UInt8=5:21
        Plot(i,g)
    end
    gif(anim,joinpath(@__DIR__,"Problem_2.gif"),fps=1)
end

@time main()