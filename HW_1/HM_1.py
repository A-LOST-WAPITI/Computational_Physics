from os.path import abspath,dirname
from numpy import array,reshape

filePath=dirname(abspath(__file__))

#用于数据处理的部分
with open(filePath+"/lcrs.txt","r") as f:
    rawStr=f.read()
numList=rawStr.split("#")[-1].replace("\n"," ").split()
numArray=array(numList).reshape([-1,4])
czList,thetaList,phiList,AMList=[numArray[:,k].tolist() for k in range(4)]
czList=list(map(int,czList))
czResultList=[max(czList),min(czList)]
AMList=list(map(float,AMList))
AMResultList=[czList[AMList.index(min(AMList))],czList[AMList.index(max(AMList))]]
#输出文件的格式
result="Problem 2 \n"
result+="Part A \n"
result+="The lagest recession velocity is: "
result+=str(czResultList[0])
result+="\nThe smallest recession velocity is: "
result+=str(czResultList[1])
result+="\nPart B \n"
result+="The recession velocities of the brightest galaxies is: "
result+=str(AMResultList[0])
result+="\nThe recession velocities of the faintest galaxies is: "
result+=str(AMResultList[1])
print(result+"\n")
result+="\nPart C \n"
partC=input("Please input the answer for Part C: \n")
result+=partC
#输出文件
with open(filePath+"/galaxies.txt","w") as f:
    f.writelines(result)