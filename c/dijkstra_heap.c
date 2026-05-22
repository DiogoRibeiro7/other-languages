/* dijkstra_heap.c
 * Dijkstra shortest paths with binary min-heap.
 */
#include <limits.h>
#include <stdio.h>

#define N 6
#define INF (INT_MAX / 4)

typedef struct {
    int to;
    int w;
} Edge;

typedef struct {
    Edge edges[8];
    int count;
} AdjList;

typedef struct {
    int node;
    int dist;
} HeapNode;

static AdjList g[N];
static HeapNode heap[64];
static int heap_size = 0;

static void add_edge(int u, int v, int w) {
    g[u].edges[g[u].count].to = v;
    g[u].edges[g[u].count].w = w;
    g[u].count++;
}

static void heap_push(int node, int dist) {
    int i = heap_size++;
    heap[i].node = node;
    heap[i].dist = dist;
    while (i > 0) {
        int p = (i - 1) / 2;
        if (heap[p].dist <= heap[i].dist) {
            break;
        }
        HeapNode tmp = heap[p];
        heap[p] = heap[i];
        heap[i] = tmp;
        i = p;
    }
}

static HeapNode heap_pop(void) {
    HeapNode top = heap[0];
    heap[0] = heap[--heap_size];
    int i = 0;
    while (1) {
        int l = 2 * i + 1;
        int r = l + 1;
        int s = i;
        if (l < heap_size && heap[l].dist < heap[s].dist) s = l;
        if (r < heap_size && heap[r].dist < heap[s].dist) s = r;
        if (s == i) break;
        HeapNode tmp = heap[i];
        heap[i] = heap[s];
        heap[s] = tmp;
        i = s;
    }
    return top;
}

static void dijkstra(int source, int dist[N]) {
    for (int i = 0; i < N; i++) dist[i] = INF;
    dist[source] = 0;
    heap_size = 0;
    heap_push(source, 0);

    while (heap_size > 0) {
        HeapNode cur = heap_pop();
        if (cur.dist != dist[cur.node]) continue;
        for (int i = 0; i < g[cur.node].count; i++) {
            int v = g[cur.node].edges[i].to;
            int nd = cur.dist + g[cur.node].edges[i].w;
            if (nd < dist[v]) {
                dist[v] = nd;
                heap_push(v, nd);
            }
        }
    }
}

int main(void) {
    add_edge(0, 1, 7);
    add_edge(0, 2, 9);
    add_edge(0, 5, 14);
    add_edge(1, 2, 10);
    add_edge(1, 3, 15);
    add_edge(2, 3, 11);
    add_edge(2, 5, 2);
    add_edge(3, 4, 6);
    add_edge(4, 5, 9);

    add_edge(1, 0, 7);
    add_edge(2, 0, 9);
    add_edge(5, 0, 14);
    add_edge(2, 1, 10);
    add_edge(3, 1, 15);
    add_edge(3, 2, 11);
    add_edge(5, 2, 2);
    add_edge(4, 3, 6);
    add_edge(5, 4, 9);

    int dist[N];
    dijkstra(0, dist);
    printf("dijkstra_dist = [%d,%d,%d,%d,%d,%d]\n", dist[0], dist[1], dist[2], dist[3], dist[4], dist[5]);
    return 0;
}
