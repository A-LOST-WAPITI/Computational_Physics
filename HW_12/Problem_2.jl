using Plots;gr()
using LaTeXStrings

function RK4(dfunc,r,t,step)
    k1=dfunc(t,r)
    k2=dfunc(t+step/2,r.+k1*step/2)
    k3=dfunc(t+step/2,r.+k2*step/2)
    k4=dfunc(t+step,r.+k3*step)
    rn=r.+(k1.+2k2.+2k3.+k4)/6*step
    return rn
end

function func(t,r)
    g,L=9.81,0.1
    theta,omega=r
    fTheta=omega
    fOmega=-g/L*theta
    return [fTheta,fOmega]
end

function run(rawDeg,rawOmega)
    step=10^(-2)
    t=Array(range(0,1,step=step))
    r=[deg2rad(rawDeg),rawOmega]
    thetaPoints=[]
    omegaPoints=[]
    for time in t
        thetaPoints=vcat(thetaPoints,r[1])
        omegaPoints=vcat(omegaPoints,r[2])
        r=RK4(func,r,time,step)
    end
    plot(t,thetaPoints,label=L"\theta-t",xlabel="t",ylabel=L"\theta or \omega")
    plot!(t,omegaPoints,label=L"\omega-t")
    png(joinpath(@__DIR__,"Problem_2_$rawDeg.png"))
end
function main()
    run(10,0)
    run(179,0)
end
main()