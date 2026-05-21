program lu_solve
    implicit none
    integer, parameter :: n = 3
    real(8) :: a(n, n), b(n), x(n), a_orig(n, n), b_orig(n), row_residuals(n), det
    integer :: parity
    logical :: ok

    a = reshape([ &
        3.0d0, 2.0d0, -1.0d0, &
        2.0d0, -2.0d0, 0.5d0, &
        -1.0d0, 4.0d0, -1.0d0 &
    ], [n, n])
    b = [1.0d0, -2.0d0, 0.0d0]
    a_orig = a
    b_orig = b

    call lu_decompose_in_place(a, b, ok, parity)
    if (.not. ok) then
        print *, "LU failed: singular matrix"
        stop 1
    end if

    call lu_solve_in_place(a, b, x)
    call residual_rows(a_orig, x, b_orig, row_residuals)
    det = lu_determinant(a, parity)
    print '(A, F4.1, A, F4.1, A, F4.1, A)', "lu_solution = [", x(1), ",", x(2), ",", x(3), "]"
    print '(A, F4.1)', "determinant = ", det
    print '(A, ES12.3, A, ES12.3, A, ES12.3, A)', &
        "row_residuals = [", row_residuals(1), ",", row_residuals(2), ",", row_residuals(3), "]"
    print '(A, ES12.3)', "residual_inf_norm = ", residual_inf_norm(a_orig, x, b_orig)

contains
    subroutine swap_rows(mat, vec, r1, r2)
        real(8), intent(inout) :: mat(n, n), vec(n)
        integer, intent(in) :: r1, r2
        real(8) :: tmp
        integer :: j

        if (r1 == r2) return
        do j = 1, n
            tmp = mat(r1, j)
            mat(r1, j) = mat(r2, j)
            mat(r2, j) = tmp
        end do
        tmp = vec(r1)
        vec(r1) = vec(r2)
        vec(r2) = tmp
    end subroutine swap_rows

    subroutine lu_decompose_in_place(mat, vec, ok, parity)
        real(8), intent(inout) :: mat(n, n), vec(n)
        logical, intent(out) :: ok
        integer, intent(out) :: parity
        integer :: k, i, j, pivot
        real(8) :: max_val

        ok = .true.
        parity = 1
        do k = 1, n
            pivot = k
            max_val = abs(mat(k, k))
            do i = k + 1, n
                if (abs(mat(i, k)) > max_val) then
                    max_val = abs(mat(i, k))
                    pivot = i
                end if
            end do

            if (max_val == 0.0d0) then
                ok = .false.
                return
            end if

            if (pivot /= k) then
                parity = -parity
            end if
            call swap_rows(mat, vec, k, pivot)

            do i = k + 1, n
                mat(i, k) = mat(i, k) / mat(k, k)
                do j = k + 1, n
                    mat(i, j) = mat(i, j) - mat(i, k) * mat(k, j)
                end do
            end do
        end do
    end subroutine lu_decompose_in_place

    subroutine lu_solve_in_place(mat, vec, sol)
        real(8), intent(in) :: mat(n, n), vec(n)
        real(8), intent(out) :: sol(n)
        real(8) :: y(n)
        integer :: i, j

        do i = 1, n
            y(i) = vec(i)
            do j = 1, i - 1
                y(i) = y(i) - mat(i, j) * y(j)
            end do
        end do

        do i = n, 1, -1
            sol(i) = y(i)
            do j = i + 1, n
                sol(i) = sol(i) - mat(i, j) * sol(j)
            end do
            sol(i) = sol(i) / mat(i, i)
        end do
    end subroutine lu_solve_in_place

    subroutine residual_rows(mat, sol, vec, rows)
        real(8), intent(in) :: mat(n, n), sol(n), vec(n)
        real(8), intent(out) :: rows(n)
        integer :: i, j

        do i = 1, n
            rows(i) = -vec(i)
            do j = 1, n
                rows(i) = rows(i) + mat(i, j) * sol(j)
            end do
        end do
    end subroutine residual_rows

    real(8) function residual_inf_norm(mat, sol, vec)
        real(8), intent(in) :: mat(n, n), sol(n), vec(n)
        real(8) :: row_residual
        integer :: i, j

        residual_inf_norm = 0.0d0
        do i = 1, n
            row_residual = -vec(i)
            do j = 1, n
                row_residual = row_residual + mat(i, j) * sol(j)
            end do
            residual_inf_norm = max(residual_inf_norm, abs(row_residual))
        end do
    end function residual_inf_norm

    real(8) function lu_determinant(mat, parity)
        real(8), intent(in) :: mat(n, n)
        integer, intent(in) :: parity
        integer :: i

        if (parity > 0) then
            lu_determinant = 1.0d0
        else
            lu_determinant = -1.0d0
        end if
        do i = 1, n
            lu_determinant = lu_determinant * mat(i, i)
        end do
    end function lu_determinant
end program lu_solve
