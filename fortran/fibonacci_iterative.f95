program fibonacci_iterative
    implicit none
    integer :: n

    n = 20
    print *, "fib_iterative(", n, ") = ", fib_iterative(n)

contains
    integer function fib_iterative(k)
        implicit none
        integer, intent(in) :: k
        integer :: i, prev, curr, next

        if (k == 0) then
            fib_iterative = 0
            return
        end if
        if (k == 1) then
            fib_iterative = 1
            return
        end if

        prev = 0
        curr = 1
        do i = 2, k
            next = prev + curr
            prev = curr
            curr = next
        end do
        fib_iterative = curr
    end function fib_iterative
end program fibonacci_iterative
