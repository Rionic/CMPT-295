
#include <stdio.h>

int get_byte_by_addr(int *, int i);

int get_byte_by_order(int x, int i) {
    // complete this in Part 2.
    if (i==0){
    	x = x & 0xff;
    }
    if (i==1){
    	x = ((x & 0xff00) >> 8);
    }
    if (i==2){
    	x = ((x & 0xff0000) >> 16);
    }
    if(i==3){
    	x = ((x & 0xff000000) >> 24);
	}
    return x;
    // end of Part 2.
}

int x = 0x01234567;
unsigned int y = 0xffffffd6;

void main () {
    // complete this in Part 1.
    printf("x = %x\n", x);
    printf("x = %d\n", x);
    printf("y = %x\n", y);
    printf("y = %d\n", y);
    // end of Part 1

    int i;

    printf("x = ");
    for (i = 0; i < 4; i++) {
        printf("%02x", get_byte_by_order(x, i));
        //printf("\n");
    }
    putchar('\n');

    printf("x = ");
    for (i = 0; i < 4; i++) {
        printf("%02x", get_byte_by_addr(&x, i));
        //printf("\n");
    }
    putchar('\n');

    printf("y = ");
    for (i = 0; i < 4; i++) {
        printf("%02x", get_byte_by_order(y, i));
    }
    putchar('\n');

    printf("y = ");
    for (i = 0; i < 4; i++) {
        printf("%02x", get_byte_by_addr(&y, i));
    }
    putchar('\n');

    return;
}

