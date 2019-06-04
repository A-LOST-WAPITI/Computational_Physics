# 计算物理第九次作业
>万国麟
>2017141221045

## Problem 1
### Code
@import "./Problem_1.jl" {as=julia}
### 运行结果
![Problem_1](Problem_1.png)
>Figure 1 $C_{v}$图像

### 结果分析
使用Simphon积分法计算$C_{v}$的函数值,其中`Simphon`函数为积分函数,`main`函数用于生成函数值,`Plot`函数用于绘图并保存.
在计算过程中,考虑到被积函数在$0$处不解析,考虑采用罗必塔法则
$$\lim\limits_{x\to0}\frac{x^4e^{x}}{(e^x-1)^2}=0$$
所以可以在$0$处右加一个小量`tolerance`来避免无解同时不会影响整个积分值.
最终结果的图像也可以证明确实并无太大影响.
## Problem 2
### Code
包含整个自适应Trapezoid与Simpson积分的代码如下
@import "./Adaptive.jl" {as=julia}
用于Problem 2求解过程的代码如下
@import "./Problem_2.jl" {as=julia}
### 运行结果
>Trapezoid: 0.4558325323863607
>Slice count: 1048576
>Simpson:   0.455832532281498
>Slice count: 2048

### 结果分析
自适应过程中,两者调用的递归算法统一,均使用`Re`函数来实现,其中`Trap`参数为确定是否采用Trapezoid方法的布尔变量.当其值为`True`时,采用Trapezoid方法计算,否则采用Simphon方法计算.每次递归均会对下一次计算的误差上限进行半衰来保证总误差始终在`eps`之内.`Adaptive`函数为调用每个方法的自适应算法来进行给定函数`func`在给定上下限`upper`,`lower`之间误差限制在`eps`之内的一个积分值`result`以及进行区间划分的次数`count`.最终结果中,通过两种方法所得结果在给定误差允许范围$10^{-10}$内数据稳定相同,但是在划分次数上却是天壤之别.
使用Trapezoid方法来进行计算所需的划分次数是Simphon方法的500倍(仅针对$10^{-10}$精度而言,该比值会随着精度设置的不同而变化),通过分析两个方法计算积分值的过程,我们可知两种方法均是牛顿-寇次公式的特定类型.
对于Trapezoid方法而言,其计算方法为将两个端点之间的连接看成线性连接,所以其每段的计算公式为
$$Temp=\frac{h}{2}(f(lower)+f(upper))$$
而Simphon算法将两个端点之间的连接看成是一个二次曲线,该二次曲线由两个端点以及区间中点来确定.经过计算最后的积分值可以近似表示为
$$Temp=\frac{h}{6}(f(lower)+4f(\frac{lower+upper}{2})+f(upper))$$
从图形来看可以明显看出,使用Simphon所拟合的曲线更接近原函数,所以也更能快速收敛到一个精确值
![compare](image/compare.png)
>Figure 2 Trapezoid和Simphon几何上的比较
>(其中绿线为所需函数)

## Problem 3
### Code
@import "./Problem_3.jl" {as=julia}
### 运行结果
运行结果如下
>Trapezoid
>  The power of slice step(h) is: 1.904
>Simpson
>  The power of slice step(h) is: 3.576
>Romberg
>  The power of slice step(h) is: 23.468

误差与分割步长的分布关系如下图
![误差与步长分布](Problem_3.png)
>Figure 3 误差与分割步长的分布

### 结果分析
其中`Raw`函数采用递归方式生成外推表中第一列函数值,用于在`Re`整个的递归过程中递推至第一列时的求值.`Romberg`函数是整个龙贝格积分的主要函数,可以得到给定函数`func`在`lower`到`upper`之间误差在`tolerance`之内的积分值,同时将划分次数置于全局变量`count`中.Trapezoid和Simpson在引入的`Adaptive.jl`文件中.