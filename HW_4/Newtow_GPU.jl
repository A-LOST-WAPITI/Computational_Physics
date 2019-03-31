#=
该文件为使用GPU来进行计算的部分
测试环境为Ryzen 1500x四核八线程，8G 3000MHz内存，显卡为GTX 1050ti
10000x10000的矩阵最高迭代30次计算所需时间为0.00008s
=#

using Colors,GPUArrays,FileIO
using CuArrays:CuArray

const N=10000
const maxIndex=30

f(x)=x^3-1
d_f(x)=3x^2
function Newton(z0,maxIndex)
    z=z0
    here1::ComplexF32=1+0im
    here2::ComplexF32=-1/2+(sqrt(3)/2)im
    here3::ComplexF32=-1/2-(sqrt(3)/2)im
    for i=1:maxIndex
        abs2(z-here1)<10^(-10) && return 1
        abs2(z-here2)<10^(-10) && return 2
        abs2(z-here3)<10^(-10) && return 3
        z=z-f(z)/d_f(z)
    end
    return 0
end

dots=[ComplexF32(i,j) for i=LinRange(-2,2,N),j=LinRange(2,-2,N)]
dots=CuArray(dots)
result=zeros(UInt8,N,N)
result=CuArray(result)
@time result.=Newton.(dots,maxIndex)
result=Array(result)

cmap=colormap("RdBu",4)
color_lookup(val,cmap)=cmap[(val+1)]
save("/home/wapiti/on-the-fly/Computational_Physics/HW_4/result.png",color_lookup.(result,(cmap,)))