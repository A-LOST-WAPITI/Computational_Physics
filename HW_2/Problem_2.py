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
