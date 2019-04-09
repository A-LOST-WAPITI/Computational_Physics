using Colors,FileIO

function color_image(result::Array{UInt8},times::Bool,maxIndex::UInt8)
    times && (cmap=colormap("RdBu",maxIndex+1);true) || (cmap=colormap("RdBu",4);true)
    cmap=Array{RGB{Float16}}(cmap)
    color_lookup(val,cmap)=cmap[(val+1)]
    fileName::String=""
    times && (fileName="result_times.png";true) || (fileName="result.png";true)
    save(joinpath(@__DIR__,fileName),color_lookup.(result,(cmap,)))
end