import time

start=time.time()

def ser(index):
    if index%2==0:
        flag=-1
    else:
        flag=1
    return flag/(2*index-1)

numSum=0
for index in range(1,2*10**8+1):
    base=ser(index)
    numSum+=base
pi=4*numSum
print(pi)
end1=time.time()

numSum=0
for index in range(2*10**8,0,-1):
    base=ser(index)
    numSum+=base
pi=4*numSum
print(pi)
end2=time.time()

print("The first time cost is",end1-start)
print("The second time cost is",end2-end1)
print("Total time cost is",end2-start)