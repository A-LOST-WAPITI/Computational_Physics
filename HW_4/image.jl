using Colors,FileIO

function color_image(result::Array{UInt8})
    cmap=colormap("RdBu",4)
    cmap=Array{RGB{Float16}}(cmap)
    color_lookup(val,cmap)=cmap[(val+1)]
    save("/home/wapiti/on-the-fly/Computational_Physics/HW_4/result.png",color_lookup.(result,(cmap,)))
end