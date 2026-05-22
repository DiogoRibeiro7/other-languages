program johnson_apsp
    implicit none
    integer, parameter :: n = 5, e = 10, inf = 1000000000
    integer :: u(e), v(e), w(e)
    integer :: h(n), all(n, n)
    integer :: i
    logical :: ok

    u = [1,1,2,2,2,3,4,4,5,5]
    v = [2,4,3,4,5,2,3,5,1,3]
    w = [6,7,5,8,-4,-2,-3,9,2,7]

    call bellman_ford_potential(u, v, w, h, ok)
    if (.not. ok) then
        write (*,'(A)') "johnson_neg_cycle = 1"
        stop
    end if

    do i = 1, n
        call dijkstra(i, u, v, w, h, all(i, :))
    end do

    write (*,'(A,5(I0,A))') "johnson_row0 = [", all(1,1), ",", all(1,2), ",", all(1,3), ",", all(1,4), ",", all(1,5), "]"
    write (*,'(A,5(I0,A))') "johnson_row1 = [", all(2,1), ",", all(2,2), ",", all(2,3), ",", all(2,4), ",", all(2,5), "]"
    write (*,'(A,5(I0,A))') "johnson_row3 = [", all(4,1), ",", all(4,2), ",", all(4,3), ",", all(4,4), ",", all(4,5), "]"
    write (*,'(A)') "johnson_neg_cycle = 0"

contains
    subroutine bellman_ford_potential(u, v, w, h, ok)
        integer, intent(in) :: u(e), v(e), w(e)
        integer, intent(out) :: h(n)
        logical, intent(out) :: ok
        integer :: it, j
        logical :: changed

        h = 0
        do it = 1, n - 1
            changed = .false.
            do j = 1, e
                if (h(u(j)) + w(j) < h(v(j))) then
                    h(v(j)) = h(u(j)) + w(j)
                    changed = .true.
                end if
            end do
            if (.not. changed) exit
        end do

        ok = .true.
        do j = 1, e
            if (h(u(j)) + w(j) < h(v(j))) then
                ok = .false.
                return
            end if
        end do
    end subroutine bellman_ford_potential

    subroutine dijkstra(src, u, v, w, h, out)
        integer, intent(in) :: src, u(e), v(e), w(e), h(n)
        integer, intent(out) :: out(n)
        integer :: dist(n), deg(n), to(n, e), rw(n, e)
        integer :: hn(256), hd(256), hs
        integer :: i, j, x, dx, y, nd

        deg = 0
        do i = 1, e
            deg(u(i)) = deg(u(i)) + 1
            to(u(i), deg(u(i))) = v(i)
            rw(u(i), deg(u(i))) = w(i) + h(u(i)) - h(v(i))
        end do

        dist = inf
        dist(src) = 0
        hs = 0
        call heap_push(hn, hd, hs, src, 0)

        do while (hs > 0)
            call heap_pop(hn, hd, hs, x, dx)
            if (dx /= dist(x)) cycle
            do j = 1, deg(x)
                y = to(x, j)
                nd = dx + rw(x, j)
                if (nd < dist(y)) then
                    dist(y) = nd
                    call heap_push(hn, hd, hs, y, nd)
                end if
            end do
        end do

        do i = 1, n
            if (dist(i) >= inf / 2) then
                out(i) = inf
            else
                out(i) = dist(i) - h(src) + h(i)
            end if
        end do
    end subroutine dijkstra

    subroutine heap_push(hn, hd, hs, node, d)
        integer, intent(inout) :: hn(256), hd(256), hs
        integer, intent(in) :: node, d
        integer :: i, p, tn, td
        hs = hs + 1
        i = hs
        hn(i) = node
        hd(i) = d
        do while (i > 1)
            p = i / 2
            if (hd(p) <= hd(i)) exit
            tn = hn(p); td = hd(p)
            hn(p) = hn(i); hd(p) = hd(i)
            hn(i) = tn; hd(i) = td
            i = p
        end do
    end subroutine heap_push

    subroutine heap_pop(hn, hd, hs, node, d)
        integer, intent(inout) :: hn(256), hd(256), hs
        integer, intent(out) :: node, d
        integer :: i, l, r, s, tn, td
        node = hn(1)
        d = hd(1)
        hn(1) = hn(hs)
        hd(1) = hd(hs)
        hs = hs - 1
        i = 1
        do
            l = 2 * i
            r = l + 1
            s = i
            if (l <= hs .and. hd(l) < hd(s)) s = l
            if (r <= hs .and. hd(r) < hd(s)) s = r
            if (s == i) exit
            tn = hn(i); td = hd(i)
            hn(i) = hn(s); hd(i) = hd(s)
            hn(s) = tn; hd(s) = td
            i = s
        end do
    end subroutine heap_pop
end program johnson_apsp
