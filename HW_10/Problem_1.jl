using Plots;gr()
#引入自适应辛普森积分
include("../HW_9/Adaptive.jl")
#定义使用自适应辛普森积分用于变自变量积分的函数
function Integrate(func,trans,dTrans,antiTrans,lower,upper)
    tolerance=10e-10    #定义误差下限
    lT=antiTrans(lower) #变换后积分下限
    uT=antiTrans(upper) #变换后积分上限
    funcT(x)=func(trans(x))*dTrans(x)   #变换后被积函数

    result=Adaptive(funcT,lT,uT,false,tolerance)[1] #积分过程
    return result
end

#Part a1
print("Part A\n")
func(x)=sqrt(1-x^2)
trans(x)=cos(x)
dTrans(x)=-sin(x)
antiTrans(x)=acos(x)
result=Integrate(func,trans,dTrans,antiTrans,-1,1)
print("The result of the raw integrate is ",result,"\n")
#Part a2
funcT(x)=sin(x)^2
result=Adaptive(funcT,0,pi,false,10^(-10))[1]
print("The result of integrate is ",result,"\n")

#Part b
function partB()
    print("Part B\n")
    ks=Array(LinRange(0,0.99,1000))
    results=zeros(1000)
    for i=1:length(ks)
        k=ks[i]
        θ=2asin(k)
        funcT(x)=1/sqrt(1-k^2*sin(x)^2)
        result=Adaptive(funcT,0,pi/2,false,10^(-10))[1]
        results[i]=result
    end
    plot(ks,results)
    png(joinpath(@__DIR__,"Problem_1_B.png"))
    print("The result has been saved in an image.\n")
end
partB()

#Part c(不使用预先推导进行计算)
function partC_raw()
    print("Part C (raw)\n")
    func(x)=1/((1+x)*sqrt(x))
    trans(x)=x^2
    dTrans(x)=2x
    antiTrans(x)=sqrt(x)
    temp=now=0
    count=1
    while true
        temp=Integrate(func,trans,dTrans,antiTrans,10^(-10),10^count)
        if abs(temp-now)<now/100
            break
        end
        now=temp
        count+=1
    end
    print("The result of the raw integrate is ",temp,"\n")
end
partC_raw()
#Part c(使用预先推导进行计算)
function partC_after()
    print("Part C (fixed)\n")
    temp=now=0
    count=1
    funcT(x)=2/(1+x^2)
    while true
        temp=Adaptive(funcT,0,10^count,false,10^(-10))[1]
        if abs(temp-now)<now/100
            break
        end
        now=temp
        count+=1
    end
    print("The result of the fixed integrate is ",temp,"\n")
end
partC_after()