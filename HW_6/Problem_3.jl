using Plots;gr()

include("Lagrange.jl")

g(x::Float64)=x*sin(2pi*x+1)
function main()
    anim=@animate for i::UInt8=5:21
        Plot(i,g)
    end
    gif(anim,joinpath(@__DIR__,"Problem_3.gif"),fps=1)
end

@time main()