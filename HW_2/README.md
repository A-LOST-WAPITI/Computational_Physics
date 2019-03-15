# 计算物理的第二次作业

> 万国麟
> 2017141221045

## Problem 1
### Code

```python
import time
#计时开始时间点
start=time.time()
#得到每一项的函数
def ser(index):
    if index%2==0:
        flag=-1
    else:
        flag=1
    return flag/(2*index-1)
#计算
numSum=0    #和置零
for index in range(1,5*10**5+1):
    base=ser(index) #得到第index项
    numSum+=base    #累加
pi=round(4*numSum,10)   #Python默认精度为17位，此处取10位
print(pi)
#计时结束时间点
end=time.time()
print("Total time cost is",end-start)
```

### 结果
运行以上代码所得结果为：

> 3.1415906536
> Total time cost is 0.17086386680603027

## Problem 2
### Code

```python
import time
from decimal import getcontext,Decimal
#计时开始时间点
start=time.time()
#精度设置（此处设置为总位数，为使精确到小数点后100位应设为101
getcontext().prec=101
#用于arctan计算的精确值
par1=Decimal(1)/Decimal(5)
par2=Decimal(1)/Decimal(239)
#得到arctan每一项与求和每一项的函数
def arctanSer(num,index):
    if index%2==0:  #正负判断
        flag=-1
    else:
        flag=1
    return flag*num**(2*index-1)/(2*index-1)
def getBase(index):
    global par1,par2
    base=4*arctanSer(par1,index)-arctanSer(par2,index)
    return base
#计算
index=1
numSum=Decimal(0)
base=getBase(index)
while abs(base)>10**(-100): #确保后续项对求和的影响小于小数点后100位
    numSum+=base
    index+=1
    base=getBase(index)
pi=4*numSum
print(pi)
#计时结束时间点
end=time.time()
print("Total time cost is",end-start)
```

### 结果
运行以上代码所得结果为：

>3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170677
>Total time cost is 0.0011625289916992188

## 分析
Problem 1中使用Gregory-Leibniz方法来计算$\pi$的近似值时，对于所求精度为小数点后10位时产生的大规模误差即出现在了小数点后6位。该误差原因应该在于退出条件`index<5*10**5`有关，当退出时后续一项对整体和的影响仍为小数点后第6位。
尝试过将退出条件更换为`index<5*10**10`或`abs(base)<10**(-10)`等可以将求和精确到小数点后10位的条件，但计算时间过长只能作罢，在这一过程也体现出Problem 1中提出的算法收敛速度较慢。
Program 2中使用Machin’s formula来进行$\pi$的近似值的计算时，可以将精度调节至很高同时保留足够快的收敛速度，两次计算的计时中，在给定相同的硬件环境（单核CPU，2G内存）下得到的更高精度的结果而使用的时间则不足前者的百分之一。
对于Problem 2中得到的结果进行验证：

> 所得$\pi$值：
>3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170677
> 标准$\pi$值:
>3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117068

由上可知，在Problem 2中我们所得的$\pi$值已经与标准值在小数点后100位无差。
而如果dicemal接收值为Python默认的`float`类型（精确17位），即虽设置精确位数为小数点后100位但所使用的源数据精确度不足，所得结果在小数点后16位即开始偏差。
如将Problem 2代码中第8-20行更改为如下：

```python
par1=1/5
par2=1/239
#得到arctan每一项与求和每一项的函数
def arctanSer(num,index):
    if index%2==0:
        flag=-1
    else:
        flag=1
    return flag*num**(2*index-1)/(2*index-1)
def getBase(index):
    global par1,par2
    par1=Decimal(par1)
    par2=Decimal(par2)
    base=4*arctanSer(par1,index)-arctanSer(par2,index)
    return base
```

得到的结果则为：

>3.141592653589793**4**107032954041479970148981482500287393927465713696851877837164053060655790051392213568
>Total time cost is 0.001378774642944336

可见所得结果在**4**处即已经开始出现较大的偏差。