f(x)=x^3-1
d_f(x)=3x^2
function Newton(z0::ComplexF32,maxIndex::UInt8,times::Bool)
    z=z0
    here1::ComplexF32=1+0im
    here2::ComplexF32=-1/2+(sqrt(3)/2)im
    here3::ComplexF32=-1/2-(sqrt(3)/2)im
    for i=1:maxIndex
        times && (abs2(z-here1)<10^(-10) || abs2(z-here2)<10^(-10) || abs2(z-here3)<10^(-10)) && return i
        abs2(z-here1)<10^(-10) && return 1
        abs2(z-here2)<10^(-10) && return 2
        abs2(z-here3)<10^(-10) && return 3
        z=z-f(z)/d_f(z)
    end
    return 0
end