---
html:
    embed_local_images: true
    offline: true
    toc: true
---  
  
#  计算物理第八次作业
  
>万国麟
>2017141221045
  
  
  
  
  
  
- [ 计算物理第八次作业](#计算物理第八次作业 )
  - [ Problem 1](#problem-1 )
    - [ Code](#code )
    - [ 运行结果及分析](#运行结果及分析 )
  - [ Problem 2](#problem-2 )
    - [ Code](#code-1 )
    - [ 运行结果及分析](#运行结果及分析-1 )
  
  
  
  
  
##  Problem 1
  
###  Code
  
```julia
using Plots
  
include("./Ave.jl")
include("./Linear.jl")
include("./Get.jl")
include("./Test.jl")
  
function main()
    data1_x=[10,8,13,9,11,14,6,4,12,7,5]
    data1_y=[8.04,6.95,7.58,8.81,8.33,9.96,7.24,4.26,10.84,4.82,5.68]
    data2_x=[10,8,13,9,11,14,6,4,12,7,5]
    data2_y=[9.14,8.14,8.74,8.77,9.26,8.10,6.13,3.10,9.13,7.26,4.74]
    data3_x=[10,8,13,9,11,14,6,4,12,7,5]
    data3_y=[7.46,6.77,12.74,7.11,7.81,8.84,6.08,5.39,8.15,6.42,5.73]
    data4_x=[8,8,8,8,8,8,8,19,8,8,8]
    data4_y=[6.58,5.76,7.71,8.84,8.47,7.04,5.25,12.50,5.56,7.91,6.89]
  
    # fit the 4 groups of datas and plot these fits
    Get(data1_x,data1_y,1)
    png(joinpath(@__DIR__,"p_1_data1.png"))
    Get(data2_x,data2_y,2)
    png(joinpath(@__DIR__,"p_1_data2.png"))
    Get(data3_x,data3_y,3)
    png(joinpath(@__DIR__,"p_1_data3.png"))
    Get(data4_x,data4_y,4)
    png(joinpath(@__DIR__,"p_1_data4.png"))
  
    # calculate the Chi-squard of 4 groupd datas
    χ_1=Test(data1_x,data1_y)
    χ_2=Test(data2_x,data2_y)
    χ_3=Test(data3_x,data3_y)
    χ_4=Test(data4_x,data4_y)
  
    print("$χ_1\n")
    print("$χ_2\n")
    print("$χ_3\n")
    print("$χ_4\n")
end
  
@time main()
  
```  
###  运行结果及分析
  
>the coefficient is (0.5000909090909091, 3.0000909090909103)
>the coefficient is (0.5, 3.000909090909091)
>the coefficient is (0.49972727272727274, 3.0024545454545466)
>the coefficient is (0.49990909090909086, 3.0017272727272726)
>1.802810260132835
>1.97334179740443
>1.4822380243238233
>1.9629324382231115
  
+ Data 1
  <img src="https://latex.codecogs.com/gif.latex?&#x5C;chi^2=1.802810260132835"/>
  ![data1](./Problem_1/p_1_data1.png )
  
  
+ Data 2
  <img src="https://latex.codecogs.com/gif.latex?&#x5C;chi^2=1.97334179740443"/>
  ![data1](./Problem_1/p_1_data2.png )
  
+ Data 3
  <img src="https://latex.codecogs.com/gif.latex?&#x5C;chi^2=1.4822380243238233"/>
  ![data1](./Problem_1/p_1_data3.png )
  
+ Data 4
  <img src="https://latex.codecogs.com/gif.latex?&#x5C;chi^2=1.9629324382231115"/>
  ![data1](./Problem_1/p_1_data4.png )
  
##  Problem 2
  
###  Code
  
```julia
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
```  
###  运行结果及分析
  
>τ=89.79769902217106
>A=122.92369239941908
  
自变量变化使得非线性规划变为线性规划
<p align="center"><img src="https://latex.codecogs.com/gif.latex?lnN=y"/></p>  
  
<p align="center"><img src="https://latex.codecogs.com/gif.latex?y=lnA-&#x5C;frac{x}{&#x5C;tau}=C+Dx"/></p>  
  
所以
<p align="center"><img src="https://latex.codecogs.com/gif.latex?&#x5C;tau=-&#x5C;frac{1}{D}"/></p>  
  
<p align="center"><img src="https://latex.codecogs.com/gif.latex?A=e^C"/></p>  
  
  