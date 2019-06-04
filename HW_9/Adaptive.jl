function Trapezoid(func,lower,upper)
    h=upper-lower
    temp=h*(func(lower)+func(upper))/2
    return temp
end
function Simpson(func,lower,upper)
    mid=(upper+lower)/2
    temp=(upper-lower)*(func(lower)+4func(mid)+func(upper))/6
    return temp
end
function Re(func,lower,upper,eps,now,Trap)
    global count,epsRaw
    mid=(upper+lower)/2
    Trap && (tempL=Trapezoid(func,lower,mid);true) || (tempL=Simpson(func,lower,mid);true)
    Trap && (tempR=Trapezoid(func,mid,upper);true) || (tempR=Simpson(func,mid,upper);true)
    epsN=eps/2
    abs(tempL+tempR-now)<eps && (count==0 && (count=UInt(epsRaw/eps);true);return now;true) || (return Re(func,lower,mid,epsN,tempL,Trap)+Re(func,mid,upper,epsN,tempR,Trap);true)
end
function Adaptive(func,lower,upper,eps,Trap)
    Trap && (raw=Trapezoid(func,lower,upper);true) || (raw=Simpson(func,lower,upper);true)
    result=Re(func,lower,upper,eps,raw,Trap)
    return result
end