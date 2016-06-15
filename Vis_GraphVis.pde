static class GraphVisualizer {
GraphSource mg;
PointsTransformer pt;
float x,  y,  xSize,  ySize;
String name;

boolean zeroLine = true;
boolean yZeroLine = true;
boolean displayValue = true;

public GraphVisualizer(GraphSource w, float x, float y, float xSize, float ySize, String name){
    this.mg = w;
    this.x = x;
    this.y = y;
    this.xSize = xSize;
    this.ySize = ySize;
    this.pt = new PointsTransformer(x, y, xSize, ySize, w);

    this.name = name;
}


public void drawGraph(PGraphics pg, float current){
    Graph g = mg.getGraph();

    // Current
    pg.stroke(255, 0, 0);

    float val = g.getValueAt(current);
    PVector p1 = pt.fromGraphSpaceToDrawSpace(new PVector(current, val));
    pg.line(p1.x, p1.y, p1.x, y);



    // ZeroLine
    pg.strokeWeight(1);
    pg.stroke(255, 100);
    pg.noFill();
    PVector origin = pt.fromGraphSpaceToDrawSpace(new PVector(0, 0));

    if (zeroLine) {
        pg.line(origin.x, y + ySize, origin.x, y);
    }
    if (yZeroLine) {
        pg.line(x, origin.y, x + xSize, origin.y);
    }



    // Graph
    // pg.alpha(255);
    pg.strokeWeight(3);
    pg.stroke(255, 255);
    pg.beginShape();
    PVector drawVec;
    for (PVector p:g.vertices) {
        drawVec = pt.fromGraphSpaceToDrawSpace(p);
        pg.vertex(drawVec.x, drawVec.y);
    }
    pg.endShape();

    // Current numerical display
    pg.noStroke();
    pg.fill(255, 0, 0);
    pg.textSize(16);
    pg.text("" + nfp(val * 10000, 3, 1), p1.x, y - 10);

    // Axes
    pg.noStroke();
    pg.fill(255);
    // Y Axis
    drawArrow(pg, x, y, x, y + ySize, 5, 10);
    // X Axis
    drawArrow(pg, x, y, x + xSize, y, 5, 10);

    pg.textSize(16);
    pg.textAlign(LEFT);
    pg.text(name, x, y + 16);

} /* drawGraph */
}

// Transformers!
// More than meets the eye....
// idk
static class PointsTransformer {
float graphXMin, graphXMax, graphYMin, graphYMax;
float drawXMin, drawXMax, drawYMin, drawYMax;

boolean yZeroLine = true;
public PointsTransformer(float drawX, float drawY, float xSize, float ySize, GraphSource gs){
    this.drawXMin = drawX;
    this.drawXMax = drawX + xSize;

    this.drawYMin = drawY;
    this.drawYMax = drawY + ySize;

    this.graphXMin = gs.getXMin();
    this.graphXMax = gs.getXMax();

    this.graphYMin = gs.getYMin();
    this.graphYMax = gs.getYMax();


}

public PVector fromGraphSpaceToDrawSpace(PVector p){
    return new PVector(map(p.x, graphXMin, graphXMax, drawXMin, drawXMax),
                       map(p.y, graphYMin, graphYMax, drawYMin, drawYMax));
}
public PVector fromDrawSpaceToGraphSpace(PVector p){
    return new PVector(map(p.x, drawXMin, drawXMax, graphXMin, graphXMax),
                       map(p.y, drawYMin, drawYMax, graphYMin, graphYMax));
}
}


public interface GraphSource {
Graph getGraph();
float getYMin();
float getYMax();
float getXMin();
float getXMax();
}