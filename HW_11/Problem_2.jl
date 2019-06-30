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
function main(node)
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
    print("The dividing point is ",step,"\n")
end
main(100)