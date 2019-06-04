@inbounds function Step(x::Array{Float64},index)
    index==length(x) && (return x[index]-x[index-1];true) || (return x[index+1]-x[index];true)
end
@inbounds function Thomas(u::Array{Float64},d::Array{Float64},l::Array{Float64},b::Array{Float64})
    c=similar(u)
    x=h=similar(d)

    for i=1:length(c)
        i==1 && (c[i]=u[i]/d[i];true) || (c[i]=u[i]/(d[i]-l[i-1]*c[i-1]);true)
    end
    for i=1:length(h)
        i==1 && (h[i]=b[i]/d[i];true) || (h[i]=(b[i]-l[i-1]*h[i-1])/(d[i]-l[i-1]*c[i-1]);true)
    end

    x[length(x)]=h[length(h)]
    for i=length(x)-1:1
        x[i]=h[i]-c[i]*x[i+1]
    end
    return x
end
@inbounds function FuncArray(x::Array{Float64},y::Array{Float64},m::Array{Float64})
    len=length(x)

    funcs=Array{Function}[]
    for i=1:len-1
        step=Step(x,i)

        a=y[i]
        b=(y[i+1]-y[i])/step-m[i]*step/2-(m[i+1]-m[i])*step/6
        c=m[i]/2
        d=(m[i+1]-m[i])/(6step)

        func(now)=a+b*(now-x[i])+c*(now-x[i])^2+d*(now-x[i])^3
        funcs=vcat(funcs,func)
    end
    return funcs
end
@inbounds function Cubic(x::Array{Float64},y::Array{Float64},clamped::Bool=true)
    len::UInt8=length(x)
    h=[x[i+1]-x[i] for i=1:len-1]
    
    d=[2*(h[i-1]+h[i]) for i=2:len-1]
    d=vcat(2h[1],d,2h[len-1])
    u=l=h
    if clamped
        d[1]=d[len]=1
        u[1]=l[len-1]=0
    end

    m=similar(x)
    b=zeros(Float64,len)
    for i=2:len-1
        b[i]=(y[i+1]-y[i])/Step(x,i)-(y[i]-y[i-1])/Step(x,i-1)
        b[i]*=6
    end

    m=Thomas(u,d,l,b)
    return FuncArray(x,y,m)
end
@inbounds function GetIndex(now::Float64,x::Array{Float64})
    for i=1:length(x)-1
        now>=x[i] && now<=x[i+1] && (return i;true)
    end
end
@inbounds function Produce(now::Float64,x::Array{Float64},funcs::Array{Function})
    index::UInt8=0

    index=GetIndex(now,x)

    return funcs[index](now)
end

#函数们的帮助文档们
@doc """
## 作用
使用追赶法（Thomas Method）来进行三对角矩阵方程的求解
## 参数
u→矩阵上层
d→矩阵中层
l→矩阵下层
b→常数向量
""" Thomas