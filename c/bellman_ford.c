/* bellman_ford.c
 * Bellman-Ford shortest paths with negative cycle detection.
 */
#include <limits.h>
#include <stdio.h>

#define N 5
#define E 10
#define INF 1000000000

typedef struct {
    int u, v, w;
} Edge;

static const Edge edges[E] = {
    {0, 1, 6}, {0, 3, 7}, {1, 2, 5}, {1, 3, 8}, {1, 4, -4},
    {2, 1, -2}, {3, 2, -3}, {3, 4, 9}, {4, 0, 2}, {4, 2, 7}
};

int main(void) {
    int dist[N];
    for (int i = 0; i < N; i++) dist[i] = INF;
    dist[0] = 0;

    for (int i = 0; i < N - 1; i++) {
        int changed = 0;
        for (int j = 0; j < E; j++) {
            int u = edges[j].u, v = edges[j].v, w = edges[j].w;
            if (dist[u] < INF && dist[u] + w < dist[v]) {
                dist[v] = dist[u] + w;
                changed = 1;
            }
        }
        if (!changed) break;
    }

    int neg_cycle = 0;
    for (int j = 0; j < E; j++) {
        int u = edges[j].u, v = edges[j].v, w = edges[j].w;
        if (dist[u] < INF && dist[u] + w < dist[v]) neg_cycle = 1;
    }

    printf("bellman_ford_dist = [%d,%d,%d,%d,%d]\n", dist[0], dist[1], dist[2], dist[3], dist[4]);
    printf("bellman_ford_neg_cycle = %d\n", neg_cycle);
    return 0;
}
