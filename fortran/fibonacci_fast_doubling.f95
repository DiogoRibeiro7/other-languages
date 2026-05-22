program fibonacci_fast_doubling
    implicit none
    integer(8) :: n

    n = 92_8
    print '(A, I0, A, I0)', "fib_fast(", n, ") = ", fib_fast(n)

contains
    recursive subroutine fib_pair(k, fn, fn1)
        integer(8), intent(in) :: k
        integer(8), intent(out) :: fn, fn1
        integer(8) :: a, b, c, d

        if (k == 0_8) then
            fn = 0_8
            fn1 = 1_8
            return
        end if

        call fib_pair(k / 2_8, a, b)
        c = a * (2_8 * b - a)
        d = a * a + b * b

        if (mod(k, 2_8) == 0_8) then
            fn = c
            fn1 = d
        else
            fn = d
            fn1 = c + d
        end if
    end subroutine fib_pair

    integer(8) function fib_fast(k)
        integer(8), intent(in) :: k
        integer(8) :: fn, fn1

        call fib_pair(k, fn, fn1)
        fib_fast = fn
    end function fib_fast
end program fibonacci_fast_doubling
