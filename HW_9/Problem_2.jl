include("Adaptive.jl")

f(x)=sin(10sqrt(x))^2

trap=Adaptive(f,0,1,true,10^(-10))
sim=Adaptive(f,0,1,false,10^(-10))

print("The result of trapzoid method is ",trap[1],", and the number of slices is ",trap[2],"\n")
print("The result of simpson method is ",sim[1],", and the number of slices is ",sim[2])