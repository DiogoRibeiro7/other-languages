/* fibonacci_fast_doubling.c
 * O(log n) Fibonacci via fast doubling.
 */
#include <stdio.h>

typedef unsigned long long u64;

static void fib_pair(u64 n, u64* fn, u64* fn1) {
    if (n == 0) {
        *fn = 0;
        *fn1 = 1;
        return;
    }

    u64 a, b;
    fib_pair(n >> 1, &a, &b);
    u64 c = a * ((b << 1) - a);
    u64 d = a * a + b * b;
    if ((n & 1ULL) == 0) {
        *fn = c;
        *fn1 = d;
    } else {
        *fn = d;
        *fn1 = c + d;
    }
}

static u64 fib_fast(u64 n) {
    u64 fn, fn1;
    fib_pair(n, &fn, &fn1);
    return fn;
}

int main(void) {
    u64 n = 92;
    printf("fib_fast(%llu) = %llu\n", n, fib_fast(n));
    return 0;
}
