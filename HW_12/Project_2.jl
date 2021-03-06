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
function setRun(A,B,b,ω,stop,step=10^(-2))
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
    A=1;B=7;b=6;ω=1;stop=50pi
    ts,xs,vs=setRun(A,B,b,ω,stop)
    plot(xs,vs,label="v-x",xlabel="x",ylabel="v")
    png(joinpath(@__DIR__,"Project/partA.png"))

    #For partB
    for (B,b) in [(7,6),(7,0.6),(10,0.05),(7,0.01)]
        ts,xs,vs=setRun(A,B,b,ω,stop)
        plot(ts,xs,label="position",xlabel="t",ylabel="x")
        png(joinpath(@__DIR__,"Project/partB/position_$B&$b.png"))
        plot(xs,vs,label="v-x",xlabel="x",ylabel="v")
        png(joinpath(@__DIR__,"Project/partB/phase_$B&$b.png"))
    end

    #For partC
    N=1000
    b=0.01;step=pi/180;stop=360*step*N
    ts,xs,vs=setRun(A,B,b,ω,stop,step)
    if mod(length(vs),2)!=0
        pop!.([vs,xs])
    end
    vs,xs=reshape.([vs,xs],360,:)
    anim=@animate for off=1:360
        V=vs[off,:]
        X=xs[off,:]
        scatter(X,V,xlims=[-4,4],ylims=[-6,6],xlabel="x",ylabel="v",legend=false,title="phase offset: $off °",markersize=0.8,color=:black)
    end
    gif(anim,joinpath(@__DIR__,"Project/partC.gif"),fps=10)
end
main()