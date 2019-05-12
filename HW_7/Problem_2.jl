using Plots;gr()

include("Cubic.jl")

f(x)=x*sin(2pi*x+1)
function main(nodes)
    X::Array{Float64}=LinRange(-1,1,nodes)
    Y::Array{Float64}=f.(X)
    clamped::Bool=false

    funcs::Array{Function}=Cubic(X,Y,clamped)
    #println("$funcs")

    x::Array{Float64}=LinRange(-1,1,1000)
    y_p=similar(x)
    y_t=f.(x)

    Threads.@threads for i=1:length(x)
        y_p[i]=Produce(x[i],X,funcs)
    end

    y=[y_p,y_t]
    labels=["Cubic(nodes=$nodes)","real"]
    plot(x,y,label=labels)
end

anim=@animate for nodes=9:21
    main(nodes)
end
gif(anim,joinpath(@__DIR__,"Problem_2.gif"),fps=1)