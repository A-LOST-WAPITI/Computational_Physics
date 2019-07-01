---
html:
    embed_local_images: true
    offline: true
    toc: true
---  
  
#  计算物理第九次作业
  
>万国麟
>2017141221045
  
##  Problem 1
  
###  Code
  
```julia
using Plots;gr()
using LaTeXStrings
const N=100
const tolerance=10^(-8)
f(x)=x^4*exp(x)/(exp(x)-1)^2
function Simpson(func,lower,upper)
    int::Float64=0
    temp::Float64=0
    step::Float64=(upper-lower)/N
    for x in LinRange(lower+tolerance,upper,N)
        temp=step/6*(func(x)+4func(x+step/2)+func(x+step))
        int+=temp
    end
    return int
end
function main(T::Float64)
    θ::Float64=428
    ρ::Float64=6.022*10^28
    V::Float64=10e-3
    k::Float64=1.381*10^(-23)
    int::Float64=Simpson(f,0,θ/T)
    C::Float64=9*V*ρ*k*(T/θ)^3*int
    return C
end
function Plot()
    X=Array(LinRange(5,500,50))
    Y=similar(X)
    for i=1:length(X)
        Y[i]=main(X[i])
    end
    plot(X,Y,label=L"C_{v}")
    png(joinpath(@__DIR__,"Problem_1.png"))
end
Plot()
```  
###  运行结果
  
![Problem_1](Problem_1.png )
>Figure 1 <img src="https://latex.codecogs.com/gif.latex?C_{v}"/>图像
  
###  结果分析
  
使用Simphon积分法计算<img src="https://latex.codecogs.com/gif.latex?C_{v}"/>的函数值,其中`Simphon`函数为积分函数,`main`函数用于生成函数值,`Plot`函数用于绘图并保存.
在计算过程中,考虑到被积函数在<img src="https://latex.codecogs.com/gif.latex?0"/>处不解析,考虑采用罗必塔法则
<p align="center"><img src="https://latex.codecogs.com/gif.latex?&#x5C;lim&#x5C;limits_{x&#x5C;to0}&#x5C;frac{x^4e^{x}}{(e^x-1)^2}=0"/></p>  
  
所以可以在<img src="https://latex.codecogs.com/gif.latex?0"/>处右加一个小量`tolerance`来避免无解同时不会影响整个积分值.
最终结果的图像也可以证明确实并无太大影响.
##  Problem 2
  
###  Code
  
包含整个自适应Trapezoid与Simpson积分的代码如下
```julia
function Trapezoid(func,lower,upper)
    a=func(lower)
    b=func(upper)
    h=upper-lower
    temp=h*(a+b)/2
    return temp
end
function Simpson(func,lower,upper)
    mid=(lower+upper)/2
    h=upper-lower
    a=func(lower)
    b=func(mid)
    c=func(upper)
    temp=h*(a+4b+c)/6
    return temp
end
function Adaptive(func,lower,upper,trap,tolerance)
    trap && (now=Trapezoid(func,lower,upper);true) || (now=Simpson(func,lower,upper);true)
    count=1
    temp=0
    while true
        count*=2
        nodes=Array(LinRange(lower,upper,count+1))
        temp=0
        if trap
            for i=1:count
                temp+=Trapezoid(func,nodes[i],nodes[i+1])
            end
        else
            for i=1:count
                temp+=Simpson(func,nodes[i],nodes[i+1])
            end
        end
        if abs(temp-now)<tolerance
            break
        else
            now=temp
        end
    end
    return temp,count
end
```  
用于Problem 2求解过程的代码如下
```julia
include("Adaptive.jl")
  
f(x)=sin(10sqrt(x))^2
  
trap=Adaptive(f,0,1,true,10^(-10))
sim=Adaptive(f,0,1,false,10^(-10))
  
print("The result of trapzoid method is ",trap[1],", and the number of slices is ",trap[2],"\n")
print("The result of simpson method is ",sim[1],", and the number of slices is ",sim[2])
```  
###  运行结果
  
>The result of trapzoid method is 0.4558325322801436, and the number of slices is 524288
>The result of simpson method is 0.4558325323038125, and the number of slices is 2048
  
###  结果分析
  
自适应过程中,`trap`参数为确定是否采用Trapezoid方法的布尔变量.当其值为`True`时,采用Trapezoid方法计算,否则采用Simphon方法计算.每次递归均会对下一次计算的误差上限进行半衰来保证总误差始终在`eps`之内.`Adaptive`函数为调用每个方法的自适应算法来进行给定函数`func`在给定上下限`upper`,`lower`之间误差限制在`eps`之内的一个积分值以及进行区间划分的次数`count`.最终结果中,通过两种方法所得结果在给定误差允许范围<img src="https://latex.codecogs.com/gif.latex?10^{-10}"/>内数据稳定相同,但是在划分次数上却是天壤之别.
使用Trapezoid方法来进行计算所需的划分次数是Simphon方法的500倍(仅针对<img src="https://latex.codecogs.com/gif.latex?10^{-10}"/>精度而言,该比值会随着精度设置的不同而变化),通过分析两个方法计算积分值的过程,我们可知两种方法均是牛顿-寇次公式的特定类型.
对于Trapezoid方法而言,其计算方法为将两个端点之间的连接看成线性连接,所以其每段的计算公式为
<p align="center"><img src="https://latex.codecogs.com/gif.latex?Temp=&#x5C;frac{h}{2}(f(lower)+f(upper))"/></p>  
  
而Simphon算法将两个端点之间的连接看成是一个二次曲线,该二次曲线由两个端点以及区间中点来确定.经过计算最后的积分值可以近似表示为
<p align="center"><img src="https://latex.codecogs.com/gif.latex?Temp=&#x5C;frac{h}{6}(f(lower)+4f(&#x5C;frac{lower+upper}{2})+f(upper))"/></p>  
  
从图形来看可以明显看出,使用Simphon所拟合的曲线更接近原函数,所以也更能快速收敛到一个精确值
![compare](image/compare.png )
>Figure 2 Trapezoid和Simphon几何上的比较
>(其中绿线为所需函数)
  
##  Problem 3
  
###  Code
  
```julia
using CurveFit
using Plots;gr()
  
f(x)=1/(x^2+1)
  
include("./Adaptive.jl")
  
function Raw(func,lower,upper,k)
    h=upper-lower
    if k==1
        return h*(func(lower)+func(upper))/2
    else
        hk=h/(2^(k-1))
        h_k=h/(2^(k-2))
        temp=[func(lower+(2*j-1)*hk) for j=1:2^(k-2)]
        return (Raw(func,lower,upper,k-1)+h_k*sum(temp))/2
    end
end
function Re(i,j,rawList)
    if j==1
        func,lower,upper=rawList
        temp=Raw(func,lower,upper,i)
        return temp
    else
        re1=Re(i,j-1,rawList)
        re2=Re(i-1,j-1,rawList)
        temp=(4^(j-1)*re1-re2)/(4^(j-1)-1)
        return temp
    end
end
function Romberg(func,lower,upper,tolerance)
    count=0
    i=j=2
    rawList=[func,lower,upper]
    result=0
    while true
        temp1=Re(i,j,rawList)
        temp2=Re(i,j-1,rawList)
        temp3=Re(i-1,j-1,rawList)
        if abs(temp1-temp2)<tolerance && abs(temp1-temp3)<tolerance
            result=temp1
            count=2^i
            break
        end
        i+=1
        j+=1
    end
    return result,count
end
function main()
    errs=zeros(12,3)
    counts=zeros(12,3)
    law=π/4
    for i=1:12
        eps=10.0^(-i)
  
        errs[i,1],counts[i,1]=Adaptive(f,0,1,true,eps)
        errs[i,2],counts[i,2]=Adaptive(f,0,1,false,eps)
        errs[i,3],counts[i,3]=Romberg(f,0,1,eps)
    end
    errs.=abs.(errs.-law)
    hs=1.0./counts
    labels=["Trapezoid","Simpson","Romberg"]
    scatter(hs,errs,xlabel="Slice step",ylabel="Absolute error",xflip=true,xaxis=:log,yaxis=:log,label=labels)
    png(joinpath(@__DIR__,"Problem_3.png"))
    for i=1:3
        print(labels[i],"\n","  The power of slice step(h) is: ",round(power_fit(hs[:,i],errs[:,i])[2],digits=3),"\n")
    end
end
main()
```  
###  运行结果
  
运行结果如下
>Trapezoid
>  The power of slice step(h) is: 2.002
>Simpson
>  The power of slice step(h) is: 6.187
>Romberg
>  The power of slice step(h) is: 7.767
  
误差与分割步长的分布关系如下图
![误差与步长分布](Problem_3.png )
>Figure 3 误差与分割步长的分布
  
###  结果分析
  
其中`Raw`函数采用递归方式生成外推表中第一列函数值,用于在`Re`整个的递归过程中递推至第一列时的求值.`Romberg`函数是整个龙贝格积分的主要函数,可以得到给定函数`func`在`lower`到`upper`之间误差在`tolerance`之内的积分值,同时返回划分次数`count`.Trapezoid和Simpson在引入的`Adaptive.jl`文件中.
对于Trapzoid积分而言,如果每个积分区间的长度相等有
<p align="center"><img src="https://latex.codecogs.com/gif.latex?&#x5C;int_{a}^{b}%20f(x)%20d%20x%20&#x5C;approx%20&#x5C;frac{b-a}{N}&#x5C;left[&#x5C;frac{f(a)+f(b)}{2}+&#x5C;sum_{k=1}^{N-1}%20f&#x5C;left(a+k%20&#x5C;frac{b-a}{N}&#x5C;right)&#x5C;right]"/></p>  
  
可改写为
<p align="center"><img src="https://latex.codecogs.com/gif.latex?&#x5C;int_{a}^{b}%20f(x)%20d%20x%20&#x5C;approx%20&#x5C;frac{b-a}{2%20N}&#x5C;left(f&#x5C;left(x_{0}&#x5C;right)+2%20f&#x5C;left(x_{1}&#x5C;right)+2%20f&#x5C;left(x_{2}&#x5C;right)+&#x5C;cdots+2%20f&#x5C;left(x_{N-1}&#x5C;right)+f&#x5C;left(x_{N}&#x5C;right)&#x5C;right)"/></p>  
  
其中<img src="https://latex.codecogs.com/gif.latex?x_{k}=a+k%20&#x5C;frac{b-a}{N},%20k=0,1,%20&#x5C;ldots,%20N"/>,则其余项为
<p align="center"><img src="https://latex.codecogs.com/gif.latex?R_{n}(f)=-&#x5C;frac{b-a}{12}%20h^{2}%20f^{&#x5C;prime%20&#x5C;prime}(&#x5C;eta),%20&#x5C;eta%20&#x5C;in(a,%20b)"/></p>  
  
该理论推导值与实验结果相吻合
对于Simpson积分而言,其带误差项的计算公式为
<p align="center"><img src="https://latex.codecogs.com/gif.latex?&#x5C;int_{a}^{b}%20f(x)%20dx=&#x5C;frac{h}{3}[f(a)+f(b)+4&#x5C;sum_{i=1}^{m}f(x_{2i-1})+2&#x5C;sum_{i=1}^{m-1}f(x_{2i})]-&#x5C;sum_{i=0}^{m-1}&#x5C;frac{h^5}{90}f^{(4)}(c_{i})"/></p>  
  
而实验最后结果表示误差约正比于<img src="https://latex.codecogs.com/gif.latex?h^6"/>,或许是因为误差项过小而导致<img src="https://latex.codecogs.com/gif.latex?f^{(4)}(c_{i})"/>的正负相消使得最后的误差项阶数升高.
而对于Romberg积分而言,无法给出确定的误差关系.
  