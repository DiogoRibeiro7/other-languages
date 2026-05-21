program fibonacci_recursive
    implicit none
    integer :: n

    n = 20
    print *, "fib_recursive(", n, ") = ", fib_recursive(n)

contains
    recursive integer function fib_recursive(k) result(value)
        implicit none
        integer, intent(in) :: k

        if (k < 2) then
            value = k
        else
            value = fib_recursive(k - 1) + fib_recursive(k - 2)
        end if
    end function fib_recursive
end program fibonacci_recursive
