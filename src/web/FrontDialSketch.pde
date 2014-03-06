Gear b2, b1, c1, c2, d1, d2, e2, e5,
e6, e1, b3, l1, l2, m1, m2, n1, n2, n3,
p1, p2, q1, o1, m3, e3, e4, f1, f2, g1, g2,
h1, h2, i1, b0, ma1;
GearK1 k1;
GearK2 k2;
Integer[][] graph = new Integer[36][36];
boolean[] visited = new boolean[36];
Gear[]  gears = new Gear[36];
float rad = 0;
boolean lunisolar = false;
boolean lunar = false;
boolean eclipse = false;
boolean backDial = false;
boolean moonPhase = false;
boolean allGears = false;


/**
 * get distance between the lowest point of pin and the fist point of base of slot
 * 
 * 
 * @param point1 coordinates of slot's point
 * @param point3 coordinates of pin's point
 * @return distance between two points
 */
 float calculateDistance(float[] point1, float[] point3) {
    float[] p1 = point1;
    float xa1 = p1[0];
    float ya1 = p1[1]; 
    float[] p3 = point3;
    float xa3 = p3[0];
    float ya3 = p3[1];
    return (float)Math.sqrt(Math.pow((xa3 - xa1),2) + Math.pow((ya3 - ya1), 2));
}

/**
 * Checks if gear moves another gear acoordingly to which is gear one and which is gear two
 * 
 * @param node number of gear which moves another gear  
 * @param movedBy number of gear 
 */
void cases(int node, int movedBy, float variation) {
    GearK2 gk2;
    GearK1 gk1;
    float distance;
    switch(node) {
        case 24 :
            gk2 = (GearK2) gears[node];
            gk1 = (GearK1) gears[movedBy];
            // distance between pin's and slot's point
            distance = calculateDistance(gk2.getPoint1(), gk1.getPointOfPin(gk2));
            if(distance <= gk2.getSlot().getSideB() / 2) 
                gk2.checkK2(gk1, gk2, 100 * variation);
            else 
                gk2.checkK2(gk1, gk2, 20 * variation);
            // move slot accordingly to gear K2
            gk2.getSlot().moveSlot(gk2);
            popMatrix();
            popMatrix();
            // move pin acoordingly to gear K1
            gk1.getPin().movePin(gk1);
            break;
        case 27: case 31:
            gk2 = (GearK2) gears[24];
            gk1 = (GearK1) gears[20];
            // distance between pin's and slot's point
            distance = calculateDistance(gk2.getPoint1(), gk1.getPointOfPin(gk2));
            if(distance <= gk2.getSlot().getSideB() / 2)
                gears[node].checkMove(gears[movedBy], gears[node], "right", 100 * variation);
            else
                gears[node].checkMove(gears[movedBy], gears[node], "right", 20 * variation);       
            break;  
        case 33 : 
            gears[node].checkMove(gears[movedBy], gears[node], "right", 10 * variation);
            break;
        default :
            gears[node].checkMove(gears[movedBy], gears[node], "right", 10 * variation);
            break;
    }
    
}

void startMechanism() {
    hint(DISABLE_DEPTH_TEST);
    FrontDials frontDial = new FrontDials(300, 400);
    float variation = 0.0002;
    rad = rad + variation;
    b1.move(rad);
    for(int i = 0; i < 36; i++) {
        for(int j = 0; j < 36; j++) {
            if(graph[i][j] == 1) {
               if(gears[i].getCenterX() != gears[j].getCenterX()
                      || gears[i].getCenterY() != gears[j].getCenterY()) 
                   cases(i, j, variation);   
               else
                   gears[i].move(gears[j].getTotalRads()); 
            }
        }
        
    }
    gears[20].rotateCenters(gears[20], gears[16], gears[15]);
    gears[24].rotateCenters(gears[24], gears[27], gears[15]);
    gears[33].rotateCenters(gears[33], gears[35], gears[31]);
    hint(ENABLE_DEPTH_TEST);
    frontDial.moveYearPointer(gears[0].getTotalRads());
    frontDial.moveMoonPositionAndPhase(gears[33].getTotalRads(), gears[31].getTotalRads());
}



void initializeGraph() {
    for(int i = 0; i < graph.length; i++) {
        for(int j = 0; j < graph.length; j++) {
            graph[i][j] = 0;
        }
    } 
}

void initializeGears() {
    b1 = new Gear(224, 0, -1, "", "right", 200, 0, 0, 255);
    b2 = new Gear(64, 1, 0, "concentric", "right", 0, 200, 0, 25);   
    c1 = new Gear(38, 4, 1, "left", "left", 0, 0, 200, 255);
    c2 = new Gear(48, 6, 4, "concentric", "left", 100, 100, 0, 255);
    d1 = new Gear(24, 8, 6, "left", "right", 0, 100, 100, 255);
    d2 = new Gear(127, 11, 8, "concentric", "right", 100, 0, 100, 255);
    e2 = new Gear(32, 13, 11, "right", "left", 150, 200, 50, 255);
    e5 = new Gear(50, 16, 13, "concentric", "left", 100, 100, 100, 255);
    k1 = new GearK1(50, 20, 16, "up", "right", 150, 50, 50, 255, 4.0);
    k2 = new GearK2(50, 24, 20, "concentric", "right", 50, 150, 200, 255);
    e6 = new Gear(50, 27, 24, "down", "left", 250, 100, 200, 255);
    e1 = new Gear(32, 29, 27, "concentric", "left", 50, 100, 50, 255);
    b3 = new Gear(32, 31, 29, "right", "right", 100, 200, 0, 255);
    l1 = new Gear(38, 3, 1, "left", "left", 100, 50, 0, 255);
    l2 = new Gear(53, 5, 3, "concentric", "left", 50, 50, 50, 255);
    m1 = new Gear(96, 7, 5, "left", "right" , 100, 50, 250, 100);
    m3 = new Gear(27, 10, 7, "concentric", "right", 0, 100, 250, 255);
    e3 = new Gear(223, 15, 10, "right", "left", 150, 0, 100, 100); 
    b0 = new Gear(20, 35, 0, "concentric", "right", 0, 100, 200, 255);
    ma1 = new Gear(20, 33, 35, "right", "left", 100, 100, 250, 255);
}

/**
 * Initialize total rads of all gears with value of 0.
 */
void initializeRads() {
    rad = 0;
    for(int i = 0; i < gears.length; i++)
        if(gears[i] != null)
            gears[i].setTotalRads(0);
}


void setup() {
    size(1600, 900, P3D);
    initializeGraph(); 
    initializeGears();
    
}

void draw() {
   background(50, 0);
   if(selection == 6)
       startMechanism();
   else 
       initializeRads();   
}

/**
 * A class that represents one gear of the mechanism
 * 
 * @author Thodoris Sotiropoulos
 * @version 1.1 February 2014 - April 2014
 *
 */
class Gear {
  /** the x - coordinate of gear's center */
    private float centerX;
    /** the y - coordinate of gear's center */
    private float centerY;
    /** the diameter of gear */
    private float diameter;
    /** number of gear's teeth */
    private int numberOfTeeth ;
    /** a number that corresponds to one gear */
    private int node;
    /** the number of the gear which this one moved by */
    private int movedBy;
    /** total rads that gear has completed */
    private float totalRads;
    /** direction of gear's rotation */
    private String directionOfRotation;
    /** tint of red */
    private int red;
    /** tint of green */
    private int green;
    /** tint of blue */
    private int blue;
    /** opacity of gear */
    private int opacity;
    /** an array of all gear's teeth */
    private Triangles[] triangles;
    
    Gear() {}
    
    /**
     * constructor which initializes one gear
     * 
     * @param numberOfTeeth number of gear's teeth
     * @param node number of gear
     * @param movedBy number of gear that moves this one
     * @param position gear's position relatively to the gear which moves it
     * @param directionOfRotation direction of gear's rotation
     * @param red tint of red
     * @param green tint of green
     * @param blue tint of blue
     * @param opacity opacity of gear
     */
    Gear(int numberOfTeeth, int node, int movedBy, String position,
        String directionOfRotation, int red, int green, int blue, int opacity){
        this.numberOfTeeth = numberOfTeeth;
        this.triangles = new Triangles[numberOfTeeth];
        this.diameter = getDiameter();
        this.node = node;
        this.movedBy = movedBy;
        this.directionOfRotation = directionOfRotation;
        this.totalRads = 0;
        this.red = red;
        this.green = green;
        this.blue = blue;
        this.opacity = opacity;
        if(node == 0) {
            this.centerX = 1000;
            this.centerY = 500;
        } else if(node == 24) {
          // initialize coordinates of gear relatively to gear which moves it
            setCoordinatesOfCenter(gears[movedBy], position);
            // for gear K2 change a bit its center
            this.centerY = this.centerY - 10;
            graph[node][movedBy] = 1;
        } else {
          // initialize coordinates of gear relatively to gear which moves it
            setCoordinatesOfCenter(gears[movedBy], position);
            graph[node][movedBy] = 1;
        }
        gears[node] = this;  
        Triangles tr = new Triangles();
        // draw gear
        triangles = tr.drawTeeth(totalRads, numberOfTeeth,
                      centerX, centerY, diameter, directionOfRotation);
          
    }
    
    /**
     * set total rads of gear with the value given as parameter
     * 
     * @param rads new total rads
     */
    void setTotalRads(float rads) {
        this.totalRads = rads;
    }
    
    /**
     * Get total rads of gear
     * 
     * @return total rads of gear
     */
    float getTotalRads() {
        return this.totalRads;
    }

    int getNode() {
        return this.node;
    }
    
    /**
     * Get direction of gear's rotation
     * 
     * @return direction of rotation
     */
    String getDirectionOfRotation() {
        return this.directionOfRotation;
    }
    
    /**
     * Get x - coordinate of gear's center
     * 
     * @return x - coordinate of gear's center
     */
    float getCenterX() {
        return this.centerX;
    }
    
    /**
     * Get y - coordinate of gear's center
     * 
     * @return y - coordinate of gear's center
     */
    float getCenterY() {
        return this.centerY;
    }
    
    /**
     * get number of total gear's teeth
     * 
     * @return total gear's teeth
     */
    int getNumberOfTeeth() {
        return this.numberOfTeeth;
    }
    
    /**
     * initialize coordinates of gear based on the coordinates of gear 
     * which moves it
     * 
     * @param gear gear which moves current gear
     * @param position of gear relatively to other gear
     */
    void setCoordinatesOfCenter(Gear gear, String position) {
      // length of teeth's side
        final float lengthOfSide = 7;
        // height of teeth's height
        final float heightOfTriangle = (float) ((lengthOfSide * Math.sqrt(3)) / 2);
        if(position.equals("left")) {
            this.centerX = gear.getCenterX() - (this.getDiameter() / 2) -
                (gear.getDiameter() / 2) - heightOfTriangle - 2;
            this.centerY = gear.getCenterY();
        } else if(position.equals("right")) { 
            this.centerX = gear.getCenterX() + (this.getDiameter() / 2) + 
                (gear.getDiameter() / 2) + heightOfTriangle + 2;
            this.centerY = gear.getCenterY();
        } else if(position.equals("up")) {
            this.centerY = gear.getCenterY() - (this.getDiameter() / 2) - 
                (gear.getDiameter() / 2) - heightOfTriangle -2;
            this.centerX = gear.getCenterX();
        } else if(position.equals("down")) {
            this.centerY = gear.getCenterY() + (this.getDiameter() / 2) + 
                (gear.getDiameter() / 2) + heightOfTriangle + 2;
            this.centerX = gear.getCenterX();
        } else {
            this.centerY = gear.getCenterY();
            this.centerX = gear.getCenterX();
        }
    }
   
    /**
     * draw gear without its teeth
     */
    void drawEllipse() {
        noStroke();
        ellipse(centerX, centerY, diameter, diameter);
        
    }
    
    /**
     * draw gear's pointer
     */
    void drawPointer() {
        float x1;
        float y1;
        if(directionOfRotation.equals("right")) {
            x1 = (int)(centerX + (diameter / 2)*cos(totalRads));
            y1 = (int)(centerY + (diameter / 2)*sin(totalRads));
        } else {
            x1 = (int)(centerX + (diameter / 2)*sin(totalRads));
            y1 = (int)(centerY + (diameter / 2)*cos(totalRads));
        }
        strokeWeight(1);
        stroke(11);
        line(centerX, centerY, x1, y1);
    }
    
    /**
     * Get gear's diameter
     * 
     * @return
     */
    float getDiameter() {
      // length of teeth's side
        final float lengthOfSide = 7;
        // get angle of the polygon
        float angle = 360 / (float) numberOfTeeth;
        // get angle of the triangle's base
        float angle2 = ((float)90 - angle / 2);
        return lengthOfSide / ((float) (cos(radians(angle2))));
    }
    
    /**
     * move gear based on the total rads that it has completed
     * 
     * @param total rads
     */
    void move(float rads) {
        fill(this.red, this.green, this.blue, this.opacity);
        this.setTotalRads(rads);
        Triangles tr = new Triangles();
        // draw gear's teeth
        triangles = tr.drawTeeth(this.totalRads, numberOfTeeth,
            centerX, centerY, diameter, directionOfRotation);
        drawEllipse();
        drawPointer(); 
    }
    
    /**
     * get distance between two gears
     * 
     * @param a1 Gear one
     * @param b1 Gear two
     * @return distance between two gears
     */
    float calculateDistance(Gear a1, Gear b1) {
      // convert coordinates to the cartesian system
        float cx = a1.getCenterX() - b1.getCenterX();
        float cy = b1.getCenterY() - a1.getCenterY();
        return (float)Math.sqrt(Math.pow((cx),2) + Math.pow((cy), 2));
    }
    
    /**
     * rotate one gear around another gear
     * 
     * @param a gear which is being rotated
     * @param b gear which the other gear is being rotates around it
     * @param c gear that first gear is being rotated correspondingly to its total rads
     */
    void rotateCenters(Gear a, Gear b, Gear c) {
        float d = calculateDistance(a, b);
        if(b.getDirectionOfRotation().equals("right")) {
            a.centerX  = b.centerX + d*cos(c.getTotalRads());
            a.centerY =  b.centerY + d*sin(c.getTotalRads());      
        } else {
            a.centerX  = b.centerX + d*sin(c.getTotalRads());
            a.centerY =  b.centerY + d*cos(c.getTotalRads());
        }
    }
    
    /**
     * Get an array of distances between all the points of a gear's teeth and the 
     * third point of the tooth of the gear which moves it.
     * 
     * @param a gear which moves other gear
     * @param b gear
     * @param i index of teeth of gear a
     * @param j index of teeth of gear b
     * @return an array of distances. First index contains distance from the third point of tooth
     * which is not on base, second index contains distance from the second point of tooth's base
     * and third index contains distance from the first point of tooth's base.
     */
    float[] calculateDistances(Gear a, Gear b, int i, int j) {
        float bx2 = b.triangles[j].x2 - b.getCenterX();
        float by2 = b.getCenterY() - b.triangles[j].y2;
        float bx3 = b.triangles[j].x3 - b.getCenterX();
        float by3 = b.getCenterY() - b.triangles[j].y3;
        float bx1 = b.triangles[j].x1 - b.getCenterX();
        float by1 = b.getCenterY() - b.triangles[j].y1;
        float ax3 = a.triangles[i].x3 - b.getCenterX();
        float ay3 = b.getCenterY() - a.triangles[i].y3;
        float D3 = (float)Math.sqrt(Math.pow((ax3 - bx1),2) + Math.pow((ay3 - by1), 2));
        float D1 = (float)Math.sqrt(Math.pow((ax3 - bx3),2) + Math.pow((ay3 - by3), 2));
        float D2 = (float)Math.sqrt(Math.pow((ax3 - bx2),2) + Math.pow((ay3 - by2), 2));
        float[] distances = {D1, D2, D3};
        return distances;  
    }

    /**
     * check if the gear a moves gear b. If it moves it, then gear b moves too.
     * 
     * @param a gear which moves another gear 
     * @param b gear
     * @param directionOfCollision side of tooth of gear b 
     * @param variation variation of total rads
     */
     void checkMove(Gear a, Gear b, String directionOfCollision, float variation) {
         for(int i = 0; i < a.numberOfTeeth; i++) {
             for(int j = 0; j < b.numberOfTeeth; j++) {
                 float[] distances = calculateDistances(a, b, i, j);
                 float heightOfTriangle = (float) ((7 * Math.sqrt(3)) / 2);
                 if(directionOfCollision.equals("left")) {
                     if((Math.abs(distances[0] -(7 -distances[1])) <=0.3)
                        && ((distances[2] >= heightOfTriangle) && (distances[2] <= 7)) ) {
                         if(b.getNode() == 33)
                             // increase completed total rads of gear b  
                             b.setTotalRads(gears[31].getTotalRads() + variation); 
                         else    
                         // increase completed total rads of gear b  
                         b.setTotalRads(b.getTotalRads() + variation); 
                     }
                 } else if(directionOfCollision.equals("right")) {
                     if((Math.abs(distances[0] -(7 -distances[2])) <=0.3)
                        && ((distances[1] >= heightOfTriangle) && (distances[1] <= 7)))  {
                        if(b.getNode() == 33)
                             // increase completed total rads of gear b  
                             b.setTotalRads(gears[31].getTotalRads() + variation); 
                         else    
                         // increase completed total rads of gear b  
                         b.setTotalRads(b.getTotalRads() + variation);            
                     }
                 }
             }
         }   
         
         b.move(b.getTotalRads());    
     }
}

/**
 * class that represents gear K1 of the mechanism ectending class Gear
 * 
 * @author Thodoris Sotiropoulos
 * @version 1.1 February 2014 - April 2014
 *
 */
class GearK1 extends Gear {
  /** pin of gear */
    private Pin pin;
    
    /**
     * Constructor that initializes gear and its pin using constructor of superclass.
     * 
     * @param numberOfTeeth number of gear's teeth
     * @param node number of gear
     * @param movedBy number of gear that moves this one
     * @param position gear's position relatively to the gear which moves it
     * @param directionOfRotation direction of gear's rotation
     * @param red tint of red
     * @param green tint of green
     * @param blue tint of blue
     * @param opacity opacity of gear
     * @diameterOfPin diameter of pin
     */
    GearK1(int numberOfTeeth, int node, int movedBy, String position,
        String directionOfRotation, int red, int green, int blue,
        int opacity, float diameterOfPin) {
        super(numberOfTeeth, node, movedBy, position, directionOfRotation, red,
         green, blue, opacity);
         
        Pin p = new Pin(this, diameterOfPin);
        this.pin = p;
    }
    
    /**
     * get the point of the pin that collides with the slot of gear K2
     * 
     * @param gear gear K2 of mechanism
     * @return coordinates of pin's point on the Cartesian system with start of
     * axis the coordinates of center of gear K2
     */
    float[] getPointOfPin(GearK2 gear) {
        float[] point3 = new float[2];
        float cx = pin.getCenterX() + (pin.getDiameter() / 2) * 
            cos((radians(90) + this.getTotalRads()));
        point3[0] = cx - gear.getCenterX();
        float cy = pin.getCenterY() + (pin.getDiameter() / 2) * 
            sin((radians(90) + this.getTotalRads()));
        point3[1] = gear.getCenterY() - cy;
        return point3;
    }
    
    /**
     * get gear's pin 
     *  
     * @return get gear's pin
     */
    Pin getPin() {
        return this.pin;
    }
}

/**
 * a class that represents gear K2 of the mechanism extending class Gear
 * 
 * @author Thodoris Sotiropoulos
 * @version 1.1 February 2014 - April 2014
 *
 */
class GearK2 extends Gear {
  /** slot of gear */
    private Slot slot;
    
    /**
     * Constructor that initializes gear and its slot using constructor of superclass.
     * 
     * @param numberOfTeeth number of gear's teeth
     * @param node number of gear
     * @param movedBy number of gear that moves this one
     * @param position gear's position relatively to the gear which moves it
     * @param directionOfRotation direction of gear's rotation
     * @param red tint of red
     * @param green tint of green
     * @param blue tint of blue
     * @param opacity opacity of gear
     */
    GearK2(int numberOfTeeth, int node, int movedBy, String position, String directionOfRotation, int red,
         int green, int blue, int opacity) {
        super(numberOfTeeth, node, movedBy, position, directionOfRotation, red,
         green, blue, opacity);
        Slot s = new Slot(12, 35);
        this.slot = s;
    }
    
    /**
     * Get coordinates of point1 of the slot
     * 
     * @return coordinates of point1 of the slot on the Cartesian system with
     * start of axis the coordinates of center of gear K2
     */
    float[] getPoint1() {
        float angle1 = radians(180) + this.getTotalRads();
        float x1 = sin(angle1) * slot.getSideA();
        float y1 = cos(angle1) * slot.getSideA();
        float[] point1 = new float[2];
        point1[0] = x1;
        point1[1] = y1;
        return point1;
  
    }
    
    /**
     * Get coordinates of point2 of the slot
     * 
     * @return coordinates of point2 of the slot on the Cartesian system with
     * start of axis the coordinates of center of gear K2
     */
    float[] getPoint2() {
        float angle2 = radians(360) - this.getTotalRads();
        float x2 = cos(angle2) * slot.getSideB();
        float y2 = sin(angle2) * slot.getSideB();
        float[] point2 = new float[2];
        point2[0] = x2;
        point2[1] = y2;
        return point2;
    }
   
    /**
     * check if the pin of gear K1 of mechanism is too close to slot of Gear K2
     * in order to move it. If it occurs, then gear K2 moves.
     * 
     * @param gk1 gear K1
     * @param gk2 gear K2
     * @param variation variation of completed of total rads
     */
    void checkK2(GearK1 gk1, GearK2 gk2, float variation) {
        // first point of slot's base
        float [] point1 = gk2.getPoint1();
        float finalx1 = point1[0] + gk2.getCenterX();
        float finaly1 = gk2.getCenterY() - point1[1];
        // second point of slot's base
        float[] point2 = gk2.getPoint2();
        float finalx2 = finalx1 + point2[0];
        float finaly2 = finaly1 - point2[1];
        float xa1 = finalx1 - gk2.getCenterX();
        float xa2 = finalx2 - gk2.getCenterX();
        // point of pin which collides with slot
        float[] point3 = gk1.getPointOfPin(gk2);
        float xa3 = point3[0];
        float ya1 = gk2.getCenterY() - finaly1;
        float ya2 = gk2.getCenterY() - finaly2;
        float ya3 = point3[1];
        float D3 = (float)Math.sqrt(Math.pow((xa3 - xa2),2) + Math.pow((ya3 - ya2), 2));
        float D1 = (float)Math.sqrt(Math.pow((xa3 - xa1),2) + Math.pow((ya3 - ya1), 2));
        float D2 = (float)Math.sqrt(Math.pow((xa3 - 0), 2) + Math.pow((ya3 - 0), 2));    
        if((Math.abs(D1 - (gk2.slot.getSideB() - D3)) <=0.3) || (Math.abs(D1 -(gk2.slot.getSideA() - D2) ) <= 0.3))
             gk2.setTotalRads(gk2.getTotalRads() + variation);
        // move K2
        gk2.move(gk2.getTotalRads()); 
    }
    
    /**
     * get slot of gear
     * 
     * @return slot of gear
     */
    Slot getSlot() {
        return this.slot;
    }
   
}

/**
 * a class that represents the pin of gear K1 of mechanism
 * 
 * @author Thodoris Sotiropoulos
 * @version 1.1 February 2014 - April 2014
 *
 */
class Pin {
  /** x - coordinate of pin's center */
    private float centerX;
    /** y - coordinate of pin's center */
    private float centerY;
    /** diameter of pin */
    private float diameter;
    
    /**
     * constructor that initializes pin based on the gear K1
     * 
     * @param gear gear K1 of mechanism
     * @param diameter diameter of mechanism
     */
    Pin(GearK1 gear, float diameter) {
        // locate pin in a small distance from the center of gear K1
        float x1 = (float)(gear.getCenterX() +(gear.getDiameter() / 5)*cos(0));
        float y1 = (float)(gear.getCenterY() +(gear.getDiameter() / 5)*sin(0));
        centerX = x1;
        centerY = y1;
        this.diameter = diameter;
    }
    
    /**
     * move pin accordingly to the move of gear K1
     * 
     * @param gear gear K1
     */
    void movePin(GearK1 gear) {
        float x1 = (float)(gear.getCenterX() +(gear.getDiameter() / 5)
            *cos(gear.getTotalRads()));
        float y1 = (float)(gear.getCenterY() +(gear.getDiameter() / 5)
            *sin(gear.getTotalRads()));
        centerX = x1;
        centerY = y1;
        fill(200, 0, 0);
        ellipse(centerX, centerY, diameter, diameter);
    }
    
    /**
     * set x - coordinate of pin's center accordingly to the value given as parameter
     * 
     * @param centerX new x - coordinate of pin's center
     */
    void setCenterX(float centerX) {
        this.centerX = centerX;
    }
    
    /**
     * set y - coordinate of pin's center accordingly to the value given as parameter
     * 
     * @param centerX new y - coordinate of pin's center
     */
    void setCenterY(float centerY) {
        this.centerY = centerY;
    }
    
    /**
     * get the x - coordinate of pin's center
     * 
     * @return x - coordinate of pin's center
     */
    float getCenterX() {
        return this.centerX;
    }
    
    /**
     * get the y - coordinate of pin's center
     * 
     * @return y - coordinate of pin's center
     */
    float getCenterY() {
        return this.centerY;
    }
    
    /**
     * get diameter of pin
     * 
     * @return diameter of pin
     */
    float getDiameter() {
        return this.diameter;
    }
    
}

/**
 * a class that represents the slot of gear K2 of the mechanism
 * 
 * @author Thodoris Sotiropoulos
 * @version 1.1 February 2014 - April 2014
 *
 */
class Slot {
  /** length of the first side of the slot */
    private float sideA;
    /** length of the second and larger side of the slot */
    private float sideB;
    
    /**
     * a constructor that initializes the slot
     * 
     * @param sideA the length of first side of slot
     * @param sideB the length of the secont side of slot
     */
    Slot(float sideA, float sideB) {
        this.sideA = sideA;
        this.sideB = sideB;
    }
    
    /**
     * move slot as the gear K2 is moving
     * 
     * @param gear gear K2 of the mechanism
     */
    void moveSlot(GearK2 gear) {
        fill(0, 0);
        pushMatrix();
        translate(gear.getCenterX(), gear.getCenterY());
        pushMatrix();
        rotate(gear.getTotalRads());
        strokeWeight(2);
        rect(0, 0, sideB, sideA);
    }
    
    /**
     * get the length of the first side of the slot
     * 
     * @return lngth of the first side of the slot
     */
    float getSideA() {
        return this.sideA;
    }
    
    /**
     * get the length of the second side of the slot
     * 
     * @return length of the second side of the slot
     */
    float getSideB() {
        return this.sideB;
    }
}

/**
 * a class that represents one gear's tooth
 * 
 * @author Thodoris Sotiropoulos
 * @version 1.1 February 2014 - April 2014
 *
 */
class Triangles {
    /** x - coordinate of the first point of tooth's base */
    private float x1;
    /** x -coordinate of the second point of tooth's base */
    private float x2;
    /** x - coordinate of the point of tooth which is not on the base */
    private float x3;
    /** y - coordinate of the first point of tooth's base */
    private float y1;
    /** y - coordinate of the second point of tooth's base */ 
    private float y2;
    /** y - coordinate of the point of tooth which is not on the base */
    private float y3;
    
    Triangles(){}
    
    /**
     * constructor that draw a tooth with the values given as parameters
     * 
     * @param tx x - coordinate of the first point of tooth's base
     * @param ty y - coordinate of the first point of tooth's base
     * @param tx2 x - coordinate of the second point of tooth's base
     * @param ty2 y - coordinate of the second point of tooth's base
     * @param tx3 x - coordinate of the point of tooth which is not on the base
     * @param ty3 y - coordinate of the point of tooth which is not on the base
     */
    Triangles(float tx, float ty, float tx2, float ty2, float tx3, float ty3) {
        x1 = tx;
        x2 = tx2;
        x3 = tx3;
        y1 = ty;
        y2 = ty2;
        y3 = ty3;
        noStroke();
        triangle(x1, y1, x2, y2, x3, y3);
    }
    
    /**
     * get the angle of the polygon based on gear 
     * 
     * @param teeth number of gear's teeth
     * @return angle of gear's polygon
     */
    float calculateAngle (int teeth) {
        return 360 / (float) teeth;
    }
    
    /**
     * get the coordinates of the second point of the tooth's base
     * 
     * @param angle angle of the polygon
     * @param i number of teeth have drawn so far
     * @param t total rads of the first point of the first tooth
     * @param diameter gear's diameter
     * @param direction gear's direction of rotation
     * @return an array with the coordinates of the second point of the tooth's base on
     * the Cartesian system with start of axis the gear's center.
     */
    float[] calculateCoordinatesOf2ndPoint (float angle, int i, float t,
                        float diameter, String direction) {
        float [] point2 = new float[2];
        if(direction.equals("right")) {
            point2[0] = (diameter / 2) * (float) Math.sin(radians(angle + i * angle)+t);
            point2[1] = (diameter / 2) * (float) Math.cos(radians(angle + i * angle)+t);
        } else {
            point2[0] = (diameter / 2) * (float) Math.cos(radians(angle + i * angle)+t);
            point2[1] = (diameter / 2) * (float) Math.sin(radians(angle + i * angle)+t);          
        }
        return point2;
    }


    /**
     * get the coordinates of the point of tooth which is not on its base. One tooth
     * is a equilateral triangle. Based on knowing the coordinates of the other points
     * with can calculate the coordinates of the third point by solving the system of the 
     * below equations: 
     * 
     * a) one of the equation of perpendicular bisector line of the triangle
     * b) the length of the perpendicular bisector line squared equals with the height of
     * triangle squared.
     *  
     *
     * 
     * @param angle angle of the gear's polygon
     * @param i number of teeth have drawn so far
     * @param t total rads of the first point of the first tooth
     * @param toothx x - coordinate of the first point of tooth's base
     * @param toothx2 x - coordinate of the second point of tooth's base
     * @param toothy y - coordinate of the first point of tooth's base
     * @param toothy2 y - coordinate of the second point of tooth's base
     * @param direction gear's direction of rotation
     * @return
     */
    float[] calculateCoordinatesOf3rdPoint (float angle, float i, float t, float toothx,
                         float toothx2, float toothy, float toothy2, String direction) {
        // x - coordinate of the base's middle point
        final float Xm = (toothx + toothx2) / 2;
        // y - coordinate of the base's middle point
        final float Ym = (toothy + toothy2) / 2;
        final float L = (toothx - toothx2)/ (toothy2 - toothy);
        // length of the triangle's side
        final float lengthOfSide = 7;
        // height of triangle squared;
        final float heightOfTriangle = (float) ((Math.pow(lengthOfSide, 2) * 3) / 4);
        float[] point3 = new float[2];
        float a = 1 + (float) Math.pow(L, 2);
        float b = -(float) (2 * Xm + 2 *  Math.pow(L, 2) *Xm);
        float c =  (float) (Math.pow(Xm, 2) + (Math.pow(L, 2) *  Math.pow(Xm, 2))
            - heightOfTriangle);
        float D = (float) Math.pow(b, 2) - 4 * a * c;
        float value;
        if(direction.equals("right"))
            value = (angle+t) + i*angle;
        else
            value = (angle + t + 90) + i*angle;    
      
        while(value > 360) 
            value = value - 360;
        if (value < (angle / 2) || value > 180 + (angle /2 +1))
            point3[0] = (-b - (float) Math.sqrt(D)) / (2 * a);
        else if (value <= 180 + (angle / 2))
            point3[0] = (-b + (float) Math.sqrt(D)) / (2 * a);
        else
            point3[0] = (-b - (float) Math.sqrt(D)) / (2 * a);
        point3[1] = (point3[0] * L - L * Xm + Ym);
        return point3;
    } 
    
    

   
    /**
     * get an array of all objects of the gear's teeth
     *    
     * @param t total rads of gear's rotation
     * @param numberOfTeeth number of gear's teeth
     * @param centerX x - coordinate of the gear's center
     * @param centerY y - coordinate of the gear's center
     * @param diameter gear's diameter
     * @param direction direction of gear's rotation
     * @return an array of all gear's teeth
     */
    Triangles[] drawTeeth(float t, int numberOfTeeth, float centerX,
                    float centerY, float diameter, String direction) {
        float toothx;
        float toothx2;
        float toothx3;
        float toothy;
        float toothy2;
        float toothy3;
        Triangles [] triangles = new Triangles[numberOfTeeth];
        for(int i = 0; i < numberOfTeeth; i++) { 
        // calculate angle of gear's polygon
        float angle = calculateAngle(numberOfTeeth);      
        if(i == 0) {
              if(direction.equals("right")) {
                  toothx = (diameter / 2) * (float) Math.sin(t);
                  toothy = (diameter / 2) * (float) Math.cos(t);
              } else {
                  toothx = (diameter / 2) * (float) Math.cos(t);
                  toothy = (diameter / 2) * (float) Math.sin(t);
              }
        } else {
            /*
             * calculate coordinates of the first point of the tooth's base
             * which is equal with second point of the previous tooth
             */
             float[] point1 = calculateCoordinatesOf2ndPoint (angle, i-1, t,
                  diameter, direction);
             toothx = point1[0];
             toothy = point1[1];
             
        }
        float[] point2 = calculateCoordinatesOf2ndPoint (angle, i,
             t, diameter, direction);
        toothx2 = point2[0];
        toothy2 = point2[1];
        // calculate coordinates of the third triangle's base
        float[] point3 = calculateCoordinatesOf3rdPoint (angle, i, degrees(t),
             toothx, toothx2, toothy, toothy2, direction);
        toothx3 = point3[0];
        toothy3 = point3[1];      
        //initialize tooth with the coordinates as the are on the frame coordinates system.
        Triangles triangle = new Triangles(centerX + toothx, centerY - toothy,
             centerX + toothx2, centerY - toothy2, centerX + toothx3, centerY - toothy3);
        triangles[i] = triangle;
        }
        return triangles;        
    }
    
}

/**
 * a class that represents the front dial of mechanism
 * 
 * @author Thodoris Sotiropoulos
 * @version 1.1 February 2014 - April 2014
 *
 */
class FrontDials {
  /** x - coordinate of dial's center */
    private float cx;
    /** y - coordinate of dial's center */
    private float cy;

    /**
     * a constructor that initializes and draws dial
     * 
     * @param cx x - coordinate of dial's center
     * @param cy y - coordinate of dial's center
     */
    FrontDials(float cx, float cy) {
        this.cx = cx;
        this.cy = cy;
        drawLines("outer");
        drawLines("inner");
    }
    
    /**
     * draw lines around dial's center accordingly to their type (outer or inner)
     * 
     * @param selection type of lines
     */
    void drawLines(String selection) {
        final int lines;
        final float diameter;
        if(selection.equals("outer")) {
            lines = 365;
            diameter = getDiameter(lines);
        } else {
            lines = 360;
            diameter = getDiameter(lines);
        }    
        float rad = 0;
        for(int counter = 0; counter < lines; counter++) {
            float x1 = cx + (diameter / 2) * cos(rad);
            float x2 = cx + (diameter / 2.1) * cos(rad);
            float y1 = cy + (diameter / 2) * sin(rad);
            float y2 = cy + (diameter / 2.1) * sin(rad);
            stroke(0);
            line(x1, y1, x2, y2);
            // variation of total rads
            rad = rad + radians((float)360 / lines);
            
           
         }

    }
    
    /**
     * Get diameter accordingly to the number of lines which specify if the circle
     * is outer or inner
     * 
     * @param lines number of lines
     * @return diameter
     */
    float getDiameter(int lines) {
        final float distance;
        if(lines == 365) 
            distance = 5;
        else
            distance = 4.5;   
        // get angle of the polygon
        float angle = 360 / (float)lines;
        // get angle of the triangle's base
        float angle2 = ((float)90 - angle / 2);
        return distance / ((float) (cos(radians(angle2))));
    }   
    
    /**
     * Specify the the move of Moon's pointer accordigly to the move of the gears which
     * produce this output(Anomalistic month, moon phase)
     * 
     * @param rad2 total completed rads of the gear which produce the output of moon phase
     * @param rad3 total completed rads of the gear which produce the output of Anomalistic month
     */
    void moveMoonPositionAndPhase(float rad2, float rad3) {
        final float diameter = getDiameter(360);
        float earthDistance = (diameter / 30) * sin(rad3);
        float x1 = cx + (diameter / 6 + earthDistance) * cos(rad3);
        float y1 = cy + (diameter / 6 + earthDistance) * sin(rad3);
        stroke(0);
        line(cx, cy, x1, y1);
        fill(255, 255, 255);
        float z = 1 * cos(rad2);
        float x = 1 * sin(rad2);
        directionalLight(255, 255, 255, x , 0 , z);
        pushMatrix();
        translate(x1, y1, 0);
        noStroke();
        sphere(10);
        popMatrix();
        
    }
    
    /**
     * Specify the the move of   Sun's pointer accordigly to the move of the gear which
     * produce this output(Year)
     * 
     * @param rad total completed rads of the gear which produce the output of Year
     */
    void moveYearPointer(float rad) {
        final float diameter = getDiameter(360);
        float x1 = cx + (diameter / 2.5) * cos(rad);
        float y1 = cy + (diameter / 2.5) * sin(rad);
        stroke(0);
        line(cx, cy, x1, y1);
        fill(200, 200, 0);
        noStroke();
        ellipse(x1, y1, 70, 70);        
    }
      
}

