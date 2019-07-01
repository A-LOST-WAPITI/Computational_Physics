using Plots

include("./Ave.jl")
include("./Linear.jl")
include("./Get.jl")
include("./Test.jl")

function main()
    data1_x=[10,8,13,9,11,14,6,4,12,7,5]
    data1_y=[8.04,6.95,7.58,8.81,8.33,9.96,7.24,4.26,10.84,4.82,5.68]
    data2_x=[10,8,13,9,11,14,6,4,12,7,5]
    data2_y=[9.14,8.14,8.74,8.77,9.26,8.10,6.13,3.10,9.13,7.26,4.74]
    data3_x=[10,8,13,9,11,14,6,4,12,7,5]
    data3_y=[7.46,6.77,12.74,7.11,7.81,8.84,6.08,5.39,8.15,6.42,5.73]
    data4_x=[8,8,8,8,8,8,8,19,8,8,8]
    data4_y=[6.58,5.76,7.71,8.84,8.47,7.04,5.25,12.50,5.56,7.91,6.89]

    # fit the 4 groups of datas and plot these fits
    Get(data1_x,data1_y,1)
    png(joinpath(@__DIR__,"p_1_data1.png"))
    Get(data2_x,data2_y,2)
    png(joinpath(@__DIR__,"p_1_data2.png"))
    Get(data3_x,data3_y,3)
    png(joinpath(@__DIR__,"p_1_data3.png"))
    Get(data4_x,data4_y,4)
    png(joinpath(@__DIR__,"p_1_data4.png"))
    
    # calculate the Chi-squard of 4 groupd datas
    χ_1=Test(data1_x,data1_y)
    χ_2=Test(data2_x,data2_y)
    χ_3=Test(data3_x,data3_y)
    χ_4=Test(data4_x,data4_y)

    print("$χ_1\n")
    print("$χ_2\n")
    print("$χ_3\n")
    print("$χ_4\n")
end

@time main()
