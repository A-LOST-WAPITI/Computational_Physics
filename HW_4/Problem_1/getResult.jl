using GPUArrays
using CuArrays:CuArray

include("NewtonFunction.jl")

function produce(N::UInt32,maxIndex::UInt8,CUDA::Bool,times::Bool)
    dots=[ComplexF32(i,j) for i=LinRange(-2,2,N),j=LinRange(2,-2,N)]
    result=zeros(UInt8,N,N)
    if (CUDA)
        dots=CuArray(dots)
        result=CuArray(result)
    end
    result.=Newton.(dots,maxIndex,times)
    if typeof(result)!=Array
        result=Array(result)
    end
    return result
end