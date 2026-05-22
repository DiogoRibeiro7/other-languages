program astar_grid
    implicit none
    integer, parameter :: r = 5, c = 6, n = r * c, inf = 1000000000
    integer :: grid(r, c), gscore(n), closed(n)
    integer :: heap_node(256), heap_f(256), hs
    integer :: start, goal, u, ur, uc, vr, vc, v, ng
    integer :: k
    integer :: dr(4), dc(4)

    grid = reshape([ &
        0,1,0,0,0, &
        0,1,0,1,0, &
        0,0,0,1,0, &
        1,1,0,1,0, &
        0,0,0,1,0, &
        0,1,0,0,0 &
    ], [r, c])

    start = node_id(1, 1)
    goal = node_id(5, 6)
    gscore = inf
    closed = 0
    gscore(start) = 0
    hs = 0
    call heap_push(heap_node, heap_f, hs, start, heuristic(start, goal))

    dr = [-1, 1, 0, 0]
    dc = [0, 0, -1, 1]

    do while (hs > 0)
        call heap_pop(heap_node, heap_f, hs, u)
        if (closed(u) == 1) cycle
        closed(u) = 1
        if (u == goal) exit
        ur = row_of(u)
        uc = col_of(u)

        do k = 1, 4
            vr = ur + dr(k)
            vc = uc + dc(k)
            if (vr < 1 .or. vr > r .or. vc < 1 .or. vc > c) cycle
            if (grid(vr, vc) == 1) cycle
            v = node_id(vr, vc)
            if (closed(v) == 1) cycle
            ng = gscore(u) + 1
            if (ng < gscore(v)) then
                gscore(v) = ng
                call heap_push(heap_node, heap_f, hs, v, ng + heuristic(v, goal))
            end if
        end do
    end do

    write (*,'(A,I0)') "astar_path_cost = ", gscore(goal)

contains
    integer function node_id(rr, cc)
        integer, intent(in) :: rr, cc
        node_id = (rr - 1) * c + cc
    end function node_id

    integer function row_of(id)
        integer, intent(in) :: id
        row_of = (id - 1) / c + 1
    end function row_of

    integer function col_of(id)
        integer, intent(in) :: id
        col_of = mod(id - 1, c) + 1
    end function col_of

    integer function heuristic(a, b)
        integer, intent(in) :: a, b
        heuristic = abs(row_of(a) - row_of(b)) + abs(col_of(a) - col_of(b))
    end function heuristic

    subroutine heap_push(hn, hf, hs, node, f)
        integer, intent(inout) :: hn(256), hf(256), hs
        integer, intent(in) :: node, f
        integer :: i, p, tn, tf
        hs = hs + 1
        i = hs
        hn(i) = node
        hf(i) = f
        do while (i > 1)
            p = i / 2
            if (hf(p) <= hf(i)) exit
            tn = hn(p); tf = hf(p)
            hn(p) = hn(i); hf(p) = hf(i)
            hn(i) = tn; hf(i) = tf
            i = p
        end do
    end subroutine heap_push

    subroutine heap_pop(hn, hf, hs, node)
        integer, intent(inout) :: hn(256), hf(256), hs
        integer, intent(out) :: node
        integer :: i, l, rr, s, tn, tf
        node = hn(1)
        hn(1) = hn(hs)
        hf(1) = hf(hs)
        hs = hs - 1
        i = 1
        do
            l = 2 * i
            rr = l + 1
            s = i
            if (l <= hs .and. hf(l) < hf(s)) s = l
            if (rr <= hs .and. hf(rr) < hf(s)) s = rr
            if (s == i) exit
            tn = hn(i); tf = hf(i)
            hn(i) = hn(s); hf(i) = hf(s)
            hn(s) = tn; hf(s) = tf
            i = s
        end do
    end subroutine heap_pop
end program astar_grid
