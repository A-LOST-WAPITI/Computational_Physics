---
html:
    embed_local_images: true
    offline: true
    toc: true
---  
  
# 计算物理第五次作业
  
  
> 万国麟
> 2017141221045
  
  
  
  
  
- [计算物理第五次作业](#%E8%AE%A1%E7%AE%97%E7%89%A9%E7%90%86%E7%AC%AC%E4%BA%94%E6%AC%A1%E4%BD%9C%E4%B8%9A )
	- [Brent Method](#brent-method )
		- [Code](#code )
		- [作用分析](#%E4%BD%9C%E7%94%A8%E5%88%86%E6%9E%90 )
	- [Problem 1](#problem-1 )
		- [Code](#code-1 )
		- [结果及分析](#%E7%BB%93%E6%9E%9C%E5%8F%8A%E5%88%86%E6%9E%90 )
	- [Problem 2](#problem-2 )
		- [Code](#code-2 )
		- [结果及分析](#%E7%BB%93%E6%9E%9C%E5%8F%8A%E5%88%86%E6%9E%90-1 )
	- [Problem 3](#problem-3 )
		- [Part A](#part-a )
			- [Code](#code-3 )
			- [结果及分析](#%E7%BB%93%E6%9E%9C%E5%8F%8A%E5%88%86%E6%9E%90-2 )
		- [Part B](#part-b )
			- [Code](#code-4 )
			- [结果及分析](#%E7%BB%93%E6%9E%9C%E5%8F%8A%E5%88%86%E6%9E%90-3 )
		- [Part C](#part-c )
			- [Code](#code-5 )
			- [结果及分析](#%E7%BB%93%E6%9E%9C%E5%8F%8A%E5%88%86%E6%9E%90-4 )
  
  
  
  
## Brent Method
  
### Code
  
代码如下
```julia
function Change(x::Array{Float64},new::Float64)
    if new>x[2]
        x[1]=x[2]
        x[2]=new
    else
        x[3]=x[2]
        x[2]=new
    end
    sort(x)
end
function Step(x::Array{Float64},func::Function,h::Float64,start::Float64=0.0)
    q::Float64=func(x[1])/func(x[2])
    r::Float64=func(x[3])/func(x[2])
    s::Float64=func(x[3])/func(x[1])
    new::Float64=0
    upper::Float64=r*(r-q)*(x[3]-x[2])+(1-r)*s*(x[3]-x[1])
    lower::Float64=(q-1)*(r-1)*(s-1)
    new=x[3]-upper/lower
    new>start+h && (new=start+h;true)
    new<start && (new=start;true)
    Change(x,new)
end
function Find(func::Function,h::Float64,tolerance::Float64,maxIndex::UInt32,start::Float64=0.0)
    x=Array{Float64}([start+tolerance,start+h/2,start+h-tolerance])
    count::UInt16=0
    while abs(x[3]-x[1])>=2tolerance && count<maxIndex && x[2]!=x[3] && x[1]!=x[2]
        Step(x,func,h,start)
    end
    (x[1]+x[3])/2
end
```  
### 作用分析
  
`Find`函数为整个文件的主体，可以用于制定函数、指定求解宽度、指定误差范围、指定求解起点的求解过程。其求解过程调用`Step`函数来使用”IQI“方法来进行迭代，同时调用`Change`函数来进行求解端点的迭代（采用迭代距离最远点的方法），使用该种方法可以保证迭代所用函数零点的确定性与唯一性，同时使用二次函数迭代也加速了收敛速度。
## Problem 1
  
### Code
  
代码如下
```julia
include("Brent.jl")
  
function main()
    h::Float64=0.5
    tolerance::Float64=10^(-8)
    maxIndex::UInt32=500
  
    f(x::Float64)=x*tan(x)-sqrt(h^2-x^2)
  
    Find(f,h,tolerance,maxIndex)
end
  
@time main()
```  
### 结果及分析
  
程序运行结果如下（其中计时部分已经多次计时刨除编译所需时间）
```
  0.065786 seconds (180.31 k allocations: 9.475 MiB, 6.62% gc time)
0.45018361129449697
```
该结果是<img src="https://latex.codecogs.com/gif.latex?f(x)=x%20&#x5C;tan%20x-&#x5C;sqrt{h^{2}-x^{2}}"/>在<img src="https://latex.codecogs.com/gif.latex?x&gt;0"/>条件下的零点，分析函数具体性质我们易知该函数为**偶函数**，所以**另一零点为所得零点的相反数**，所以最终求解结果为
<p align="center"><img src="https://latex.codecogs.com/gif.latex?x_{0}=&#x5C;pm0.45018361129449697"/></p>  
  
## Problem 2
  
### Code
  
代码如下
```julia
include("Brent.jl")
  
function BalanceFunc(r::Float64)
    G::Float64=6.674e-11
    M::Float64=5.974e24
    m::Float64=7.348e22
    R::Float64=3.844e8
    ω::Float64=2.662e-6
  
    result::Float64=G*M/r^2-G*m/(R-r)^2-ω^2*r
    return result
end
  
function main()
    h::Float64=3.844e8
    tolerance::Float64=10^2
    maxIndex::UInt32=500
  
    Find(BalanceFunc,h,tolerance,maxIndex)
end
  
@time main()
```  
### 结果及分析
  
程序运行结果如下（其中计时部分已经多次计时刨除编译所需时间）
```
  0.074799 seconds (262.04 k allocations: 14.062 MiB)
3.2604507159502846e8
```
此处`tolerance`的值较大是因为对于天文学问题本身，以及所给数值有效位数的原因，将此值设置较低无任何意义，在影响收敛速度的同时也会影响求解的最终结果，容易得到无意义收敛点。
最终所得拉格朗日点对应的半径为
<p align="center"><img src="https://latex.codecogs.com/gif.latex?r=3.260&#x5C;times10^{8}m"/></p>  
  
## Problem 3
  
### Part A
  
#### Code
  
代码如下
```julia
using Plots
  
function P(x::Float32)
    par::Array{Int32}=[924,-2772,3150,-1680,420,-42,1]
    X::Array{Float32}=[x^(i) for i=6:-1:0]
    result::Float32=sum(X.*par)
    return result
end
function main()
    x=Array{Float32}(LinRange(0,1,10000))
    y=similar(x)
  
    y.=P.(x)
  
    gr()
    plot(x,y,label="Polynomial",xticks=0:0.1:1)
    png(joinpath(@__DIR__,"result.png"))
end
  
@time main()
```  
#### 结果及分析
  
程序所需时间为（已经多次计时刨除编译所需时间）
```
  0.473440 seconds (681.08 k allocations: 35.811 MiB, 2.55% gc time)
```
输出图像为
![Ploynomial](Problem_3/result.png )
>Figure 1 Ploynomial
  
由此图我们可以看出所求六零点分别所在的大概区间，为我们Part B中进行迭代求根提供了方便
### Part B
  
#### Code
  
代码如下
```julia
include("../Brent.jl")
  
function P(x::Float64)
    par::Array{Int32}=[924,-2772,3150,-1680,420,-42,1]
    X::Array{Float64}=[x^(i) for i=6:-1:0]
    result::Float64=sum(X.*par)
    return result
end
function main(starts::Array{Float64}=[0,0.1,0.3,0.6,0.8,0.9])
    h::Float64=0.1
    maxIndex::UInt32=50
    tolerance::Float64=10^(-8)
    result=zeros(Float64,6)
  
    result.=Find.((P,),(h,),(tolerance,),(maxIndex,),starts)
end
  
@time main()
```  
#### 结果及分析
  
程序所得结果为（其中计时部分已经多次计时刨除编译所需时间）
```
  0.192234 seconds (493.14 k allocations: 25.263 MiB, 5.05% gc time)
6-element Array{Float64,1}:
 0.033765238771256034
 0.16939530676596684 
 0.38069040695834594 
 0.6193095930416012  
 0.8306046932340159  
 0.9662347612287352
```
所以方程<img src="https://latex.codecogs.com/gif.latex?924%20x^{6}-2772%20x^{5}+3150%20x^{4}-1680%20x^{3}+420%20x^{2}-42%20x+1=0"/>的解为
<p align="center"><img src="https://latex.codecogs.com/gif.latex?&#x5C;left&#x5C;{&#x5C;begin{aligned}x_{1}&amp;=&amp;0.0337652388&#x5C;&#x5C;x_{2}&amp;=&amp;0.1693953068&#x5C;&#x5C;x_{3}&amp;=&amp;0.3806904070&#x5C;&#x5C;x_{4}&amp;=&amp;0.6193095930&#x5C;&#x5C;x_{5}&amp;=&amp;0.8306046932&#x5C;&#x5C;x_{6}&amp;=&amp;0.9662347612&#x5C;&#x5C;&#x5C;end{aligned}&#x5C;right."/></p>  
  
### Part C
  
#### Code
  
代码如下
```julia
include("FindingRoots.jl")
  
function GetStarts(func::Function)
    gap::Float64=0.01
    starts=zeros(Float64,6)
    flag::Int8=sign(func(0.0))
    here::Float64=0.0
    count::UInt8=1
    while count<=6
        temp::Float64=func(here+gap)
        flag!=sign(temp) && (starts[count]=here;true) && (flag=sign(temp);true) && (count+=1;true)
        here+=gap
    end
    return starts
end
  
main(GetStarts(P))
```  
#### 结果及分析
  
结果如下
```
  0.164669 seconds (490.05 k allocations: 25.131 MiB, 2.70% gc time)
6-element Array{Float64,1}:
 0.03376524289842399
 0.16939530676686765
 0.38069040687784345
 0.6193095930415956 
 0.8306046932331417 
 0.9662347571015799
```
可以看出在未实现通过绘图确定根大概范围的情况下仍然可以得出精确的解
  