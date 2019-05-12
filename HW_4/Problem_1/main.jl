include("getResult.jl")
include("image.jl")

function main()
    N::UInt32=20000
    maxIndex::UInt8=30
    CUDA::Bool=true
    times::Bool=false

    @time result=produce(N,maxIndex,CUDA,times)
    color_image(result,times,maxIndex,CUDA)

    println("Everything is done. Have fun!")
end

@time main()