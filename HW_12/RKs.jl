function ralston(dfunc,start,funcStart,step,stop)
    xs=range(start,stop=stop,step=step)
    ys=similar(xs)
    ys[1]=funcStart
    for i=2:length(xs)
        k1=dfunc(xs[i-1],ys[i-1])
        k2=dfunc(xs[i-1]+3/4*step,ys[i-1]+3/4*k1*step)
        ys[i]=ys[i-1]+(k1/3+2k2/3)step
    end
    return xs,ys
end
function RK3(dfunc,start,funcStart,step,stop)
    xs=range(start,stop=stop,step=step)
    ys=similar(xs)
    ys[1]=funcStart
    for i=2:length(xs)
        k1=dfunc(xs[i-1],ys[i-1])
        k2=dfunc(xs[i-1]+step/2,ys[i-1]+k1*step/2)
        k3=dfunc(xs[i-1]+step,ys[i-1]-step*k1+2step*k2)
        ys[i]=ys[i-1]+(k1+4k2+k3)/6*step
    end
    return xs,ys
end
function RK4(dfunc,start,funcStart,step,stop)
    xs=range(start,stop=stop,step=step)
    ys=similar(xs)
    ys[1]=funcStart
    for i=2:length(xs)
        k1=dfunc(xs[i-1],ys[i-1])
        k2=dfunc(xs[i-1]+step/2,ys[i-1]+k1*step/2)
        k3=dfunc(xs[i-1]+step/2,ys[i-1]+k2*step/2)
        k4=dfunc(xs[i-1]+step,ys[i-1]+k3*step)
        ys[i]=ys[i-1]+(k1+2k2+2k3+k4)/6*step
    end
    return xs,ys
end
function RK6(dfunc,start,funcStart,step,stop)
    xs=range(start,stop=stop,step=step)
    ys=similar(xs)
    ys[1]=funcStart
    for i=2:length(xs)
        k1=dfunc(xs[i-1],ys[i-1])
        k2=dfunc(xs[i-1]+step,ys[i-1]+step*k1)
        k3=dfunc(xs[i-1]+step/2,ys[i-1]+(3k1+k2)*step/8)
        k4=dfunc(xs[i-1]+2step/3,ys[i-1]+(8k1+2k2+8k3)*step/27)
        k5=dfunc(xs[i-1]+(7-sqrt(21))*step/14,ys[i-1]+(3(3sqrt(21)-7)k1-8(7-sqrt(21))k2+48(7-sqrt(21))k3-3(21-sqrt(21))k4)*step/329)
        k6=dfunc(xs[i-1]+(7+sqrt(21))*step/14,ys[i-1]+(-5(231+51sqrt(21))k1-40(7+sqrt(21))k2-320sqrt(21)k3+3(21+121sqrt(21))k4+392(6+sqrt(21))k5)*step/1960)
        k7=dfunc(xs[i-1]+step,ys[i-1]+(15(22+7sqrt(21))k1+120k2+40(7sqrt(21)-5)k3-63(3sqrt(21)-2)k4-14(49+9sqrt(21))k5+70(7-sqrt(21))k6)*step/180)
        ys[i]=ys[i-1]+(9k1+64k3+49k5+49k6+9k7)/180*step
    end
    return xs,ys
end