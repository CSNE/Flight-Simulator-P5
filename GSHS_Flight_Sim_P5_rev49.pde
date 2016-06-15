// TODOs
// Clean log
// Graph labels
// Graph values
// Graph zeros
// UI
// Flaps
// Velocity flicker on ground fix
// Performance


PGraphics map, overlay;
PFont overlayFont;

Airplane ap;

GraphVisualizer liftGraph, dragGraph;
AirplaneBodyVisualizer abv;
AirplaneForcesVisualizer afv;

Terrain tr;

Slider testSlider;
Slider flapsSlider;

HUD altitudeHUD;
HUD speedHUD;

void setup(){
    size(1000, 750, P2D);

    frameRate(30);


    overlay = createGraphics(width, height);
    map = createGraphics(width, height, P3D);
    rectMode(CENTER);
    overlay.rectMode(CENTER);
    overlay.ellipseMode(CENTER);

    ap = AircraftFactory.testAirplane();

    liftGraph = new GraphVisualizer(ap.getWings().getLiftGraphSource(), 50, 200, 400, -150, "Lift");
    dragGraph = new GraphVisualizer(ap.getWings().getDragGraphSource(), 50, 400, 400, -150, "Drag");

    abv = new AirplaneBodyVisualizer(ap, new PVector(750, 200));

    afv = new AirplaneForcesVisualizer(ap, new PVector(600, 400));

    tr = new Terrain(ap);

    testSlider = new Slider(ap.getThrustSource(), 200, 600, 250, Slider.HORIZONTAL, Slider.CENTERED, "Thrust");
    flapsSlider = new Slider(ap.getWings().getFlapsSource(), 200, 700, 250, Slider.HORIZONTAL, Slider.CENTERED, "Flaps");

    altitudeHUD = new HUD(ap.getAltitudeSource(), 650, 500, 300, Slider.VERTICAL, Slider.CENTERED, "Altitude");
    speedHUD = new HUD(ap.getSpeedSource(), 850, 500, 300, Slider.VERTICAL, Slider.CENTERED, "Airspeed");

    map.perspective(PI / 3.0, width / height, 100, 100000);
} /* setup */

void draw(){
    map.beginDraw();
    map.rectMode(CENTER);
    // 3D Layer draw start

    ap.update(map, 30, 0.3, tr);

    map.background(100, 100, 200);

    map.ambientLight(50, 50, 50);
    // map.directionalLight(255,255,255,-1,1,-1);

    // spotLight(255,255,255,250,250,-1000,250,250,-1500,1,100);
    // spotLight(255, 255, 255, mouseX, mouseY, 1000, 0, 0, -1, PI/2, 600);
    map.fill(255);
    // stroke(150,150,150);

    tr.drawTerrain(map);
    // 3D Layer draw end
    map.endDraw();
    overlay.beginDraw();
    overlay.clear();
    overlay.rectMode(CENTER);
    overlay.textAlign(LEFT);
    // Overlay draw


    overlay.textSize(24);
    overlay.fill(255, 0, 0);
    // overlay.text("Lift Graph.", 50, 100);
    // overlay.text("Controls.", 750, 100);
    // overlay.text("Flight Info.", 750, 300);
    // overlay.text("Velocity & AoA", 50, 300);
    overlay.fill(255, 128);
    overlay.textSize(12);
    overlay.text("" + int(frameRate) + " FPS", 20, 20);
    /*
     * overlay.textSize(16);
     * overlay.fill(255);
     * overlay.text("Thrust: " + ap.thrust, 50, 500);
     * overlay.text("Speed: " + ap.velocity.mag(), 50, 530);
     * overlay.text("Altitude: " + (-ap.position.y), 50, 560);
     * overlay.text("Lift: " + ap.calculateLift().mag(), 50, 590);
     * overlay.text("Drag: " + ap.calculateDrag().mag(), 50, 620);
     * overlay.text("Weight: " + ap.getWeight(), 50, 650);
     * overlay.text("Flaps: " + ap.getWeight(), 50, 680);*/
    // overlay.text("Thrust: "+ap.thrust,50,400);
    liftGraph.drawGraph(overlay, ap.getAoA());
    dragGraph.drawGraph(overlay, ap.getVelHeadAngle());
    // overlay.fill(255);
    // overlay.noStroke();
    // drawArrow(overlay, new PVector(width/2,height/2), new PVector(mouseX,mouseY),10,40);
    abv.drawVisualization(overlay);
    // afv.drawVisualization(overlay);
    testSlider.drawSlider(overlay);
    flapsSlider.drawSlider(overlay);

    altitudeHUD.drawHUD(overlay);
    speedHUD.drawHUD(overlay);
    // Overlay draw end
    overlay.endDraw();
    image(map, 0, 0);
    image(overlay, 0, 0);
    keyAction();
} /* draw */