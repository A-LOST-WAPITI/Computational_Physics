#include "stdio.h"
#include "math.h"
#include "stdbool.h"

double err(int index, bool normalize) {
    int b;
    b=(int)pow(10,index);
    double r;
    r=sqrt(b*b-4);
    float x;
    if (normalize) {
        x=2/(r+b);
    }
    else {
        x=(b-r)/2;
    }
    double std;
    std=2/(r+b);
    double err;
    err=(x-std)/std*100;
    return err;
}
void main() {
    printf("normalize之前：\n");
    bool flag=false;
    for(size_t i=2;i<6;i++)
    {
        printf("当b的值为 %d 时，相对误差为 %e %%\n",(int)pow(10,i),err(i,flag));
    }
    flag=true;
    printf("normalize之前：\n");
    for(size_t i=2;i<6;i++)
    {
        printf("当b的值为 %d 时，相对误差为 %e %%\n",(int)pow(10,i),err(i,flag));
    }
}