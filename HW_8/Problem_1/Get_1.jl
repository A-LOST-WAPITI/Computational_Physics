using Plots

include("./Linear.jl")

# this function is to get the plots of the fiting image 
function Get(sample_x,sample_y,num)
    l=Linear(sample_x,sample_y) # get the coefficient of the striaght line
    n=100
    x=LinRange(3,20,n)
    y=zeros(n)
    # calculate the theoretical value after fitting
    for i=1:n
        y[i]=l[1]*x[i]+l[2]
    end
    print("the coefficient is $l\n")
    # plot the scatter diagram
    Plots.scatter(sample_x,sample_y,label="Row Data $num")
    # plot the fitting image 
    p=Plots.plot!(x,y,label="Fitting Image of Data $num")
    return p
end
