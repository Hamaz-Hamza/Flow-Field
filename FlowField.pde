
int scale = 10;
int rows, cols;
int numOfParticles = 5000;
int numOfVoidParticles = 10000;

PVector[] flowField, voidField;
Particle[] particles = new Particle[numOfParticles];

void setup() {
    size(1000, 600);
    background(0);
    
    cols = width/scale;
    rows = height/scale;
    
    flowField = new PVector[rows*cols];
    for(int i=0; i < numOfParticles; i++) particles[i] = new Particle(0);
}

void draw() {
    strokeWeight(1);
    int index = 0;
    float xNoiseCoord = 0, yNoiseCoord = 0;
    for(int y=0; y < rows; y++){
        xNoiseCoord = 0;
        for(int x=0; x < cols; x++){
            PVector v = PVector.fromAngle(noise(xNoiseCoord, yNoiseCoord, 0)*TWO_PI).setMag(0.1);
            flowField[index++] = v;
            xNoiseCoord += 0.1;
        }
        yNoiseCoord += 0.1;
    }
    
    for (Particle p : particles){
        p.update(flowField);
        p.draw();
    }
    
}   

void drawflowField(){
    strokeWeight(1);
    for(int y=0; y < rows; y++){
        for(int x=0; x < cols; x++){
            drawVector(flowField[x + y * cols],x*scale,y*scale);
        }
    }
}

void drawVector(PVector vector, int x, int y){
    push();
    int halfScale = scale/2;
    translate(x+halfScale,y+halfScale);
    rotate(vector.heading());
    line(-halfScale,0,halfScale,0);
    pop();
}
