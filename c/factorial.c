/* factorial.c
 * Iterative factorial example in C.
 */
#include <stdio.h>

static unsigned long long factorial(unsigned int n) {
    unsigned long long result = 1;
    for (unsigned int i = 2; i <= n; i++) {
        result *= i;
    }
    return result;
}

int main(void) {
    unsigned int n = 10;
    printf("factorial(%u) = %llu\n", n, factorial(n));
    return 0;
}
