#include <stdio.h>
#include <stdlib.h>

int main(void) {

    int x;
    double y;
    scanf("%d %lf", &x, &y);

    if (x > 10000) {
        fprintf(stderr, "Error: Number is too big\n");
        exit(1);
    }
    printf("Hello, #%d, number is %.10g\n", x, y);
    return 0;
}
