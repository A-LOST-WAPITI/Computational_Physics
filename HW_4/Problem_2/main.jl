using Debugger
function bisec(f, a, b) 
	# 定义需要的参数
	fa = f(a)
	fb = f(b)
    fmid = 0
    tol = 10^(-7)

	if(fa * fb < 0) # ａｂ中有一根则必异号
		for j = 1:100000000
			# 计算中值c
			mid = (a + b) / 2 
			fmid = f(mid)
			# 中值为零或已保证在精度内的情况
			if (fmid == 0) || ((b - a) / 2 < tol)
				return mid
			end
			# 中值与ａ值同号的情况
			if fmid * fa > 0
				a = mid
				fa = fmid
			else
				b = mid
			end
		end
	end
end
function function1(x)
    4cos(x)-exp(x)
end
function main()
	println("0")
	root=bisec(function1, -pi, -0.000000001)
	println("$root")
	for i = -1:100 # -100pi到-pi根的情况
		x=sort([-i*pi,-(i-1)*pi])
		root = bisec(function1,x[1],x[2])
		println("$root")
    end
end

@enter main()
# 我不知道为什么我的　println　不能用，用就报错，连自动补齐都没有println ,查了一下也没有这种情况，你们在你们电脑上试试把show换成println．
# 数据我对比了python 和　mathematica 的解，都没问题了．