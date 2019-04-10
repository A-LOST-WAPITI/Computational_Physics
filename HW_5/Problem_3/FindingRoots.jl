function P(x::Float32)
    par::Array{Int32}=[924,-2772,3150,-1680,420,-42,1]
    X::Array{Float32}=[x^(i) for i=6:-1:0]
    result::Float32=sum(X.*par)
    return result
end
function P_d(x::Float32)
    par::Array{Float32}=[924,-2772,3150,-1680,420,-42]
    index::Array{UInt8}=[i for i=6:-1:1]
    X::Array{Float32}=[x^(i) for i=5:-1:0]
    result::Float32=sum(X.*par.*index)
    return result
end
