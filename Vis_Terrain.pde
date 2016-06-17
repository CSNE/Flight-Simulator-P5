static class Terrain {
Airplane ap;
public Terrain(Airplane ap){
    this.ap = ap;
}
int numCubes = 20; // times two.
static float cubeSpacing = 200;
float cubeSize = 10;
float groundOffset = 0;
public static PVector getCenterPoint(){
return new PVector(cubeSpacing/2,0,cubeSpacing/2);
}
public void drawTerrain(PGraphics pg){
    float x = ap.getLocation().x;
    float z = ap.getLocation().z;

    pg.fill(200, 255, 200);
    pg.noStroke();

    // Ground Plane
    pg.pushMatrix();
    pg.translate(x, cubeSize / 2 + groundOffset, z);
    pg.rotateX(HALF_PI);
    pg.rect(0, 0, numCubes * cubeSpacing * 2, numCubes * cubeSpacing * 2);
    pg.popMatrix();


    // Cubes
    pg.fill(255);
    pg.stroke(0);
    pg.pushMatrix();

    pg.translate((floor(x / cubeSpacing) - numCubes) * cubeSpacing, 0 + groundOffset, (floor(z / cubeSpacing) - numCubes) * cubeSpacing);
    for (int boxX = -numCubes; boxX <= numCubes; boxX++) {
        pg.translate(cubeSpacing, 0, 0);
        pg.pushMatrix();
        for (int boxY = -numCubes; boxY <= numCubes; boxY++) {
            pg.translate(0, 0, cubeSpacing);

            pg.box(cubeSize);
        }
        pg.popMatrix();
    }


    pg.popMatrix();

} /* drawTerrain */

public float getRepeatGridSpacing(){
    return cubeSpacing;
}

}