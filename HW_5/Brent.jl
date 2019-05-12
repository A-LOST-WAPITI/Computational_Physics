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
function Step(x::Array{Float64},func::Function,h::Float64,start::Float64=0.0)
    q::Float64=func(x[1])/func(x[2])
    r::Float64=func(x[3])/func(x[2])
    s::Float64=func(x[3])/func(x[1])
    new::Float64=0
    upper::Float64=r*(r-q)*(x[3]-x[2])+(1-r)*s*(x[3]-x[1])
    lower::Float64=(q-1)*(r-1)*(s-1)
    new=x[3]-upper/lower
    while new>start+h || new<start
        new>start+h && (new=(new+start)/2;true)
        new<start && (new=(new+start+h)/2;true)
    end
    Change(x,new)
end
function Find(func::Function,h::Float64,tolerance::Float64,maxIndex::UInt32,start::Float64=0.0)
    x=Array{Float64}([start+tolerance,start+h/2,start+h-tolerance])
    count::UInt16=0
    while abs(x[3]-x[1])>=2tolerance && x[2]!=x[3] && x[1]!=x[2]
        if count==maxIndex
            return NaN
        end
        Step(x,func,h,start)
        count+=1
    end
    (x[1]+x[3])/2
end