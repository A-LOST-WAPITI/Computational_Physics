include("./Linear.jl")

# this function is to do a chi-square test
function Test(sample_x,sample_y)
    dof=length(sample_x)
    χ=0
    l=Linear(sample_x,sample_y)
    for i=1:dof
        χ+=((sample_y[i]-l[1]*sample_x[i]-l[2])^2)/(l[1]*sample_x[i]+l[2])
    end
    return χ
end 
