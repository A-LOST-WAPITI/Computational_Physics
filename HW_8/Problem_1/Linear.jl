include("./Ave.jl")

# this function is to get the coefficient of the line 
function Linear(x,y)
    x_ave=Average(x) # get the average of x
    y_ave=Average(y) # get the average of y
    n=length(x)
    # calculate b in the least square method
    b_up=0
    b_under=0
    for i=1:n
        b_up+=(x[i]-x_ave)*(y[i]-y_ave)
        b_under+=(x[i]-x_ave)^2
    end
    b=b_up/b_under
    a=y_ave-b*x_ave # calculate a in the least square method
    return b,a
end 
