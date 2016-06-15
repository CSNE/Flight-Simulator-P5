static class AirplaneForcesVisualizer {
Airplane ap;
PVector location;
public AirplaneForcesVisualizer(Airplane ap, PVector location){
    this.ap = ap;
    this.location = location;
}
public void drawVisualization(PGraphics pg){
    float forceMult = 5;

    pg.pushMatrix();
    pg.translate(location.x, location.y);
    pg.fill(255);
    pg.noStroke();
    pg.ellipse(0, 0, 10, 10);
    PVector thrust = ap.projectToWingPerp(ap.calculateThrust()).mult(forceMult);
// logger(this,thrust);
    PVector gravity = ap.projectToWingPerp(ap.calculateGravity()).mult(forceMult);
    PVector lift = ap.projectToWingPerp(ap.calculateLift()).mult(forceMult);
    PVector drag = ap.projectToWingPerp(ap.calculateDrag()).mult(forceMult);

    pg.rotate(-ap.getPitch());

    pg.fill(100, 100, 255);
    drawArrow(pg, 0, 0, thrust.x, thrust.y, 5, 10);
    pg.fill(100, 100, 100);
    drawArrow(pg, 0, 0, gravity.x, gravity.y, 5, 10);
    pg.fill(100, 255, 100);
    drawArrow(pg, 0, 0, lift.x, lift.y, 5, 10);
    pg.fill(255, 100, 100);
    drawArrow(pg, 0, 0, drag.x, drag.y, 5, 10);
    pg.popMatrix();

} /* drawVisualization */
}