//bubble chamber


void particle(int depth, int halfLife, float direction, float twistRate){ //recurssion depth (how many times can it split), number of steps in the trail, initial direction, curly-ness of trail
  if(depth > 0){ //if we are not at the last recussion depth
    pushMatrix(); //start moving things around
    rotate(radians(direction)); //apply the initial rotation
    for(int t = 0; t < halfLife; t++){
      translate(0, 1); //take a step forward
      rotate(radians(twistRate)); //turn according to the twist rate
      twistRate = twistRate * 1.001; //become more curly
      if(random(1) > 0.25){ //3 in 4 chance of drawing a point, makes the trails look bubbly 
        point(0, 0); //draw the point (only one in the whole program)
      }
    }
    if(random(1) > 0.5){ //1 in 2 chance of splitting into 2 new particles at the end of a trace
      particle(depth - 1, halfLife / int(random(1, 2)), random(-5, 5), random(-1));
      particle(depth - 1, halfLife / int(random(1, 2)), random(-5, 5), random(1));
    }
    popMatrix(); //put everything back where you started
  }
}

//fire the particles
void fire(){
  background(0, 0, 0, 100); //black background
  strokeWeight(1.5); //thicker lines
  stroke(0, 0, 100, 60); //looks nice
  for(int i = 0; i < 8; i ++){ //fire 8 big particles
    pushMatrix(); //We're in
    translate(width/2, 0);
    particle(3, int(random(500)), random(-5, 5), random(-0.1, 0.1)); //up to 2 splits (n-1), long traces, +/-5 degree spread, low twist rate
    popMatrix(); //I need an exit!
  }
  
  strokeWeight(1); //smaller traces
  stroke(0, 0, 70, 40);
  for(int i = 0; i < 90; i ++){ //fire some background particles
    pushMatrix();
    translate(random(width), random(height));
    particle(1, int(random(50)), random(360), random(-20, 20)); //no splits, short traces, +/-20 degree spread, extwa twisty
    popMatrix();
  }
}

void mousePressed(){ //garbage code I use all the time for re-running programs and saving images
  if(mouseButton == LEFT){
    fire();
  } else if(mouseButton == RIGHT){
    String fname = year() + "-" + month() + "-" + day() + "_" + hour() + ":" + minute() + ":" + second() + ".png";
    save(fname);
    println(fname);
  }
}

void setup(){
  size(640, 640);
  colorMode(HSB, 360, 100, 100, 100);
  fire();
}

void draw(){
}
