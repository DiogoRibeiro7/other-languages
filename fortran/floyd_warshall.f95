program floyd_warshall
    implicit none
    integer, parameter :: n = 4, inf = 1000000000
    integer :: d(n, n)
    integer :: i, j, k

    d = reshape([ &
        0, inf, inf, inf, &
        5, 0, inf, inf, &
        inf, 3, 0, inf, &
        10, inf, 1, 0 &
    ], [n, n])

    do k = 1, n
        do i = 1, n
            do j = 1, n
                if (d(i, k) < inf .and. d(k, j) < inf) then
                    if (d(i, k) + d(k, j) < d(i, j)) d(i, j) = d(i, k) + d(k, j)
                end if
            end do
        end do
    end do

    write (*,'(A,4(I0,A))') "floyd_row0 = [", d(1,1), ",", d(1,2), ",", d(1,3), ",", d(1,4), "]"
    write (*,'(A,4(I0,A))') "floyd_row1 = [", d(2,1), ",", d(2,2), ",", d(2,3), ",", d(2,4), "]"
end program floyd_warshall
