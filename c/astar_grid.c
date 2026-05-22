/* astar_grid.c
 * A* shortest path on a small grid with Manhattan heuristic.
 */
#include <stdio.h>
#include <stdlib.h>

#define R 5
#define C 6
#define N (R * C)
#define INF 1000000000

typedef struct {
    int node, f;
} HeapNode;

static int grid[R][C] = {
    {0, 0, 0, 1, 0, 0},
    {1, 1, 0, 1, 0, 1},
    {0, 0, 0, 0, 0, 0},
    {0, 1, 1, 1, 1, 0},
    {0, 0, 0, 0, 0, 0}
};

static HeapNode heap[256];
static int hs = 0;

static int node_id(int r, int c) { return r * C + c; }
static int row_of(int id) { return id / C; }
static int col_of(int id) { return id % C; }

static int heuristic(int a, int b) {
    int dr = abs(row_of(a) - row_of(b));
    int dc = abs(col_of(a) - col_of(b));
    return dr + dc;
}

static void push(int node, int f) {
    int i = hs++;
    heap[i].node = node;
    heap[i].f = f;
    while (i > 0) {
        int p = (i - 1) / 2;
        if (heap[p].f <= heap[i].f) break;
        HeapNode t = heap[p]; heap[p] = heap[i]; heap[i] = t;
        i = p;
    }
}

static HeapNode pop(void) {
    HeapNode top = heap[0];
    heap[0] = heap[--hs];
    int i = 0;
    while (1) {
        int l = 2 * i + 1, r = l + 1, s = i;
        if (l < hs && heap[l].f < heap[s].f) s = l;
        if (r < hs && heap[r].f < heap[s].f) s = r;
        if (s == i) break;
        HeapNode t = heap[i]; heap[i] = heap[s]; heap[s] = t;
        i = s;
    }
    return top;
}

int main(void) {
    int start = node_id(0, 0), goal = node_id(4, 5);
    int gscore[N], closed[N];
    for (int i = 0; i < N; i++) {
        gscore[i] = INF;
        closed[i] = 0;
    }
    gscore[start] = 0;
    hs = 0;
    push(start, heuristic(start, goal));

    int dr[4] = {-1, 1, 0, 0};
    int dc[4] = {0, 0, -1, 1};

    while (hs > 0) {
        HeapNode cur = pop();
        int u = cur.node;
        if (closed[u]) continue;
        closed[u] = 1;
        if (u == goal) break;
        int ur = row_of(u), uc = col_of(u);

        for (int k = 0; k < 4; k++) {
            int vr = ur + dr[k], vc = uc + dc[k];
            if (vr < 0 || vr >= R || vc < 0 || vc >= C) continue;
            if (grid[vr][vc] == 1) continue;
            int v = node_id(vr, vc);
            if (closed[v]) continue;
            int ng = gscore[u] + 1;
            if (ng < gscore[v]) {
                gscore[v] = ng;
                push(v, ng + heuristic(v, goal));
            }
        }
    }

    printf("astar_path_cost = %d\n", gscore[goal]);
    return 0;
}
