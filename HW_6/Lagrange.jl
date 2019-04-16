function Basis(x::Float64,index::UInt8,X::Array{Float64})
    result::Float64=1
    for i in X
        i!=X[index] && (result*=(x-i)/(X[index]-i);true)
    end
    return result
end
function L(x::Float64,X::Array{Float64},Y::Array{Float64})
    temp=similar(X)
    for i::UInt8=1:length(X)
        temp[i]=Y[i]*Basis(x,i,X)
    end
    result=sum(temp)
    return result
end
function Plot(nodes::UInt8,func::Function)
    X::Array{Float64}=LinRange(-1,1,nodes)
    Y=similar(X)
    Y.=func.(X)

    x::Array{Float64}=LinRange(-1,1,10000)
    y_P=similar(x)
    y_N=similar(x)
    y_N.=func.(x)
    
    Threads.@threads for i=1:length(x)
        y_P[i]=L(x[i],X,Y)
    end

    y=[y_N,y_P]
    labels=["Raw Function","Nodes=$nodes"]
    colors=[:purple,:red]
    plot(x,y,label=labels,color=colors,ylims=(-2,2),yticks=-2:0.5:2)
end