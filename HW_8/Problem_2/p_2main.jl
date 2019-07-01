using Plots

include("./Ave.jl")
include("./Linear.jl")
include("./Get.jl")
include("./Test.jl")

function main()
    sample_t=LinRange(0,165,12)
    N=[106,80,98,75,74,73,49,38,37,22,20,19]
    sample_y=log.(N) # calculate the nature log of N 

    l=Linear(sample_t,sample_y) # get the coefficients of the line 
    D=l[1]
    C=l[2]
    τ=-1/D
    A=exp(C)
    print("τ=$τ\n")
    print("A=$A\n")

    n=100
    t=LinRange(0,170,n)
    y=Get(sample_t,sample_y,n) # get the theretical values
    title="Decay of a radioactive substance"
    Plots.scatter(sample_t,sample_y,label="Row data") # plot the row datas
    Plots.plot!(t,y,label="fitting image",title=title) # plot the fitting image
    png(joinpath(@__DIR__,"p_2.png"))
end

main()