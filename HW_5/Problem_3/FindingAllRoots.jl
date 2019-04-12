include("FindingRoots.jl")

function GetStarts(func::Function)
    gap::Float64=0.01
    starts=zeros(Float64,6)
    flag::Int8=sign(func(0.0))
    here::Float64=0.0
    count::UInt8=1
    while count<=6
        temp::Float64=func(here+gap)
        flag!=sign(temp) && (starts[count]=here;true) && (flag=sign(temp);true) && (count+=1;true)
        here+=gap
    end
    return starts
end

main(GetStarts(P))