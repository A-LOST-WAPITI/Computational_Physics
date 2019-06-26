function Trapezoid(func,lower,upper)
    a=func(lower)
    b=func(upper)
    h=upper-lower
    temp=h*(a+b)/2
    return temp
end
function Simpson(func,lower,upper)
    mid=(lower+upper)/2
    h=upper-lower
    a=func(lower)
    b=func(mid)
    c=func(upper)
    temp=h*(a+4b+c)/6
    return temp
end
function Adaptive(func,lower,upper,trap,tolerance)
    trap && (now=Trapezoid(func,lower,upper);true) || (now=Simpson(func,lower,upper);true)
    count=1
    temp=0
    while true
        count*=2
        nodes=Array(LinRange(lower,upper,count+1))
        temp=0
        if trap
            for i=1:count
                temp+=Trapezoid(func,nodes[i],nodes[i+1])
            end
        else
            for i=1:count
                temp+=Simpson(func,nodes[i],nodes[i+1])
            end
        end
        if abs(temp-now)<tolerance
            break
        else
            now=temp
        end
    end
    return temp,count
end