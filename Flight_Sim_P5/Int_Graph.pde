static class Graph {
  // the vertices MUST be sorted.
  ArrayList<PVector> vertices = new ArrayList<PVector>();

  public Graph() {
  }

  public void addVertex(float x, float y) {
    PVector toBeAdded = new PVector(x, y);

    if (vertices.size() < 1) {
      vertices.add(toBeAdded);
      return;
    }
    if (x < vertices.get(0).x) {
      vertices.add(0, toBeAdded);
      return;
    }

    if (x >= vertices.get(vertices.size() - 1).x) {
      vertices.add(toBeAdded);
      return;
    }

    for (int i = 0; i < vertices.size() - 1; i++) {
      if ((x >= vertices.get(i).x) && (x < vertices.get(i + 1).x)) {
        vertices.add(i + 1, toBeAdded);
        return;
      }
    }

    println("ERR: Graph:addVertex() not added.");
  } /* addVertex */
  public float getValueAt(float x) {

    if (x < vertices.get(0).x) return vertices.get(0).y;

    if (x >= vertices.get(vertices.size() - 1).x) return vertices.get(vertices.size() - 1).y;

    for (int i = 0; i < vertices.size() - 1; i++) {
      // println("x="+x+" i="+i+" : "+vertices.get(i).x+" ~ "+vertices.get(i+1).x);
      if ((x >= vertices.get(i).x) && (x < vertices.get(i + 1).x)) {
        return map(x, vertices.get(i).x, vertices.get(i + 1).x, vertices.get(i).y, vertices.get(i + 1).y);
      }
    }

    println("ERR: Graph:getValueAt() no return.");
    return 0;// Float.NaN;
  }
}