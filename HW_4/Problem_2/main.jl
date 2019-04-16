using Debugger

f(x::Float32)=4cos(x)-exp(x)
df(x::Float32)=-4sin(x)-exp(x)
function Limit(index::UInt32)
    lower::Float32=0
    upper::Float32=0
    index%2==0 && (lower=pi*(-1/2-(index-2));true) || (lower=pi*(-(index-1));true)
    index%2==0 && (upper=pi*(-(index-2));true) || (upper=pi*(1/2-(index-1));true)
    return lower,upper
end
function NB(lower::Float32,upper::Float32,maxIndex::UInt16,tolerance::Float32)
    count::UInt16=0
    now::Float32=(lower+upper)/2
    while count<maxIndex && abs(f(now))>tolerance
        while now<lower || now>upper
            now<lower && (now=(now+upper)/2;true)
            now>upper && (now=(now+lower)/2;true)
        end
        now=now-f(now)/df(now)
        count+=1
    end
    return now
end
function main()
    x=Array{UInt32}([i for i=1:100])
    lowers=similar(x,Float32)
    uppers=similar(x,Float32)
    results=similar(x,Float32)
    tolerance::Float32=10^(-8)
    maxIndex::UInt16=50

    Threads.@threads for i=1:length(x)
        index::UInt32=i
        (lowers[index],uppers[index])=Limit(index)
    end
    show(lowers)
    show(uppers)

    results.=NB.(lowers,uppers,maxIndex,tolerance)
end

f.(main())