include(joinpath(@__DIR__,"getResult.jl"))
include(joinpath(@__DIR__,"image.jl"))

function main()
    N::UInt32=10000
    maxIndex::UInt8=30
    CUDA::Bool=true
    times::Bool=false

    result=produce(N,maxIndex,CUDA,times)
    color_image(result,times,maxIndex)

    println("Everything is done. Have fun!")
end

@time main()