#include "stdio.h"
#include "math.h"

float ser(index){
    return 1.0/(2*index-1);
}
float posSum(){
    float Sum=0;
    for(size_t i=1;i<=5*(int)pow(10,7);i++)
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
float resSum(){
    float Sum=0;
    for(size_t i=5*(int)pow(10,7);i>0;i--)
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

void main(){
    float posResult,resResult;
    posResult=4*posSum();
    printf("%f \n",posResult);
    resResult=4*resSum();
    printf("%f \n",resResult);
}