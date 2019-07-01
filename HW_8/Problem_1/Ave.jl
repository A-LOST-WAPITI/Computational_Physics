# this function is to calculate the average value
function Average(x)
    n=length(x)
    sum=0
    for i=1:n
        sum+=x[i]
    end
    result=sum/n
    return result
end 
