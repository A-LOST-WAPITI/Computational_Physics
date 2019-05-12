using Colors,FileIO
using CuArrays:CuArray

function color_image(result,times::Bool,maxIndex::UInt8,CUDA::Bool)
    times && (cmap=colormap("RdBu",maxIndex+1);true) || (cmap=colormap("RdBu",4);true)
    cmap=Array{RGB{Float16}}(cmap)
    CUDA && (cmap=CuArray(cmap);true)
    color_lookup(val,cmap)=cmap[(val+1)]
    fileName::String=""
    times && (fileName="result_times.png";true) || (fileName="result.png";true)
    colorArray=Array(color_lookup.(result,(cmap,)))
    save(joinpath(@__DIR__,fileName),colorArray)
end