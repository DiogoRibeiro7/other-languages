/* fibonacci_iterative.c
 * Iterative Fibonacci example in C.
 */
#include <stdio.h>

static unsigned long long fibonacci_iterative(unsigned int n) {
    if (n == 0) {
        return 0;
    }
    if (n == 1) {
        return 1;
    }

    unsigned long long prev = 0;
    unsigned long long curr = 1;
    for (unsigned int i = 2; i <= n; i++) {
        unsigned long long next = prev + curr;
        prev = curr;
        curr = next;
    }
    return curr;
}

int main(void) {
    unsigned int n = 20;
    printf("fib_iterative(%u) = %llu\n", n, fibonacci_iterative(n));
    return 0;
}
