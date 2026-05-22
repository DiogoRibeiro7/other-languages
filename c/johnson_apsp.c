/* johnson_apsp.c
 * Johnson's algorithm: Bellman-Ford reweight + repeated Dijkstra.
 */
#include <stdio.h>

#define N 5
#define E 10
#define INF 1000000000

typedef struct { int u, v, w; } Edge;
typedef struct { int to, w; } Adj;
typedef struct { int node, d; } HeapNode;

static const Edge edges[E] = {
    {0, 1, 6}, {0, 3, 7}, {1, 2, 5}, {1, 3, 8}, {1, 4, -4},
    {2, 1, -2}, {3, 2, -3}, {3, 4, 9}, {4, 0, 2}, {4, 2, 7}
};

static Adj adj[N][E];
static int deg[N];
static HeapNode heap[256];
static int hs;

static void add_adj(int u, int v, int w) {
    adj[u][deg[u]].to = v;
    adj[u][deg[u]].w = w;
    deg[u]++;
}

static void heap_push(int node, int d) {
    int i = hs++;
    heap[i].node = node;
    heap[i].d = d;
    while (i > 0) {
        int p = (i - 1) / 2;
        if (heap[p].d <= heap[i].d) break;
        HeapNode t = heap[p]; heap[p] = heap[i]; heap[i] = t;
        i = p;
    }
}

static HeapNode heap_pop(void) {
    HeapNode top = heap[0];
    heap[0] = heap[--hs];
    int i = 0;
    while (1) {
        int l = 2 * i + 1, r = l + 1, s = i;
        if (l < hs && heap[l].d < heap[s].d) s = l;
        if (r < hs && heap[r].d < heap[s].d) s = r;
        if (s == i) break;
        HeapNode t = heap[i]; heap[i] = heap[s]; heap[s] = t;
        i = s;
    }
    return top;
}

static int bellman_ford_potential(int h[N]) {
    for (int i = 0; i < N; i++) h[i] = 0;
    for (int it = 0; it < N - 1; it++) {
        int changed = 0;
        for (int j = 0; j < E; j++) {
            int u = edges[j].u, v = edges[j].v, w = edges[j].w;
            if (h[u] + w < h[v]) {
                h[v] = h[u] + w;
                changed = 1;
            }
        }
        if (!changed) break;
    }
    for (int j = 0; j < E; j++) {
        int u = edges[j].u, v = edges[j].v, w = edges[j].w;
        if (h[u] + w < h[v]) return 0;
    }
    return 1;
}

static void dijkstra(int src, int h[N], int out[N]) {
    int dist[N];
    for (int i = 0; i < N; i++) dist[i] = INF;
    dist[src] = 0;
    hs = 0;
    heap_push(src, 0);
    while (hs > 0) {
        HeapNode cur = heap_pop();
        int u = cur.node;
        if (cur.d != dist[u]) continue;
        for (int i = 0; i < deg[u]; i++) {
            int v = adj[u][i].to;
            int rw = adj[u][i].w + h[u] - h[v];
            int nd = cur.d + rw;
            if (nd < dist[v]) {
                dist[v] = nd;
                heap_push(v, nd);
            }
        }
    }
    for (int v = 0; v < N; v++) {
        out[v] = (dist[v] >= INF / 2) ? INF : dist[v] - h[src] + h[v];
    }
}

int main(void) {
    for (int i = 0; i < N; i++) deg[i] = 0;
    for (int i = 0; i < E; i++) add_adj(edges[i].u, edges[i].v, edges[i].w);

    int h[N];
    if (!bellman_ford_potential(h)) {
        puts("johnson_neg_cycle = 1");
        return 0;
    }

    int all[N][N];
    for (int s = 0; s < N; s++) dijkstra(s, h, all[s]);

    printf("johnson_row0 = [%d,%d,%d,%d,%d]\n", all[0][0], all[0][1], all[0][2], all[0][3], all[0][4]);
    printf("johnson_row1 = [%d,%d,%d,%d,%d]\n", all[1][0], all[1][1], all[1][2], all[1][3], all[1][4]);
    printf("johnson_row3 = [%d,%d,%d,%d,%d]\n", all[3][0], all[3][1], all[3][2], all[3][3], all[3][4]);
    printf("johnson_neg_cycle = 0\n");
    return 0;
}
