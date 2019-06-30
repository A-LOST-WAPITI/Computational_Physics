using Plots;gr()
using CurveFit

include("RKs.jl")

function err(i)
    dfunc(x,y)=1-x+4y
    func(x)=(4exp(-4x)-3exp(-4x)+19)/(16exp(-4x))
    xs,ys=ralston(dfunc,0,1,10.0^(-i),1)
    plot(xs,ys,label="ralston's method")
    laws=func.(xs)
    plot!(xs,laws,label="accurate values")
    err1=abs.(laws-ys)./laws
    xs,ys=RK3(dfunc,0,1,10.0^(-i),1)
    plot!(xs,ys,label="RK3 method")
    err2=abs.(laws-ys)./laws
    xs,ys=RK4(dfunc,0,1,10.0^(-i),1)
    plot!(xs,ys,label="RK4 method")
    err3=abs.(laws-ys)./laws
    xs,ys=RK6(dfunc,0,1,10.0^(-i),1)
    plot!(xs,ys,label="RK6 method")
    err4=abs.(laws-ys)./laws
    png(joinpath(@__DIR__,"results/Problem_1_$i.png"))
    return sum(err1)/length(err1),sum(err2)/length(err2),sum(err3)/length(err3),sum(err4)/length(err4)
end
function main()
    errR=zeros(5)
    errRK3=zeros(5)
    errRK4=zeros(5)
    errRK6=zeros(5)
    for i=1:5
        errR[i],errRK3[i],errRK4[i],errRK6[i]=err(i)
    end
    steps=[10.0^(-i) for i=1:5]
    plot(steps,errR,label="euler method",xscale=:log10,yscale=:log10,xlabel="step",yticks=[10.0^(i/10) for i=-20:0],ylabel="relative error")
    plot!(steps,errRK3,label="RK3 method")
    plot!(steps,errRK4,label="RK4 method")
    plot!(steps,errRK6,label="RK6 method")
    print("The power of ralston's Method is ",power_fit(steps,errR)[2],"\n")
    print("The power of RK3 is ",power_fit(steps,errRK3)[2],"\n")
    print("The power of RK4 is ",power_fit(steps,errRK4)[2],"\n")
    print("The power of RK6 is ",power_fit(steps,errRK6)[2],"\n")
    png(joinpath(@__DIR__,"Problem_1.png"))
end
main()