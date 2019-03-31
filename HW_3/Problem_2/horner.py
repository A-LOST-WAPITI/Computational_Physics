from os import path
import matplotlib.pyplot as plt
from numpy import empty,array,vstack

dirPath=path.dirname(path.abspath(__file__))
filePath=dirPath+"/horner.txt"

with open(filePath,"r") as f:
    strLists=f.readlines()
numArray=empty((0,2),float)
for line in strLists:
    numList=list(map(float,line.split()))
    numArray=vstack((numArray,array(numList)))
X=numArray[:,0]
result=numArray[:,1]
plt.figure()
plt.title("The result of Horner's Method")
plt.plot(X,result,"-",label="result")
plt.legend()
plt.show()