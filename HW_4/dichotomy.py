import math


def dichotomy (function, a, b):  # 定义二分法函数格式
    start = a
    end = b
    if function(a) == 0:  # a,b直接就是根的情形
        return a
    elif function(b) == 0:
        return b
    elif function(a) * function(b) > 0:  # a,b之间无根的情形
        print("couldn't find root in [a,b]")
        return
    else:  # a,b之间有根的情形
        mid = (start + end) / 2
        while abs(start - mid) > 0.000000001:  # 精度
            if function(mid) == 0:
                return mid
            elif function(mid) * function(start) < 0:
                end = mid
            else:
                start = mid
            mid = (start + end) / 2
        return mid


def f(x):
    return math.exp(x)-math.cos(x)

print('0')
print(dichotomy(f, -math.pi, -0.000000001))

i = 2
while i <= 100 : # -100pi到0根的情况
    print(dichotomy(f, -i*math.pi, -(i-1)*math.pi))
    i += 1
