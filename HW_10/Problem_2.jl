include("../HW_9/Adaptive.jl")  #引入自适应辛普森积分

f(x)=exp(-x^2)  #定义被积函数

function Gaussian()
    temp=now=0
    count=1
    while true
        temp=Adaptive(f,0,10^count,false,10^(-10))[1]
        if abs(temp-now)<now/10^2
            break
        end
        now=temp
        count+=1
    end
    result=2temp
    print("The approximate result of the integration is ",result,"\n")
    print("The related error of this result is ",abs(result-sqrt(pi))/sqrt(pi))
end
Gaussian()