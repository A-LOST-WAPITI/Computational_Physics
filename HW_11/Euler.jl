function euler(dfunc,start,funcStart,step,stop)
    xs=range(start,stop=stop,step=step)
    ys=similar(xs)
    ys[1]=funcStart
    for i=2:length(xs)
        ys[i]=ys[i-1]+step*dfunc(xs[i-1],ys[i-1])
    end
    return xs,ys
end
function eulerImproved(dfunc,start,funcStart,step,stop)
    xs=range(start,stop=stop,step=step)
    ys=similar(xs)
    ys[1]=funcStart
    for i=2:length(xs)
        ySub=ys[i-1]+step*dfunc(xs[i-1],ys[i-1])
        yHat=ys[i-1]+step*dfunc(xs[i],ySub)
        ys[i]=(yHat+ySub)/2
    end
    return xs,ys
end