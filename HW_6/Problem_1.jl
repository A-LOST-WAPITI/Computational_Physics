using Plots;gr()

include("Lagrange.jl")

function Liner(x::Float64,X::Array{Float64},Y::Array{Float64})
    here::UInt8=1

    for i=1:length(X)-1
        X[i]<x && X[i+1]>=x && (here=i;true)
    end

    y::Float64=Y[here+1]+(Y[here]-Y[here+1])*(x-X[here+1])/(X[here]-X[here+1])
    return y
end
function main()
    X::Array{Float64}=[-1,0,1.27,2.55,3.82,4.92,5.02]
    Y::Array{Float64}=[-14.58,0,0,0,0,0.88,11.17]

    x::Array{Float64}=LinRange(-1,5.02,10000)
    y_l=similar(x)
    y_p=similar(x)

    Threads.@threads for i=1:length(x)
        y_l[i]=Liner(x[i],X,Y)
        y_p[i]=L(x[i],X,Y)
    end

    y=[y_l,y_p]
    labels=["Piecewise interpolation","Lagrange interpolation"]
    plot(x,y,label=labels)
    png(joinpath(@__DIR__,"Problem_1.png"))
end

@time main()