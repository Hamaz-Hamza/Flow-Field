class Particle {
    PVector pos = new PVector(random(width),random(height));
    PVector prevPos = pos;
    PVector vel = new PVector(0,0);
    PVector acc = new PVector(0,0);
    float gray;
    color c;
    
    Particle(int mode){
        if (mode == 0) gray = 250;
        else gray = 0;
        //if (mode == 0) c = color(250,0,0);
        //else c = color(0,0,250);
    }

    void update(PVector[] flowField)
    {
        prevPos = pos;
        int x = floor(pos.x/scale);
        int y = floor(pos.y/scale);
        acc = flowField[x + cols * y];
        vel = vel.add(acc);
        vel.limit(4);
        pos = pos.add(vel);
        if (pos.x >= width) pos.x = 0;
        if (pos.x < 0) pos.x = width-1;
        if (pos.y >= height) pos.y = 0;
        if (pos.y < 0) pos.y = height-1;
        if (pos.dist(prevPos) > 100) prevPos = pos;
    }
    
    void draw(){
        stroke(gray);
        strokeWeight(1);
        strokeWeight(0.2);
        line(prevPos.x,prevPos.y,pos.x,pos.y);
    }
}
