---
html:
    embed_local_images: true
    offline: true
    toc: true
---
# 计算物理第十次作业
> 万国麟
> 2017141221045


<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [ 计算物理第十次作业](#计算物理第十次作业)
  - [ Problem 1](#problem-1)
    - [ Code](#code)
    - [ 运行结果及分析](#运行结果及分析)
  - [ Problem 2](#problem-2)
    - [ Code](#code-1)
    - [ 运行结果及分析](#运行结果及分析-1)
  - [ Problem 3](#problem-3)
    - [ Code](#code-2)
    - [ 运行结果及分析](#运行结果及分析-2)

<!-- /code_chunk_output -->


## Problem 1
### Code
@import "./Problem_1.jl" {as=julia}
### 运行结果及分析
>Part A
>The result of the raw integrate is 1.5707963267948968
>The result of integrate is 1.5707963267948966
>Part B
>The result has been saved in an image.
>Part C (raw)
>The result of the raw integrate is 3.135248119345212
>Part C (fixed)
>The result of the fixed integrate is 3.1395926542564587

其中Part B的结果如下图
![Part B](Problem_1_B.png)
>Figure 1 Part B

其中`Integrate`函数为使用自适应辛普森积分来进行自变量变换的积分过程.其中,`trans`函数为变自变量的变换函数,`dTrans`函数为变换函数的导数,`antiTrans`为变换函数的反函数.
## Problem 2
### Code
@import "./Problem_2.jl" {as=julia}
### 运行结果及分析
>The approximate result of the integration is 1.7724538509055157
>The related error of this result is 1.2527525318167949e-16

其中`Gaussian`函数为用于积分的主函数,其停止条件为后续积分值对总积分值的影响小于1%,这样既避免了积分到无穷或非常大的值时引起的发散,又可以很好地保证积分值的准确性.
## Problem 3
### Code
@import "./Problem_3.jl" {as=julia}
### 运行结果及分析
该过程使用自适应辛普森积分进行多维球体体积的计算,其中被积函数的推导如下:[^1]
体积的递推公式为
$$
V_{n}(r)=\int_{-r}^{r} V_{n-1}\left(\sqrt{r^{2}-t^{2}}\right) d t
$$
设$t=r \sin \theta_{1}$,有
$$
V_{n}(r)=r \int_{-\frac{\pi}{2}}^{\frac{\pi}{2}} V_{n-1}\left(r \cos \theta_{1}\right) \cos \theta_{1} d \theta_{1}
$$
迭代$n-1$次得
$$
\begin{aligned} V_{n}(r)=& r^{n-1} \int_{-\frac{\pi}{2}}^{\frac{\pi}{2}} \ldots \int_{-\frac{\pi}{2}}^{\frac{\pi}{2}} V_{1}\left(r \cos \theta_{1} \cos \theta_{2} \ldots \cos \theta_{n-1}\right) \times \\ & \cos \theta_{1} \cos ^{2} \theta_{2} \ldots \cos ^{n-1} \theta_{n-1} d \theta_{1} d \theta_{2} \ldots d \theta_{n-1} \end{aligned}
$$
其中$V_{1}(r)=2 r$,从而
$$
V_{n}(r)=2 r^{n} \int_{-\frac{\pi}{2}}^{\frac{\pi}{2}} \ldots \int_{-\frac{\pi}{2}}^{\frac{\pi}{2}} \int_{-\frac{\pi}{2}}^{\frac{\pi}{2}} \cos ^{2} \theta_{1} \cos ^{3} \theta_{2} \ldots \cos ^{n} \theta_{n-1} d \theta_{1} d \theta_{2} \ldots d \theta_{n-1}
$$
最终结果如下图
![多维球体](Problem_3.png)
>Figure 2 多维球体体积与维度的关系
<!--参考-->
[^1]:https://spaces.ac.cn/archives/3154