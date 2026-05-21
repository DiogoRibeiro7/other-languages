/* lu_solve.c
 * LU decomposition with partial pivoting for solving Ax=b.
 */
#include <math.h>
#include <stdio.h>

#define N 3

static void swap_rows(double a[N][N], double b[N], int r1, int r2) {
    if (r1 == r2) {
        return;
    }
    for (int j = 0; j < N; j++) {
        double tmp = a[r1][j];
        a[r1][j] = a[r2][j];
        a[r2][j] = tmp;
    }
    double tb = b[r1];
    b[r1] = b[r2];
    b[r2] = tb;
}

static int lu_decompose(double a[N][N], double b[N]) {
    for (int k = 0; k < N; k++) {
        int pivot = k;
        double max_val = fabs(a[k][k]);
        for (int i = k + 1; i < N; i++) {
            double val = fabs(a[i][k]);
            if (val > max_val) {
                max_val = val;
                pivot = i;
            }
        }
        if (max_val == 0.0) {
            return 0;
        }
        swap_rows(a, b, k, pivot);

        for (int i = k + 1; i < N; i++) {
            a[i][k] /= a[k][k];
            for (int j = k + 1; j < N; j++) {
                a[i][j] -= a[i][k] * a[k][j];
            }
        }
    }
    return 1;
}

static void lu_solve(double a[N][N], double b[N], double x[N]) {
    double y[N];
    for (int i = 0; i < N; i++) {
        y[i] = b[i];
        for (int j = 0; j < i; j++) {
            y[i] -= a[i][j] * y[j];
        }
    }

    for (int i = N - 1; i >= 0; i--) {
        x[i] = y[i];
        for (int j = i + 1; j < N; j++) {
            x[i] -= a[i][j] * x[j];
        }
        x[i] /= a[i][i];
    }
}

static double residual_inf_norm(const double a[N][N], const double x[N], const double b[N]) {
    double norm = 0.0;
    for (int i = 0; i < N; i++) {
        double ax_minus_b = -b[i];
        for (int j = 0; j < N; j++) {
            ax_minus_b += a[i][j] * x[j];
        }
        double abs_val = fabs(ax_minus_b);
        if (abs_val > norm) {
            norm = abs_val;
        }
    }
    return norm;
}

int main(void) {
    double a[N][N] = {
        {3.0, 2.0, -1.0},
        {2.0, -2.0, 4.0},
        {-1.0, 0.5, -1.0}
    };
    double b[N] = {1.0, -2.0, 0.0};
    double a_orig[N][N];
    double b_orig[N];
    double x[N];

    for (int i = 0; i < N; i++) {
        b_orig[i] = b[i];
        for (int j = 0; j < N; j++) {
            a_orig[i][j] = a[i][j];
        }
    }

    if (!lu_decompose(a, b)) {
        puts("LU failed: singular matrix");
        return 1;
    }

    lu_solve(a, b, x);
    printf("lu_solution = [%.1f, %.1f, %.1f]\n", x[0], x[1], x[2]);
    printf("residual_inf_norm = %.3e\n", residual_inf_norm(a_orig, x, b_orig));
    return 0;
}
