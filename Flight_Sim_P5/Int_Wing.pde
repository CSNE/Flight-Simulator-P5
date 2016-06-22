static class Wing {
  // Wing params
  Graph liftGraph;
  Graph dragGraph;

  MixedGraph liftMix;
  MixedGraph dragMix;

  float flaps = 1.0;

  public void changeFlaps(float f) {
    flaps += f;
    if (flaps < 0) flaps = 0;
    if (flaps > 1) flaps = 1;
    liftGraph = liftMix.getMix(flaps);
    dragGraph = dragMix.getMix(flaps);
  }

  public Wing(MixedGraph lift, MixedGraph drag) {
    this.liftMix = lift;
    this.dragMix = drag;
    changeFlaps(0);
  }

  // Constants for calculating lift
  static final float airDensity = 1.0;
  /*
 * public PVector getAcceleration(PVector velocity, float aoA, PVector wingNormal){
   *
   *  return getLift(velocity,  aoA,  wingNormal).add(getDrag(velocity,  aoA,  wingNormal));
   * }*/

  public PVector getDrag(PVector velocity, float aoA) {

    float vel = velocity.mag();
    float vel2 = vel * vel;

    float dragCoefficient = dragGraph.getValueAt(aoA);

    float dragAbs = vel2 * dragCoefficient;

    PVector drag = velocity.copy().setMag(dragAbs).mult(-1);

    return drag;
  }

  public PVector getLift(PVector velocity, float aoA, PVector wingNormal) {

    float vel = velocity.mag();
    float vel2 = vel * vel;

    float liftCoefficient = liftGraph.getValueAt(aoA);


    float liftAbs = vel2 * liftCoefficient;


    PVector lift = perpendicularVector(velocity, wingNormal).copy().setMag(liftAbs); // copy unnessasary


    return lift;
  }

  // getters
  public Graph getLiftGraph() {
    return liftGraph;
  }
  public Graph getDragGraph() {
    return dragGraph;
  }
  public SliderDataSource getFlapsSource() {
    return new SliderDataSource() {
      public float getValue() {
        return flaps;
      }
      public float getMax() {
        return 1;
      }
      public float getMin() {
        return 0;
      }
    };
  }

  // Hasty implementation
  // But eh, whatever.
  public GraphSource getLiftGraphSource() {
    return new GraphSource() {
      public Graph getGraph() {
        return liftGraph;
      }
      public float getXMin() {
        return radians(-30);
      }
      public float getXMax() {
        return HALF_PI;
      }
      public float getYMin() {
        return -0.03;
      }
      public float getYMax() {
        return 0.05;
      }
    };
  }
  public GraphSource getDragGraphSource() {
    return new GraphSource() {
      public Graph getGraph() {
        return dragGraph;
      }
      public float getXMin() {
        return -HALF_PI;
      }
      public float getXMax() {
        return HALF_PI;
      }
      public float getYMin() {
        return 0;
      }
      public float getYMax() {
        return 0.0400;
      }
    };
  }
}