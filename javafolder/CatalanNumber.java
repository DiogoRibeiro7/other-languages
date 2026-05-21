// Catalan number sequence using the classic recursive definition.
public class CatalanNumber {
    int catalan(int n) {
        int result = 0;

        if (n <= 1) {
            return 1;
        }
        for (int i = 0; i < n; i++) {
            result += catalan(i) * catalan(n - i - 1);
        }
        return result;
    }

    public static void main(String[] args) {
        CatalanNumber cn = new CatalanNumber();
        for (int i = 0; i < 15; i++) {
            System.out.print(cn.catalan(i) + " ");
        }
        System.out.println();
    }
}
