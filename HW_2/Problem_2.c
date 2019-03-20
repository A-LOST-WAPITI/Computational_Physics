#include "quadmath.h"
#include "stdio.h"
#include "time.h"
//用于计时的模块
double getTime(time_t stage1,time_t stage2){
    return (double)(stage2-stage1)/CLOCKS_PER_SEC;
}
//得到arctan的一项
__float128 arctanSer(__float128 num,int index) {
    int flag;
    if (index%2==0) {
        flag=-1;
    }
    else {
        flag=1;
    }
    return flag*powq(num,2*index-1)/(2*index-1);
}
//得到求和项的函数
__float128 getBase(int index) {
    __float128 f_1,f_5,f_239,par1,par2;
    f_1=1.0Q;
    f_5=5.0Q;
    f_239=239.0Q;
    par1=f_1/f_5;
    par2=f_1/f_239;
    return 4*arctanSer(par1,index)-arctanSer(par2,index);
}
//主函数
void main() {
    time_t start=clock();
    int index=1;
    char piStr[102];
    __float128 base,numSum=0.0Q,pi;
    base=getBase(index);
    while (fabsq(base)>powq(10,-100)) { //使用精度作为退出条件
        numSum+=base;
        index++;
        base=getBase(index);
    }
    pi=4*numSum;
    quadmath_snprintf(piStr,sizeof piStr,"%*.100Qe",pi);
    printf("所得Pi值为：\n%s \n",piStr);
    time_t end=clock();
    printf("总时间消耗为：%f \n",getTime(start,end));
}