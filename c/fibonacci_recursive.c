/* fibonacci_recursive.c
 * Recursive Fibonacci example in C.
 */
#include <stdio.h>

static unsigned long long fibonacci_recursive(unsigned int n) {
    if (n < 2) {
        return n;
    }
    return fibonacci_recursive(n - 1) + fibonacci_recursive(n - 2);
}

int main(void) {
    unsigned int n = 20;
    printf("fib_recursive(%u) = %llu\n", n, fibonacci_recursive(n));
    return 0;
}
