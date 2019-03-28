#include "stdio.h"
#include "quadmath.h"
#include "math.h"

int cof[9]={-1,9,-36,84,-126,-84,36,-9,1,0};

float f_compute(int choice,float x) {
    float result=0;
    if (choice) {
        result+=powf(x-1,9);
    }
    else {
        for(size_t i=0;i<9;i++) {
            result+=cof[i]*powf(x-1,i);
        }
    }
    return result;
}
double d_compute(int choice,double x) {
    double result=0;
    if (choice) {
        result+=pow(x-1,9);
    }
    else {
        for(size_t i=0;i<9;i++) {
            result+=cof[i]*pow(x-1,i);
        }
    }
    return result;
}
__float128 q_compute(int choice,__float128 x) {
    __float128 result=0;
    if (choice) {
        result+=powq(x-1,9);
    }
    else {
        for(size_t i=0;i<9;i++) {
            result+=cof[i]*powq(x-1,i);
        }
    }
    return result;
}
void main() {
    float f_temp,f_0_result,f_1_result;
    double d_temp,d_0_result,d_1_result;
    __float128 q_temp;
    char quadStr_0[25],quadStr_1[25];
    for(size_t i=700;i<=1300;i++) {
        f_temp=(float)i/1000;
        d_temp=(double)i/1000;
        q_temp=(__float128)i/1000;
        f_1_result=f_compute(1,f_temp);
        f_0_result=f_compute(0,f_temp);
        d_1_result=d_compute(1,d_temp);
        d_0_result=d_compute(0,d_temp);
        quadmath_snprintf(quadStr_1,sizeof quadStr_1,"%Qe",q_compute(1,q_temp));
        quadmath_snprintf(quadStr_0,sizeof quadStr_0,"%Qe",q_compute(0,q_temp));
        printf("%f %f %f %f %f %s %s\n",f_temp,f_1_result,f_0_result,d_1_result,d_0_result,quadStr_1,quadStr_0);
    }
}