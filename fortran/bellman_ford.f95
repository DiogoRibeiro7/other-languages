program bellman_ford
    implicit none
    integer, parameter :: n = 5, e = 10, inf = 1000000000
    integer :: u(e), v(e), w(e), dist(n)
    integer :: i, j, changed, neg_cycle

    u = [1,1,2,2,2,3,4,4,5,5]
    v = [2,4,3,4,5,2,3,5,1,3]
    w = [6,7,5,8,-4,-2,-3,9,2,7]

    dist = inf
    dist(1) = 0

    do i = 1, n - 1
        changed = 0
        do j = 1, e
            if (dist(u(j)) < inf .and. dist(u(j)) + w(j) < dist(v(j))) then
                dist(v(j)) = dist(u(j)) + w(j)
                changed = 1
            end if
        end do
        if (changed == 0) exit
    end do

    neg_cycle = 0
    do j = 1, e
        if (dist(u(j)) < inf .and. dist(u(j)) + w(j) < dist(v(j))) neg_cycle = 1
    end do

    write (*,'(A,5(I0,A))') "bellman_ford_dist = [", dist(1), ",", dist(2), ",", dist(3), ",", dist(4), ",", dist(5), "]"
    write (*,'(A,I0)') "bellman_ford_neg_cycle = ", neg_cycle
end program bellman_ford
