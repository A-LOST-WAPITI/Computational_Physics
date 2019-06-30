using Plots;gr()

function RK4(dfunc,r,t,step)
    k1=dfunc(t,r)
    k2=dfunc(t+step/2,r.+k1*step/2)
    k3=dfunc(t+step/2,r.+k2*step/2)
    k4=dfunc(t+step,r.+k3*step)
    rn=r.+(k1.+2k2.+2k3.+k4)/6*step
    return rn
end
function run(func,r,t,step)
    xPoints=[]
    vPoints=[]
    for time in t
        xPoints=vcat(xPoints,r[1])
        vPoints=vcat(vPoints,r[2])
        r=RK4(func,r,time,step)
    end
    return xPoints,vPoints
end
function setRun(A,B,b,ω,stop)
    step=10^(-2)
    function func(t,r)
        x,v=r
        fX=v
        fV=B*cos(ω*t)-A*x^3-b*v
        return [fX,fV]
    end
    r=[3,0]
    ts=Array(range(0,stop,step=step))
    xs,vs=run(func,r,ts,step)
    return ts,xs,vs
end
function main()
    #For partA
    A=1;B=7;b=6;ω=1;stop=100
    ts,xs,vs=setRun(A,B,b,ω,stop)
    plot(vs,xs,label="x-v",xlabel="v",ylabel="x")
    png(joinpath(@__DIR__,"Project/partA.png"))

    #For partB
    for (B,b) in [(7,6),(7,0.6),(10,0.05),(7,0.01)]
        ts,xs,vs=setRun(A,B,b,ω,stop)
        plot(ts,xs,label="position",xlabel="t",ylabel="x")
        png(joinpath(@__DIR__,"Project/partB/position_$B&$b.png"))
        plot(vs,xs,label="x-v",xlabel="v",ylabel="x")
        png(joinpath(@__DIR__,"Project/partB/phase_$B&$b.png"))
    end
end
main()