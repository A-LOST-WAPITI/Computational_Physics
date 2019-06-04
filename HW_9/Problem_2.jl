f(x)=sin(sqrt(100x))^2

include("./Adaptive.jl")

function main(eps)
    global epsRaw=eps
    global count=0
    print("Trapezoid: ",Adaptive(f,0,1,eps,true),"\n")
    print("Slice count: ",count,"\n")
    count=0
    print("Simpson:   ",Adaptive(f,0,1,eps,false),"\n")
    print("Slice count: ",count,"\n")
end
main(10e-10)