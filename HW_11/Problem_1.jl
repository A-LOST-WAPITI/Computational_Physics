using Plots

include("Euler.jl")

function err(i)
    dfunc(x,y)=1-x+4y
    func(x)=(4exp(-4x)-3exp(-4x)+19)/(16exp(-4x))
    xs,ys=euler(dfunc,0,1,10.0^(-i),1)
    plot(xs,ys,label="euler method")
    laws=func.(xs)
    plot!(xs,laws,label="accurate values")
    err1=abs.(laws-ys)./laws
    xs,ys=eulerImproved(dfunc,0,1,10.0^(-i),1)
    plot!(xs,ys,label="improved euler method")
    err2=abs.(laws-ys)./laws
    png(joinpath(@__DIR__,"results/Problem_1_$i.png"))
    return sum(err1)/length(err1),sum(err2)/length(err2)
end
function main()
    errE=zeros(5)
    errEI=zeros(5)
    for i=1:5
        errE[i],errEI[i]=err(i)
    end
    errE=round.(errE,digits=5)
    errEI=round.(errEI,digits=5)
    plot([10.0^(-i) for i=1:5],errE,label="euler method",xscale=:log10,yscale=:log10,xlabel="step",yticks=[10.0^(i/10) for i=-20:0],ylabel="relative error")
    plot!([10.0^(-i) for i=1:5],errEI,label="improved euler method")
    png(joinpath(@__DIR__,"Problem_1.png"))
end
main()