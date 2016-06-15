static class AirplaneBodyVisualizer {
Airplane ap;
PVector location;
public AirplaneBodyVisualizer(Airplane ap, PVector location){
    this.ap = ap;
    this.location = location;
}

public void drawVisualization(PGraphics pg){
    // Drawing parameters, calculated
    float pitch = ap.getPitch();
    float yaw = ap.getYaw();
    float roll = ap.getRoll();
    float frontAirSpeed = ap.getDirectedAirSpeed();
    float aoA = ap.getAoA();

    // Sideways

    // Aircraft body
    pg.noStroke();
    pg.fill(255);
    pg.pushMatrix();
    pg.translate(location.x - 100, location.y);
    pg.rotate(pitch);
    // pg.rect(0, 0, 100, 20);
    pg.beginShape();
    pg.vertex(-60, 10);
    pg.vertex(-65, 8);
    pg.vertex(-67, 3);
    pg.vertex(-65, -3);
    pg.vertex(-60, -10);
    pg.vertex(-40, -15);
    pg.vertex(0, -10);
    pg.vertex(70, 10);

    pg.endShape();
    pg.rotate(-aoA);
    pg.fill(255, 100, 255);
    drawArrow(pg, new PVector(0, 0), new PVector(-2 * frontAirSpeed, 0), 10, 20);
    pg.popMatrix();

    float forceMult = 5;
    pg.pushMatrix();
    pg.translate(location.x - 100, location.y);
    pg.fill(255);
    pg.noStroke();
    pg.ellipse(0, 0, 10, 10);
    PVector thrust = ap.projectToWingPerp(ap.calculateThrust()).mult(forceMult);
// logger(this,thrust);
    PVector gravity = ap.projectToWingPerp(ap.calculateGravity()).mult(forceMult);
    PVector lift = ap.projectToWingPerp(ap.calculateLift()).mult(forceMult);
    PVector drag = ap.projectToWingPerp(ap.calculateDrag()).mult(forceMult);

    pg.rotate(ap.getPitch());

    pg.fill(100, 100, 255);
    drawArrow(pg, 0, 0, thrust.x, thrust.y, 5, 10);
    pg.fill(100, 100, 100);
    drawArrow(pg, 0, 0, gravity.x, gravity.y, 5, 10);
    pg.fill(100, 255, 100);
    drawArrow(pg, 0, 0, lift.x, lift.y, 5, 10);
    pg.fill(255, 100, 100);
    drawArrow(pg, 0, 0, drag.x, drag.y, 5, 10);
    pg.popMatrix();


    PVector velXZProj = groundProject(ap.velocity);
    PVector headXZProj = groundProject(ap.heading);
    float headAng = headXZProj.heading();

    pg.pushMatrix();
    pg.translate(location.x + 100, location.y);
    pg.noStroke();
    pg.fill(255);
    pg.rotate(headAng);
    pg.beginShape();
    pg.vertex(-30, 30);
    pg.vertex(-30, -30);
    pg.vertex(50, 0);
    pg.endShape();
    pg.rotate(-headAng);
    pg.fill(255, 100, 100);
    drawArrow(pg, new PVector(0, 0), velXZProj.mult(2), 5, 20);


    pg.popMatrix();

    //

    // Back



} /* drawVisualization */
private PVector groundProject(PVector p){
    PVector res = p.copy();

    res.y = res.z;
    res.z = 0;
    return res;
}
}