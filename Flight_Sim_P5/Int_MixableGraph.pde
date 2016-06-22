static class MixedGraph {
  // two graphs MUST have the same number of points, all sorted, difffering only in Y values.

  Graph g1, g2;
  float mixRatio;
  public MixedGraph(Graph g1, Graph g2) {
    this.g1 = g1;
    this.g2 = g2;
  }
  public Graph getMix(float mixRatio) {
    Graph res = new Graph();

    for (int i = 0; i < g1.vertices.size(); i++) {
      res.addVertex(g1.vertices.get(i).x, g1.vertices.get(i).y * (1 - mixRatio) + g2.vertices.get(i).y * mixRatio);
    }
    return res;
  }
}