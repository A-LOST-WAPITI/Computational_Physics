using CurveFit
using Plots;gr()

f(x)=1/(x^2+1)

include("./Adaptive.jl")

function Raw(func,lower,upper,k)
    h=upper-lower
    if k==1
        return h*(func(lower)+func(upper))/2
    else
        hk=h/(2^(k-1))
        h_k=h/(2^(k-2))
        temp=[func(lower+(2*j-1)*hk) for j=1:2^(k-2)]
        return (Raw(func,lower,upper,k-1)+h_k*sum(temp))/2
    end
end
function Re(i,j,rawList)
    if j==1
        func,lower,upper=rawList
        temp=Raw(func,lower,upper,i)
        return temp
    else
        re1=Re(i,j-1,rawList)
        re2=Re(i-1,j-1,rawList)
        temp=(4^(j-1)*re1-re2)/(4^(j-1)-1)
        return temp
    end
end
function Romberg(func,lower,upper,tolerance)
    count=0
    i=j=2
    rawList=[func,lower,upper]
    result=0
    while true
        temp1=Re(i,j,rawList)
        temp2=Re(i,j-1,rawList)
        temp3=Re(i-1,j-1,rawList)
        if abs(temp1-temp2)<tolerance && abs(temp1-temp3)<tolerance
            result=temp1
            count=2^i
            break
        end
        i+=1
        j+=1
    end
    return result,count
end
function main()
    errs=zeros(12,3)
    counts=zeros(12,3)
    law=π/4
    for i=1:12
        eps=10.0^(-i)
        
        errs[i,1],counts[i,1]=Adaptive(f,0,1,true,eps)
        errs[i,2],counts[i,2]=Adaptive(f,0,1,false,eps)
        errs[i,3],counts[i,3]=Romberg(f,0,1,eps)
    end
    errs.=abs.(errs.-law)
    hs=1.0./counts
    labels=["Trapezoid","Simpson","Romberg"]
    scatter(hs,errs,xlabel="Slice step",ylabel="Absolute error",xflip=true,xaxis=:log,yaxis=:log,label=labels)
    png(joinpath(@__DIR__,"Problem_3.png"))
    for i=1:3
        print(labels[i],"\n","  The power of slice step(h) is: ",round(power_fit(hs[:,i],errs[:,i])[2],digits=3),"\n")
    end
end
main()