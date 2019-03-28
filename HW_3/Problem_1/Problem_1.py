import re
from os import path
import matplotlib.pyplot as plt

def getList():
    dirPath=path.dirname(path.abspath(__file__))
    filePath=dirPath+"/Problem_1.txt"
    with open(filePath,"r") as f:
        rawStrList=f.readlines()
    rawList=[]
    for line in rawStrList:
        flag=re.search("当",line)
        if flag is not None:
            num=float(line.split()[-2])
            if num>1:
                num=10**(-4)
            rawList.append(num)
    return rawList
X=[10**i for i in range(2,6)]
Y=getList()
Y1=Y[:4]
Y2=Y[4:]
plt.plot(X,Y1,"x-",label="before normalization")
plt.plot(X,Y2,"+-",label="after normalization")
plt.legend()
plt.xscale("log")
plt.show()