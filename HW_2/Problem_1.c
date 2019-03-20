#include "stdio.h"
#include "math.h"
#include "time.h"
//用于计时的模块
double getTime(time_t stage1,time_t stage2){
    return (double)(stage2-stage1)/CLOCKS_PER_SEC;
}
//计算求和项的函数
float ser(index){
    return 1.0/(2*index-1);
}
//正向求和函数
float posSum(){
    float Sum=0;
    for(size_t i=1;i<=5*(int)pow(10,8);i++) //用5*10**8来进行次数判断
    {
        if (i%2==0) {
            Sum-=ser(i);
        }
        else
        {
            Sum+=ser(i);
        }   
    }
    return Sum;
}
//逆向求和函数
float resSum(){
    float Sum=0;
    for(size_t i=5*(int)pow(10,8);i>0;i--)  //用5*10**8来进行次数判断
    {
        if (i%2==0) {
            Sum-=ser(i);
        }
        else
        {
            Sum+=ser(i);
        }   
    }
    return Sum;
}
//主函数
void main(){
    time_t start=clock();
    float posResult,resResult;
    posResult=4*posSum();
    printf("正向求和结果为：%.10f \n",posResult);
    time_t stage1=clock();
    resResult=4*resSum();
    printf("逆向求和结果为：%.10f \n",resResult);
    time_t stage2=clock();
    printf("第一段的时间为：%f\n",getTime(start,stage1));
    printf("第二段的时间为：%f\n",getTime(stage1,stage2));
    printf("总时间消耗为：%f\n",getTime(start,stage2));
}