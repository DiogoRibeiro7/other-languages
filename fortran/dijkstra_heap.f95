program dijkstra_heap
    implicit none
    integer, parameter :: n = 6, max_edges = 8, inf = 1000000000
    integer :: head(n), to(n, max_edges), w(n, max_edges), deg(n)
    integer :: dist(n)
    integer :: i

    head = -1
    deg = 0

    call add_undirected(1, 2, 7, to, w, deg)
    call add_undirected(1, 3, 9, to, w, deg)
    call add_undirected(1, 6, 14, to, w, deg)
    call add_undirected(2, 3, 10, to, w, deg)
    call add_undirected(2, 4, 15, to, w, deg)
    call add_undirected(3, 4, 11, to, w, deg)
    call add_undirected(3, 6, 2, to, w, deg)
    call add_undirected(4, 5, 6, to, w, deg)
    call add_undirected(5, 6, 9, to, w, deg)

    call dijkstra(1, to, w, deg, dist, inf)
    write (*,'(A,6(I0,A))') "dijkstra_dist = [", dist(1), ",", dist(2), ",", dist(3), ",", dist(4), ",", dist(5), ",", dist(6), "]"

contains
    subroutine add_edge(u, v, cost, to, w, deg)
        integer, intent(in) :: u, v, cost
        integer, intent(inout) :: to(n, max_edges), w(n, max_edges), deg(n)
        deg(u) = deg(u) + 1
        to(u, deg(u)) = v
        w(u, deg(u)) = cost
    end subroutine add_edge

    subroutine add_undirected(u, v, cost, to, w, deg)
        integer, intent(in) :: u, v, cost
        integer, intent(inout) :: to(n, max_edges), w(n, max_edges), deg(n)
        call add_edge(u, v, cost, to, w, deg)
        call add_edge(v, u, cost, to, w, deg)
    end subroutine add_undirected

    subroutine heap_push(hn, hd, hs, node, d)
        integer, intent(inout) :: hn(64), hd(64), hs
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
        integer, intent(inout) :: hn(64), hd(64), hs
        integer, intent(out) :: node, d
        integer :: i, l, r, s, tn, td
        node = hn(1); d = hd(1)
        hn(1) = hn(hs); hd(1) = hd(hs)
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

    subroutine dijkstra(source, to, w, deg, dist, inf)
        integer, intent(in) :: source, to(n, max_edges), w(n, max_edges), deg(n), inf
        integer, intent(out) :: dist(n)
        integer :: hn(64), hd(64), hs
        integer :: u, du, i, v, nd

        do i = 1, n
            dist(i) = inf
        end do
        dist(source) = 0
        hs = 0
        call heap_push(hn, hd, hs, source, 0)

        do while (hs > 0)
            call heap_pop(hn, hd, hs, u, du)
            if (du /= dist(u)) cycle
            do i = 1, deg(u)
                v = to(u, i)
                nd = du + w(u, i)
                if (nd < dist(v)) then
                    dist(v) = nd
                    call heap_push(hn, hd, hs, v, nd)
                end if
            end do
        end do
    end subroutine dijkstra
end program dijkstra_heap
