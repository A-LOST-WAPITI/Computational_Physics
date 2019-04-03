include("/home/wapiti/on-the-fly/Computational_Physics/HW_4/getResult.jl")
include("/home/wapiti/on-the-fly/Computational_Physics/HW_4/image.jl")

function main()
    N::UInt32=20000
    maxIndex::UInt8=30
    CUDA::Bool=true

    result=produce(N,maxIndex,CUDA)
    color_image(result)

    println("Everything is done. Have fun!\n")
end

@time main()