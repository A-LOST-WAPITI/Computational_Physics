using Plots

function P(x::Float32)
    par::Array{Int32}=[924,-2772,3150,-1680,420,-42,1]
    X::Array{Float32}=[x^(i) for i=6:-1:0]
    result::Float32=sum(X.*par)
    return result
end
function main()
    x=Array{Float32}(LinRange(0,1,10000))
    y=similar(x)

    y.=P.(x)

    gr()
    plot(x,y,label="Polynomial",xticks=0:0.1:1)
    png(joinpath(@__DIR__,"result.png"))
end

@time main()