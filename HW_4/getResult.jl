using GPUArrays
using CuArrays:CuArray

include("/home/wapiti/on-the-fly/Computational_Physics/HW_4/NewtonFunction.jl")

function produce(N::UInt32,maxIndex::UInt8,CUDA::Bool)
    dots=[ComplexF32(i,j) for i=LinRange(-2,2,N),j=LinRange(2,-2,N)]
    result=zeros(UInt8,N,N)
    if (CUDA)
        dots=CuArray(dots)
        result=CuArray(result)
    end
    result.=Newton.(dots,maxIndex)
    if typeof(result)!=Array
        result=Array(result)
    end
    return result
end