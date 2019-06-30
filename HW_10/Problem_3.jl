using Plots;gr()

include("../HW_9/Adaptive.jl")

function calculate(D)
    result=2
    for i=2:D
        func(x)=cos(x)^i
        result*=Adaptive(func,-pi/2,pi/2,false,10^(-10))[1]
    end
    return result
end
function Plot()
    Ds=Array([i for i=2:20])
    vs=similar(Ds,Float64)
    vs.=calculate.(Ds)
    plot(Ds,vs,xlabel="number of dimension",ylabel="volume",label="v-D")
    png(joinpath(@__DIR__,"Problem_3.png"))
end
Plot()