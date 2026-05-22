/* floyd_warshall.c
 * All-pairs shortest paths via Floyd-Warshall.
 */
#include <stdio.h>

#define N 4
#define INF 1000000000

int main(void) {
    int d[N][N] = {
        {0,   5,  INF, 10},
        {INF, 0,   3,  INF},
        {INF, INF, 0,   1},
        {INF, INF, INF, 0}
    };

    for (int k = 0; k < N; k++) {
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                if (d[i][k] < INF && d[k][j] < INF && d[i][k] + d[k][j] < d[i][j]) {
                    d[i][j] = d[i][k] + d[k][j];
                }
            }
        }
    }

    printf("floyd_row0 = [%d,%d,%d,%d]\n", d[0][0], d[0][1], d[0][2], d[0][3]);
    printf("floyd_row1 = [%d,%d,%d,%d]\n", d[1][0], d[1][1], d[1][2], d[1][3]);
    return 0;
}
