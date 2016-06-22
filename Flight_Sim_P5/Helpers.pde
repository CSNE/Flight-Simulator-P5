static void logger(Object c, Object ... obj) {
  StringBuilder log = new StringBuilder();

  log.append("[From ");
  if (c != null) log.append(c.getClass().getSimpleName());
  else log.append("NULL");
  log.append("]");
  for (Object arg : obj) {
    log.append(" | ");
    try {
      log.append(arg.toString());
    }
    catch (NullPointerException e) {
      log.append("NULL");
    }
  }
  println(log.toString());
}

static final PVector upVector = new PVector(0, -1, 0);
static PVector perpendicularVector(PVector p) {
  return p.cross(upVector.cross(p));
}
static PVector perpendicularVector(PVector p, PVector closest) {
  return p.cross(closest.cross(p));
}
static PVector perpendicularVector(PVector p, float rotation) {
  return rotateVector(p, perpendicularVector(p), rotation);
}
static PVector rotateVector(PVector k1, PVector v, float theta) { // Rotate v around k1, by theta radians.
  PVector k = k1.copy().normalize();

  return v.copy().mult(cos(theta)).add(
    k.cross(v).mult(sin(theta))).add(
    k.copy().mult(k.dot(v)).mult(1 - cos(theta)));
}

static PVector project(PVector orig, PVector to) {
  return to.copy().mult(orig.dot(to) / to.dot(to));
}
static float projectScalar(PVector orig, PVector to) {
  return (orig.dot(to) / to.dot(to));
}

final static float sqrt3 = sqrt(3);
final static PVector triangle_p1 = new PVector(-sqrt3 / 6.0, -0.5);
final static PVector triangle_p2 = new PVector(-sqrt3 / 6.0, +0.5);
final static PVector triangle_p3 = new PVector(+sqrt3 / 3.0, 0);
static void drawArrow(PGraphics pg, PVector tail, PVector head, float strokeWeight, float arrowSize) {
  float len = tail.dist(head);
  float ang = -HALF_PI - atan2(tail.x - head.x, tail.y - head.y);
  PVector center = tail.copy().add(head).div(2);

  PVector triLoc = new PVector(len / 2.0, 0);
  PVector p1 = triangle_p1.copy().mult(arrowSize).add(triLoc);
  PVector p2 = triangle_p2.copy().mult(arrowSize).add(triLoc);
  PVector p3 = triangle_p3.copy().mult(arrowSize).add(triLoc);

  // pg.rectMode(CENTER);
  pg.pushMatrix();

  pg.translate(center.x, center.y);
  pg.rotate(ang);
  pg.rect(0, 0, len, strokeWeight);
  pg.triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
  pg.popMatrix();
  // logger(null, tail, head, center, len, ang, strokeWeight);
}

static void drawArrow(PGraphics pg, float tailX, float tailY, float headX, float headY, float strokeWeight, float arrowSize) {
  PVector tail = new PVector(tailX, tailY);
  PVector head = new PVector(headX, headY);

  drawArrow(pg, tail, head, strokeWeight, arrowSize);
}



static float mod(float x, float n) {
  float res = x % n;

  if (res < 0) return res + n;
  else return res;
}

static void drawPolygon(PGraphics pg, float radius, float offset, int sides) {
  pg.beginShape();
  for (int i = 0; i < sides; i++) {
    pg.vertex(cos(TWO_PI / sides * i + offset) * radius, sin(TWO_PI / sides * i + offset) * radius);
  }
  pg.endShape();
}