
#include <stdio.h>

int mystery(char *, int);

char *str = "Good mood food."; //15 bytes
void main () {
    int n = 15;
    printf("The return value was:  %d.\n", mystery(str,n));
    return;
}
