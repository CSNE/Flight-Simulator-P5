static class AircraftFactory {

public static Airplane testAirplane(){
    Airplane res = new Airplane(new PVector(0, 0, 0), new PVector(1, 0, -1).normalize(), testWing(), 15);

    return res;
}

public static Wing testWing(){
    Wing res = new Wing(testLiftMixed(), testDragMixed());

    return res;
}
public static MixedGraph testLiftMixed(){
    return new MixedGraph(testLiftGraph(), testLiftGraphFlaps());
}
public static MixedGraph testDragMixed(){
    return new MixedGraph(testDragGraph(), testDragGraphFlaps());
}
public static Graph testLiftGraphFlaps(){
    Graph res = new Graph();

    res.addVertex(radians(-30), -0.03);
    res.addVertex(radians(-10), 0);
    res.addVertex(radians(20), 0.05);
    res.addVertex(radians(40), 0.02);
    res.addVertex(radians(90), 0);
    return res;

}
public static Graph testLiftGraph(){
    Graph res = new Graph();

    res.addVertex(radians(-30), -0.03);
    res.addVertex(radians(-10), 0);
    res.addVertex(radians(20), 0.007);
    res.addVertex(radians(40), 0.003);
    res.addVertex(radians(90), 0);
    return res;

}
public static Graph testDragGraph(){
    Graph res = new Graph();

    res.addVertex(radians(-90), 0.0400);
    res.addVertex(radians(-50), 0.0100);
    res.addVertex(radians(-30), 0.0020);
    res.addVertex(0, 0.0005);
    res.addVertex(radians(30), 0.0020);
    res.addVertex(radians(50), 0.0100);
    res.addVertex(radians(90), 0.0400);
    return res;

}
public static Graph testDragGraphFlaps(){
    Graph res = new Graph();

    res.addVertex(radians(-90), 0.0400);
    res.addVertex(radians(-50), 0.0100);
    res.addVertex(radians(-30), 0.0050);
    res.addVertex(0, 0.0030);
    res.addVertex(radians(30), 0.0050);
    res.addVertex(radians(50), 0.0100);
    res.addVertex(radians(90), 0.0400);
    return res;

}
}