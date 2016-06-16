static class Airplane {
// Basic Physical
PVector position;
PVector velocity = new PVector();

// Airplane State
float rotation = 0; // Rotation in radians, Y up.
PVector heading;

// Control Sufaces
float rudder = 0, elevator = 0, aileron = 0; // Values -1 ~ +1
float thrust = 0;

float thrustMax = 4, thrustMin = -1;
boolean turbo = false;

// Aircraft params
Wing wings;
float weight;

PVector originalPosition, originalHeading;

public Airplane(PVector position, PVector heading, Wing wings, float weight){
    this.position = position;
    this.heading = heading;
    this.wings = wings;
    this.weight = weight;
    
    this.originalPosition=position.copy();
    this.originalHeading=heading.copy();
}

public void turbo(boolean b){
    this.turbo = b;
}


// Indivisual Forces
public PVector calculateThrust(){
    return heading.copy().setMag(thrust);
}
public PVector wingNormal(){
    //logger(this, perpendicularVector(heading, rotation));
    return perpendicularVector(heading, rotation);
}
public PVector wingParallel(){
    return perpendicularVector(heading, rotation + HALF_PI);
}

public PVector calculateWing(){
    return calculateLift().add(calculateDrag());
}

public PVector calculateDrag(){
    return wings.getDrag(velocity, getVelHeadAngle());
}

public PVector calculateLift(){
    return wings.getLift(getDirectedAirVelocity(), getAoA(), wingNormal());
}

public PVector calculateGravity(){
    return new PVector(0, weight, 0);
}

public float getDirectedAirSpeed(){

    return getDirectedAirVelocity().mag();
}

public PVector getDirectedAirVelocity(){
    // Airspeed that is parallel to the heading.
    PVector normal = wingParallel();
    // we project the velocity vector onto a plane that is normal to the wingspan.
    PVector velocityNormalProjection = normal.copy().mult(velocity.dot(normal)).div(normal.dot(normal)); // First project the velocity to the wingspan vector.

    return velocity.copy().sub(velocityNormalProjection); // And then subtract that from the velocity, leaving only the component actually on the plane.
}

public PVector projectToWingPerp(PVector p){
// Airspeed that is parallel to the heading.
    PVector x = heading.copy().normalize().mult(-1);
    PVector y = wingNormal().normalize().mult(-1);

    return new PVector(projectScalar(p, x), projectScalar(p, y)); // And then subtract that from the velocity, leaving only the component actually on the plane.

}

public float getVelHeadAngle(){
    float ang = acos(heading.dot(velocity) / (heading.mag() * velocity.mag()));

    if (Float.isNaN(ang)) return 0;

    if (heading.dot(velocity) > 0) return -ang;
    else return ang;
}

public float getAoA(){
    PVector normal = wingParallel();
    // we project the velocity vector onto a plane that is normal to the wingspan.
    PVector velocityNormalProjection = normal.copy().mult(velocity.dot(normal)).div(normal.dot(normal)); // First project the velocity to the wingspan vector.
    PVector velocityProjected = velocity.copy().sub(velocityNormalProjection); // And then subtract that from the velocity, leaving only the component actually on the plane.

    float ang = acos(heading.dot(velocityProjected) / (heading.mag() * velocityProjected.mag()));

    if (Float.isNaN(ang)) return 0;

    if (wingNormal().dot(velocityProjected) > 0) return -ang;
    else return ang;
}

// Calculate all forces and add to velocity
public void applyForces(float multiplier){
    velocity.add(calculateThrust().add(calculateWing()).add(calculateGravity()).mult(multiplier * multiplier));
}

public void repeat(Terrain t){
    position.x = mod(position.x, t.getRepeatGridSpacing());
    position.z = mod(position.z, t.getRepeatGridSpacing());
}


public void cameraSet(PGraphics p){
    PVector lookingAt = PVector.add(position, heading);
    PVector cameraDown = wingNormal().mult(-1);

    p.camera(position.x, position.y, position.z, lookingAt.x, lookingAt.y, lookingAt.z, cameraDown.x, cameraDown.y, cameraDown.z);
}

// Called once for redraw.
// Applys force, moves position, and sets the camera.
public void update(PGraphics p, int iterations, float timeFactor, Terrain t){
    for (int i = 0; i < iterations; i++) {
        applyForces(1.0 / iterations);
    }

    position.add(velocity.copy().mult(timeFactor));
    
    if (position.y > 0) {
      //logger(this,"collision with ground",velocity);
      if ((velocity.y) > 10) {
          logger(this,"Fatal collision.",velocity);
          dead=60;
          reset();
        }
        position.y = 0;
        velocity.y = 0;
        
    }
    

    //logger(this, position);

    p.pointLight(255, 255, 255, position.x, position.y, position.z);

    repeat(t);

    cameraSet(p);
} /* update */


// Controls
public void changeThrust(float f){
    thrust += f;
    if (!turbo && thrust > thrustMax) thrust = thrustMax;
    if (thrust < thrustMin) thrust = thrustMin;
}
public void setThrust(float f){
    thrust = f;
    if (!turbo && thrust > thrustMax) thrust = thrustMax;
    if (thrust < thrustMin) thrust = thrustMin;
}
public void changeRotation(float f){
    rotation += f;
}
public void changePitch(float f){
    PVector rotateAxis = wingParallel();

    heading = rotateVector(rotateAxis, heading, f);

}
public void changeYaw(float f){
    PVector rotateAxis = upVector;// wingNormal();

    heading = rotateVector(rotateAxis, heading, f);
}


// Getter
public Wing getWings(){
    return wings;
}
public float getPitch(){
    float dotProd = heading.dot(upVector);
    float absMult = heading.mag() * upVector.mag();

    return HALF_PI - acos(dotProd / absMult);
}
public float getYaw(){
    PVector groundProjection = heading.copy();

    groundProjection.z = 0;
    return atan2(groundProjection.x, groundProjection.y);
}
public float getRoll(){
    return rotation;
}
public PVector getVelocityCopy(){
    return velocity.copy();
}
public PVector getLocation(){
    return position;
}
public float getWeight(){
    return weight;
}

// Slider links.

public SliderDataSource getThrustSource(){
    return new SliderDataSource(){
               @Override
               public float getValue(){
                   return thrust;
               }
               @Override
               public float getMax(){
                   return thrustMax;
               }
               @Override
               public float getMin(){
                   return thrustMin;
               }

    };
}

public HudDataSource getAltitudeSource(){
    return new HudDataSource(){
               @Override
               public float getValue(){
                   return -position.y;
               }
               @Override
               public float getDisplayRange(){
                   return 500;
               }
               @Override
               public float getTickerSpacing(){
                   return 100;
               }
    };
}
public HudDataSource getSpeedSource(){
    return new HudDataSource(){
               @Override
               public float getValue(){
                   return getDirectedAirSpeed();
               }
               @Override
               public float getDisplayRange(){
                   return 50;
               }
               @Override
               public float getTickerSpacing(){
                   return 5;
               }
    };
}
// Utility
public void reset(){
    this.position=this.originalPosition;
    this.heading=originalHeading;
    this.rotation=0;
    this.velocity.mult(0);
    this.thrust=0;
}
}