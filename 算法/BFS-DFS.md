# 深度优先搜索(Deep First Search) 广度优先搜索(Breath First Search)
```java
/**
 *    BFS 一般用队列辅助
 * Return the length of the shortest path between root and target node.
 */
int BFS(Node root, Node target) {
    Queue<Node> queue;  // store all nodes which are waiting to be processed
    Set<Node> used;     // store all the used nodes
    int step = 0;       // number of steps neeeded from root to current node
    // initialize
    add root to queue;
    add root to used;
    // BFS
    while (queue is not empty) {
        step = step + 1;
        // iterate the nodes which are already in the queue
        int size = queue.size();
        for (int i = 0; i < size; ++i) {
            Node cur = the first node in queue;
            return step if cur is target;
            for (Node next : the neighbors of cur) {
                if (next is not in used) {
                    add next to queue;
                    add next to used;
                }
            }
            remove the first node from queue;
        }
    }
    return -1;          // there is no path from root to target
}
/*
 * Return true if there is a path from cur to target.
 */
boolean DFS(int root, int target) {
    Set<Node> visited;
    Stack<Node> s;
    add root to s;
    while (s is not empty) {
        Node cur = the top element in s;
        return true if cur is target;
        for (Node next : the neighbors of cur) {
            if (next is not in visited) {
                add next to s;
                add next to visited;
            }
        }
        remove cur from s;
    }
    return false;
}
```
> LC 200. 岛屿数量
```java
// dfs 可以使用辅助数组表示访问过，也可以修改原数据
public int numIslands(char[][] grid) {
    int idx = 0;
    for (int i = 0; i < grid.length; i++) {
        for (int j = 0; j < grid[i].length; j++) {
            if (grid[i][j] == '1') {
                idx++;
                dfs(grid, i, j);
            }
        }
    }
    return idx;
}
private void dfs(char[][] grid, int row, int col) {
    int rowLen = grid.length;
    int colLen = grid[0].length;
    if (row < 0 || col < 0 || row >= rowLen || col >= colLen || grid[row][col] == '0') {
        return;
    }
    grid[row][col] = '0';
    dfs(grid, row - 1, col);
    dfs(grid, row + 1, col);
    dfs(grid, row, col - 1);
    dfs(grid, row, col + 1);
}
// bfs
public int numIslands(char[][] grid) {
    int idx = 0;
    Queue<List<Integer>> queue = new LinkedList<>();
    for (int i = 0; i < grid.length; i++) {
        for (int j = 0; j < grid[i].length; j++) {
            if (grid[i][j] == '1') {
                idx++;
                queue.add(Arrays.asList(i, j));
                while (queue.size() != 0) {
                    bfs(grid, queue);
                }
            }
        }
    }
    return idx;
}
private void bfs(char[][] grid, Queue<List<Integer>> queue) {
    List<Integer> item = queue.poll();
    int row = item.get(0);
    int col = item.get(1);
    int rowLen = grid.length;
    int colLen = grid[0].length;
    if (row < 0 || col < 0 || row >= rowLen || col >= colLen || grid[row][col] == '0') {
        return;
    }
    grid[row][col] = '0';
    queue.add(Arrays.asList(row - 1, col));
    queue.add(Arrays.asList(row + 1, col));
    queue.add(Arrays.asList(row, col - 1));
    queue.add(Arrays.asList(row, col + 1));
}
```
> LC 286. 墙和门
```java
public void wallsAndGates(int[][] rooms) {
    if(rooms == null || rooms.length == 0 || rooms[0].length == 0)
        return;
    int m = rooms.length;
    int n = rooms[0].length;
    boolean[][] visited = new boolean[m][n];
    for(int i = 0; i < m; i++) {
        for(int j = 0; j < n; j++){
            if(rooms[i][j] == 0){
                fill(rooms, i-1, j, 0, visited);
                fill(rooms, i, j+1, 0, visited);
                fill(rooms, i+1, j, 0, visited);
                fill(rooms, i, j-1, 0, visited);
                visited = new boolean[m][n];
            }
        }
    }
}
public void fill(int[][] rooms, int i, int j, int start, boolean[][] visited){
    int m=rooms.length;
    int n=rooms[0].length;
    if(i<0 || i>=m || j<0|| j>=n || rooms[i][j] <= 0 || visited[i][j]) {
        return;
    }
    rooms[i][j] = Math.min(rooms[i][j], start + 1);
    visited[i][j]=true;
    fill(rooms, i - 1, j, start + 1, visited);
    fill(rooms, i, j + 1, start + 1, visited);
    fill(rooms, i + 1, j, start + 1, visited);
    fill(rooms, i, j - 1, start + 1, visited);
    visited[i][j]=false;
}
// bfs
public void wallsAndGates(int[][] rooms) {
    if(rooms==null || rooms.length==0||rooms[0].length==0)
        return;
    int m = rooms.length;
    int n = rooms[0].length;
    LinkedList<Integer> queue = new LinkedList<Integer>();
    for(int i = 0; i < m; i++){
        for(int j = 0; j < n; j++){
            if(rooms[i][j] == 0){
                queue.add(i * n + j);
            }
        }
    }
    while(!queue.isEmpty()){
        int head = queue.poll();
        int x= head / n;
        int y= head % n;
        if(x > 0 && rooms[x-1][y] == Integer.MAX_VALUE){
            rooms[x-1][y] = rooms[x][y]+1;
            queue.add((x - 1) * n + y);
        }  
        if(x< m - 1 && rooms[x+1][y] == Integer.MAX_VALUE){
            rooms[x + 1][y] = rooms[x][y] + 1;
            queue.add((x + 1) * n + y);
        }  
        if(y > 0 && rooms[x][y - 1] == Integer.MAX_VALUE){
            rooms[x][y - 1] = rooms[x][y] + 1;
            queue.add(x * n + y- 1);
        }
        if(y < n - 1 && rooms[x][y + 1] == Integer.MAX_VALUE){
            rooms[x][y + 1] = rooms[x][y] + 1;
            queue.add(x * n + y + 1);
        }
    }
}　　
```
> LC 20. 有效的括号
```java
public boolean isValid(String s) {
    if(s.isEmpty())
            return true;
        Stack<Character> stack=new Stack<Character>();
        for(char c:s.toCharArray()){
            if(c=='(')
                stack.push(')');
            else if(c=='{')
                stack.push('}');
            else if(c=='[')
                stack.push(']');
            else if(stack.empty() || c!=stack.pop())
                return false;
        }
        if(stack.empty())
            return true;
        return false;
    }
```