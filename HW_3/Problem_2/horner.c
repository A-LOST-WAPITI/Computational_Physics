#include "stdio.h"
#include "math.h"

int cof[9]={-9,36,-84,126,-126,84,-36,9,-1};

double ser(double index) {
    double power;
    power=1;
    for (size_t i=0;i<9;i++) {
        power*=index;
        power+=cof[i];
    }
}
void main() {
    for(size_t i=7000;i<=13000;i++) {
        double index,power;
        index=(double)i/10000;
        power=ser(index);
        printf("%f %.30f\n",index,power);
    }
}