using Plots;gr()
using LaTeXStrings

function forward(now,h,τ)
    return (1-h/τ)*now
end
function partA()
    ts=range(0,15,step=1)
    n=length(ts)
    Ns=zeros(n)
    Ns[1]=1
    for i=2:n
        Ns[i]=forward(Ns[i-1],1,2)
    end
    plot(ts,Ns,label="h=1s",xlabel="t",ylabel="N")

    ts=range(0,15,step=0.1)
    n=length(ts)
    Ns=zeros(n)
    Ns[1]=1
    for i=2:n
        Ns[i]=forward(Ns[i-1],0.1,2)
    end
    plot!(ts,Ns,label="h=0.1s",xlabel="t",ylabel="N")

    ts=range(0,15,step=0.01)
    n=length(ts)
    Ns=zeros(n)
    Ns[1]=1
    for i=2:n
        Ns[i]=forward(Ns[i-1],0.01,2)
    end
    plot!(ts,Ns,label="h=0.01s",xlabel="t",ylabel="N")
    
    png(joinpath(@__DIR__,"Problem_3_partA.png"))
end
function partB()
    ts=range(0,15,step=0.01)
    n=length(ts)
    Ns=zeros(n)
    Ns[1]=1
    for i=2:n
        Ns[i]=forward(Ns[i-1],0.01,5)
    end
    plot(ts,Ns,label=L"\tau=5s",xlabel="t",ylabel="N")

    ts=range(0,15,step=0.01)
    n=length(ts)
    Ns=zeros(n)
    Ns[1]=1
    for i=2:n
        Ns[i]=forward(Ns[i-1],0.01,3)
    end
    plot!(ts,Ns,label=L"\tau=3s",xlabel="t",ylabel="N")

    ts=range(0,15,step=0.01)
    n=length(ts)
    Ns=zeros(n)
    Ns[1]=1
    for i=2:n
        Ns[i]=forward(Ns[i-1],0.01,1)
    end
    plot!(ts,Ns,label=L"\tau=1s",xlabel="t",ylabel="N")

    ts=range(0,15,step=0.01)
    n=length(ts)
    Ns=zeros(n)
    Ns[1]=1
    for i=2:n
        Ns[i]=forward(Ns[i-1],0.01,0.1)
    end
    plot!(ts,Ns,label=L"\tau=0.1s",xlabel="t",ylabel="N")

    ts=range(0,15,step=0.01)
    n=length(ts)
    Ns=zeros(n)
    Ns[1]=1
    for i=2:n
        Ns[i]=forward(Ns[i-1],0.01,0.01)
    end
    plot!(ts,Ns,label=L"\tau=0.01s",xlabel="t",ylabel="N")
    
    png(joinpath(@__DIR__,"Problem_3_partB.png"))
end
function forwardD(now,nowP,h,τ,τP)
    return (1-h/τ)*now+h/τP*nowP
end
function partC()
    ts=range(0,15,step=0.01)
    n=length(ts)
    NP=zeros(n)
    ND=similar(NP)
    NP[1]=1
    ND[1]=0
    for i=2:n
        NP[i]=forward(NP[i-1],0.01,2)
        ND[i]=forwardD(ND[i-1],NP[i-1],0.01,0.02,2)
    end
    plot(ts,ND,label=L"\tau_{D}=0.02s",xlabel="t",ylabel="N")

    ts=range(0,15,step=0.01)
    n=length(ts)
    NP=zeros(n)
    ND=similar(NP)
    NP[1]=1
    ND[1]=0
    for i=2:n
        NP[i]=forward(NP[i-1],0.01,2)
        ND[i]=forwardD(ND[i-1],NP[i-1],0.01,2,2)
    end
    plot!(ts,ND,label=L"\tau_{D}=2s",xlabel="t",ylabel="N")

    ts=range(0,15,step=0.01)
    n=length(ts)
    NP=zeros(n)
    ND=similar(NP)
    NP[1]=1
    ND[1]=0
    for i=2:n
        NP[i]=forward(NP[i-1],0.01,2)
        ND[i]=forwardD(ND[i-1],NP[i-1],0.01,200,2)
    end
    plot!(ts,ND,label=L"\tau_{D}=200s",xlabel=L"t(\tau_{P}=2s)",ylabel="N",yticks=LinRange(0,1,5))
    
    png(joinpath(@__DIR__,"Problem_3_partC.png"))
end

partA()
partB()
partC()