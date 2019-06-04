using Plots;gr()
using LaTeXStrings
const N=100
const tolerance=10^(-8)
f(x)=x^4*exp(x)/(exp(x)-1)^2
function Simpson(func,lower,upper)
    int::Float64=0
    temp::Float64=0
    step::Float64=(upper-lower)/N
    for x in LinRange(lower+tolerance,upper,N)
        temp=step/6*(func(x)+4func(x+step/2)+func(x+step))
        int+=temp
    end
    return int
end
function main(T::Float64)
    θ::Float64=428
    ρ::Float64=6.022*10^28
    V::Float64=10e-3
    k::Float64=1.381*10^(-23)
    int::Float64=Simpson(f,0,θ/T)
    C::Float64=9*V*ρ*k*(T/θ)^3*int
    return C
end
function Plot()
    X=Array(LinRange(5,500,50))
    Y=similar(X)
    for i=1:length(X)
        Y[i]=main(X[i])
    end
    plot(X,Y,label=L"C_{v}")
    png(joinpath(@__DIR__,"Problem_1.png"))
end
Plot()