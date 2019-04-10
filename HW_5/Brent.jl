function Change(x::Array{Float64},new::Float64)
    if new>x[2]
        x[1]=x[2]
        x[2]=new
    else
        x[3]=x[2]
        x[2]=new
    end
    sort(x)
end
function Step(x::Array{Float64},func::Function,h::Float64)
    q::Float64=func(x[1])/func(x[2])
    r::Float64=func(x[3])/func(x[2])
    s::Float64=func(x[3])/func(x[1])
    new::Float64=0
    upper::Float64=r*(r-q)*(x[3]-x[2])+(1-r)*s*(x[3]-x[1])
    lower::Float64=(q-1)*(r-1)*(s-1)
    new=x[3]-upper/lower
    new>h && (new=h;true)
    new<0 && (new=0;true)
    Change(x,new)
end
function Find(func::Function,h::Float64,tolerance::Float64,maxIndex::UInt32)
    x=Array{Float64}([tolerance,h/2,h-tolerance])
    count::UInt16=0
    while abs(x[3]-x[1])>=2tolerance && count<maxIndex && x[2]!=x[3] && x[1]!=x[2]
        Step(x,func,h)
    end
    (x[1]+x[3])/2
end