
#include "output.h"
#include <stdio.h>
#include <stdlib.h>

float sum_float(float *, int);



// bitwise convert unsigned(32) to float(32)
float u2f(unsigned x) {
    return *((float *)&x);
} // u2f



// 3(a):  insert supporting code for qsort(.., .., .., ..) here:

int compar(const void* p1, const void* p2){
    float diff = (*(float*)p1 - *(float*)p2);
    if(diff<0)
        return -1;
    if(diff>0)
        return 1;
    return (int)diff;
}

void main () {
    float arr1[24], arr2[50];
    float tot1, tot2;
    int i;

    //.-.-.-.-.-.-.-.-.-.-.-.-.-.//
    //. . .   Test case 1   . . .//
    //.-.-.-.-.-.-.-.-.-.-.-.-.-.//
    puts("Test Case 1:\n");
    arr1[0] = u2f(0x7060000f);      // 3(b):  change this value
    tot1 = arr1[0];

    for (i = 1; i < 24; i++) {
        arr1[i] = u2f(0x64000005);  // 3(b):  change this value
        tot1 += arr1[i];
    }
    printf("The total before sorting: ");
    f_printbits(tot1); putchar('\n');

    printf(" The total after sorting: ");
    // 3(a):  insert code for sorting of arr1[] here:
    qsort(arr1, 24, sizeof(float),  compar);
    f_printbits(sum_float(arr1, 24)); putchar('\n');


    //.-.-.-.-.-.-.-.-.-.-.-.-.-.//
    //. . .   Test case 2   . . .//
    //.-.-.-.-.-.-.-.-.-.-.-.-.-.//
    puts("\nTest Case 2:\n");
    tot2 = 0.0;
    for (i = 0; i < 50; i++) {
        arr2[i] = 0.1 * ((float)(1 + (i % 3 == 0) + (i % 7 == 0)));
        tot2 += arr2[i];
    }
    for (i = 0; i < 50; i++) {
        //printf("%.32f ", arr2[i]);
    }
    printf("\n");
    printf("The total before sorting: ");
    f_printbits(tot2); putchar('\n');

    printf(" The total after sorting: ");
    // 3(a):  insert code for sorting of arr2[] here:
    qsort(arr2, 50, sizeof(float),  compar);
    for (i = 0; i < 49; i++) {
        if(arr2[i] > arr2[i+1])
        {
            printf("MAJOR ERROR \n");
            break;
        }
    }
    f_printbits(sum_float(arr2, 50)); putchar('\n');

    puts("");
    return;
}