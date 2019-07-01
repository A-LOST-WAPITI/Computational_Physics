using Plots;gr()

f(x)=exp(-x)
df(x)=-exp(-x)

function diffF(func,node,h)
    diff=(func(node+h)-func(node))/h
    return diff
end
function diffC(func,node,h)
    diff=(func(node+h/2)-func(node-h/2))/h
    return diff
end
function divide(node)
    step=10^(-2)
    while true
        F=diffF(f,node,step)
        C=diffC(f,node,step)
        errF=abs(F-df(node))
        errC=abs(C-df(node))
        if errC>errF
            break
        end
        step+=1
    end
    print("The target point is ",node,", the dividing point is ",step,"\n")
    return step
end
function main()
    nodes=[i for i=0:10:100]
    steps=similar(nodes,Float64)
    for i=1:length(nodes)
        steps[i]=divide(nodes[i])
    end
    plot(nodes,steps,legend=false)
    png(joinpath(@__DIR__,"Problem_2.png"))
end
main()