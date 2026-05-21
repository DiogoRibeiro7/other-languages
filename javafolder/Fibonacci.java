// Fibonacci number using matrix exponentiation.
public class Fibonacci {
    static int fib(int n) {
        int[][] matrix = new int[][]{{1, 1}, {1, 0}};
        if (n == 0) {
            return 0;
        }
        power(matrix, n - 1);
        return matrix[0][0];
    }

    static void multiply(int[][] f, int[][] m) {
        int x = f[0][0] * m[0][0] + f[0][1] * m[1][0];
        int y = f[0][0] * m[0][1] + f[0][1] * m[1][1];
        int z = f[1][0] * m[0][0] + f[1][1] * m[1][0];
        int w = f[1][0] * m[0][1] + f[1][1] * m[1][1];

        f[0][0] = x;
        f[0][1] = y;
        f[1][0] = z;
        f[1][1] = w;
    }

    static void power(int[][] f, int n) {
        int[][] m = new int[][]{{1, 1}, {1, 0}};
        for (int i = 2; i <= n; i++) {
            multiply(f, m);
        }
    }

    public static void main(String[] args) {
        int n = 15;
        System.out.println(fib(n));
    }
}
