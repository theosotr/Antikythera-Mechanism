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

/**
 * Activate gears which produce output of Metonic calendar, Callipic calendar and
 * Olympiad
 */
void startLunisolarCalculation() {
    float variation = 0.0008;
    rad = rad + variation;
    b1.move(rad);
    for(int i = 0; i < visited.length; i++)
        visited[i] = false;
    // use depth first search algorithm
    searchGraph(25, variation);
    visited[14] = false;
    // use depth first search algorithm
    searchGraph(22, variation);
}

/**
 * Activate gears which produce the output of Sidereal month.
 */
void startLunarCalculation() {
    float variation = 0.0002;
    rad = rad + variation;
    b1.move(rad);
    for(int i = 0; i < visited.length; i++) 
        visited[i] = false;
    // use depth fist search algorithm
    searchGraph(13, variation);    
}

/**
 * Activate gears which produce the output of Saros and Exeligmos.
 */
void startEclipseCalculation() {
    float variation = 0.0005;
    rad = rad + variation;
    b1.move(rad);
    for(int i = 0; i < visited.length; i++)
        visited[i] = false;
    // use depth first search algotithm 
    searchGraph(2, variation);    
      
}

/**
 * Activate back gears of mechanism and shows the back dials on screen.
 */
void startBackGears() {
    SarosDial saros = new SarosDial(150, 150, 50);
    BackDials calendars = new BackDials(470, 150, 50);
    float variation = 0.0005;
    rad = rad + variation;
    b1.move(rad);
    for(int i = 0; i < visited.length; i++)
        visited[i] = false;
    // use depth first search algorithm
    searchGraph(2, variation);
    visited[7] = false;
    // use depth first search algorithm
    searchGraph(25, variation);
    visited[14] = false;
    // use depth first search algorithm
    searchGraph(22, variation);
    // move pointer of Exeligmos accordingly to the gear which produce this output.
    saros.moveExeligmosPointer(gears[2].getTotalRads() + radians(90));
    // move pointer of Saros accordingly to the gear which produce this output.
    saros.moveSarosPointer(gears[28].getTotalRads() + radians(90));
    // move pointer of Metonic Calendar accordingly to the gear which produce this output.
    calendars.moveMetonicCalendarPointer(gears[12].getTotalRads() + radians(90));
    // move pointer of Olympiad accordingly to the gear which produce this output.
    calendars.moveOlympiadPointer(gears[22].getTotalRads() + radians(180));
    // move pointer of Callipic Calendar accordingly to the gear which produce this output.
    calendars.moveCallipicCalendarPointer(gears[25].getTotalRads() + radians(90));
}

/**
 * Activate gears which produce the output of Anomalistic month and moon phase.
 */
void startMoonPhaseCalculation() {
    float variation = 0.0002;
    rad = rad + variation;
    b1.move(rad);
    for(int i = 0; i < visited.length; i++)
        visited[i] = false;
    // use depth first search algorithm
    searchGraph(33, variation);
    visited[0] = false;
    // use depth first search algorithm
    searchGraph(31, variation);
    visited[1] = false;
    // use depth first search algorithm
    searchGraph(15, variation); 
    // rotate gear K1 accordingly to gear e3
    gears[20].rotateCenters(gears[20], gears[16], gears[15]);
    // rotate gear K2 accordingly to gear e3
    gears[24].rotateCenters(gears[24], gears[27], gears[15]);
    // rotate gear ma1 accordingly to gear b3
    gears[33].rotateCenters(gears[33], gears[35], gears[31]);   
}  

/**
 * Activate all gears of mechanism
 */
void startMechanism() {
    float variation = 0.0002;
    rad = rad + variation;
    b1.move(rad);
    for(int i = 1; i < 36; i++) {
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
    // rotate gear K1 accordingly to gear e3
    gears[20].rotateCenters(gears[20], gears[16], gears[15]);
    // rotate gear K2 accordingly to gear e3
    gears[24].rotateCenters(gears[24], gears[27], gears[15]);
    // rotate gear ma1 accordingly to gear b3
    gears[33].rotateCenters(gears[33], gears[35], gears[31]);
}

/**
 * depth first search algorithm
 * 
 * @param node number of gears which moves another.
 */
void searchGraph(int node, float variation) {
    for(int i = 0; i < 36; i++) {
         if(graph[node][i] == 1) {
             if(visited[i] == false) {
                 if(gears[node].getCenterX() != gears[i].getCenterX()
                      || gears[node].getCenterY() != gears[i].getCenterY())
                     cases(node, i, variation);
             else
                   gears[node].move(gears[i].getTotalRads());
             searchGraph(i, variation);       
            }
         }
     }
     visited[node] = true;
}

/**
 * Initialize graph with value 0
 */
void initializeGraph() {
    for(int i = 0; i < graph.length; i++) {
        for(int j = 0; j < graph.length; j++) {
            graph[i][j] = 0;
        }
    } 
}

/**
 * Initialize all gears of mechanism.
 */
void initializeGears() {
    b1 = new Gear(224, 0, -1, "", "right", 200, 0, 0, 255);
    b2 = new Gear(64, 1, 0, "concentric", "right", 0, 200, 0, 25);   
    c1 = new Gear(38, 4, 1, "left", "left", 0, 0, 200, 255);
    c2 = new Gear(48, 6, 4, "concentric", "left", 100, 100, 0, 255);
    d1 = new Gear(24, 8, 6, "left", "right", 0, 100, 100, 255);
    d2 = new Gear(127, 11, 8, "concentric", "right", 100, 0, 100, 100);
    e2 = new Gear(32, 13, 11, "right", "left", 150, 200, 50, 255);
    e5 = new Gear(50, 16, 13, "concentric", "left", 100, 100, 100, 255);
    k1 = new GearK1(50, 20, 16, "up", "right", 150, 50, 50, 100, 4.0);
    k2 = new GearK2(50, 24, 20, "concentric", "right", 50, 150, 200, 255);
    e6 = new Gear(50, 27, 24, "down", "left", 250, 100, 200, 255);
    e1 = new Gear(32, 29, 27, "concentric", "left", 50, 100, 50, 255);
    b3 = new Gear(32, 31, 29, "right", "right", 100, 200, 0, 255);
    l1 = new Gear(38, 3, 1, "left", "left", 100, 50, 0, 255);
    l2 = new Gear(53, 5, 3, "concentric", "left", 50, 50, 50, 255);
    m1 = new Gear(96, 7, 5, "left", "right" , 100, 50, 250, 100);
    m2 = new Gear(15, 9, 7, "concentric", "right", 150, 200, 100, 255);
    n1 = new Gear(53, 12, 9, "left", "left", 200, 100, 100, 100);
    n2 = new Gear(15, 14, 12, "concentric", "left", 100, 250, 0, 255);
    n3 = new Gear(57, 18, 14, "concentric", "left", 50, 100, 50, 100);
    p1 = new Gear(60, 17, 14, "left", "right", 200, 200, 200, 100);
    p2 = new Gear(12, 21, 17, "concentric", "right", 50, 25, 25, 255);
    q1 = new Gear(60, 25, 21, "left", "left", 100, 200, 200, 255);
    o1 = new Gear(60, 22, 18, "up", "right", 50, 240, 25, 255);
    m3 = new Gear(27, 10, 7, "concentric", "right", 0, 100, 250, 255);
    e3 = new Gear(223, 15, 10, "right", "left", 150, 0, 100, 100);
    e4 = new Gear(188, 19, 15, "concentric", "left", 50, 200, 50, 255);
    f1 = new Gear(53, 23, 19, "up", "right", 150, 50, 50, 100);
    f2 = new Gear(30, 26, 23, "concentric", "right", 25, 200, 200, 255);
    g1 = new Gear(54, 28, 26, "right", "left", 250, 100, 50, 100);
    g2 = new Gear(20, 30, 28, "concentric", "left", 100, 250, 100, 255);
    h1 = new Gear(60, 32, 30, "right", "right", 100, 50, 250, 150);
    h2 = new Gear(15, 34, 32, "concentric", "right", 0, 50, 0, 255);
    i1 = new Gear(60, 2, 34, "right", "left", 50, 0, 0, 255); 
    b0 = new Gear(20, 35, 0, "concentric", "right", 0, 100, 200, 255);
    ma1 = new Gear(20, 33, 35, "right", "left", 100, 100, 250, 255);
}

/**
 * Initialize total rads of all gears with value of 0.
 */
void initializeRads() {
    rad = 0;
    for(int i = 0; i < gears.length; i++)
        gears[i].setTotalRads(0);
}

/**
 * Set a variable true accordingly to the value give as parameter
 *  
 * @param selection a number 
 */
void booleanVariables(int selection) {
    lunisolar = false;
    lunar = false;
    eclipse = false;
    moonPhase = false;
    backDial = false;
    allGears = false;
    switch(selection) {
        case 1:
        lunisolar = true;
        break;
        case 2:
        lunar = true;
        break;
        case 3:
        eclipse = true;
        break;
        case 4:
        moonPhase = true;
        break;
        case 5:
        backDial = true;
        break;
        case 6:
        allGears = true;
        break;
    }
}

void setup() {
    size(1600, 900);
    initializeGraph(); 
    initializeGears();
    
}

void draw() {
   background(255, 0);
   switch(selection) {
       case "1": 
       if(lunisolar == false)
           initializeRads();
       startLunisolarCalculation();
       booleanVariables(1);
       break;
       case "2":
       if(!lunar)
           initializeRads();
       startLunarCalculation();    
       booleanVariables(2);
       break;
       case "3" :
       if(!eclipse)
           initializeRads();
       startEclipseCalculation();
       booleanVariables(3);
       break;
       case "4" :
       if(!moonPhase)
           initializeRads();
       startMoonPhaseCalculation();
       booleanVariables(4);
       break;
       case "5" :
       if(!backDial)
           initializeRads();
       startBackGears();
       booleanVariables(5);
       break;
       case "7":
       if(!allGears)
           initializeRads();
       startMechanism();
       booleanVariables(6);
       break;   
       default :
       break;
   }
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
        fill(50, 0);
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
 * a class that represents the Metonic calendar's dial
 * 
 * @author Thodoris Sotiropoulos
 * @version 1.1 February 2014 - April 2014
 *
 */
class BackDials {
  /** x - coordinate of dial's center */
    protected float cx;
    /** y - coordinate of dial's center */
    protected float cy;
    /** initial diameter of the first spiral line */
    protected float diameter1;
    /** initial diameter of the second spiral line */
    protected float diameter2;
    /** number of dial's circles */
    protected int circles;
    /** variation of diameter on each circle */
    protected int distance;
    
    BackDials(){}
    
    /**
     * a constructor that draws the dial
     * 
     * @param cx x - coordinate of the dial's center
     * @param cy y - coordinate of the dial's center
     * @param diameter initial diameter of the first spiral line 
     */
    BackDials(float cx, float cy, float diameter) {
        this.cx = cx;
        this.cy = cy;
        distance = 14;
        circles = 6;
        this.circles = circles;
        this.diameter1 = diameter;
        this.diameter2 = diameter + 20;
        noFill();  
        stroke(0);
        strokeWeight(2);
        // draw first spiral line
        drawFirstSpiral(diameter1);
        // draw second spiral line
        drawSecondSpiral(diameter2);
        stroke(0);
        strokeWeight(1);
        // draw dial's blocks
        drawLines();
        // draw callipic calendar's dial
        drawOlympiadandCallipicDials(cx + diameter1 / 2,  cy - diameter1 / 2, diameter1);
        // draw olympiad calendar's dial
        drawOlympiadandCallipicDials(cx - diameter1 / 2, cy - diameter1 / 2, diameter1);          
         

    }
    
    /**
     * draw first spiral line
     * 
     * @param diameter
     */
    void drawFirstSpiral(float diameter) {
        float firstValue = diameter;
        int counter = 0;
        beginShape();  
        while(diameter < ((circles * distance) + firstValue)) {
            int[] indexes = new int[2];
            // define the points where the line begins and ends
            indexes = beginAndEndIndexes(counter, "firstSpiral");
            for(int j = indexes[0]; j < indexes[1]; j++) {
                float x1 = cx + diameter * cos(radians(j));
                float y1 = cy + diameter * sin(radians(j));
                curveVertex(x1, y1);
                if(j > 275 & j < 360) {
                    diameter += 1;
                    j+=5;
                }
            }
            counter++;
        }
        endShape();  
    }
    
    /**
     * a method that defines in which rads the spiral lines begin and end
     * 
     * @param counter counter of circles
     * @param type type of spiral line
     * @return an array with the begin and end rads
     */
    int[] beginAndEndIndexes(int counter, String type) {
        int begin = 0;
        int end = 0;
        int turns;
        if(type.equals("firstSpiral")) 
            turns = circles - 1;
        else
            turns = circles - 2;    
        int[] array = new int[2];
        if(counter == 0) { 
            begin = 90;
            end = 360;
        } else if(counter == turns) {
            if(type.equals("firstSpiral") || type.equals("secondSpiral"))
                begin = 10;
            else
                begin = 0;     
            end = 450;
        } else {
            if(type.equals("firstSpiral") || type.equals("secondSpiral"))
                begin = 10;
            else
                begin = 0; 
            end = 360;
        }
        array[0] = begin;
        array[1] = end;
        return array;
    }
    
    /**
     * draw the second spiral line
     * 
     * @param diameter initial diameter of the first spiral line
     */
    void drawSecondSpiral(float diameter) {
        int counter = 0;
        beginShape();
        while(diameter < (circles * distance) + diameter1) {
            int[] indexes = new int[2];
            // define the points where the line begins and ends
            indexes = beginAndEndIndexes(counter, "secondSpiral");
            for(int j = indexes[0]; j < indexes[1]; j++) {
                float x1 = cx + diameter * cos(radians(j));
                float y1 = cy + diameter * sin(radians(j));
                curveVertex(x1, y1);
                if(j > 275 && j < 360) {
                    diameter += 1;
                    j+=5;
            
                }
            }
            counter++;
        }
        endShape();  
    } 
    
    /**
     * draw dial's blocks having calculated for each circle how many blocks has
     * in order dial to have 235 blocks.
     */
    void drawLines() {
        float rad1 = diameter1;
        float rad2 = diameter2;
        for(int i = 0; i < circles - 1; i++) {
            float variation = 0;
            int[] indexes = new int[2];
            // define the points where the line begins and ends
            indexes = beginAndEndIndexes(i, "lines");
            for(float n = indexes[0]; n < indexes[1]; n = n + calculateVariationOfNextLine()) {
                float x1 = cx + (diameter1 + i* distance + variation + distance)
                    * cos(radians(n));
                float y1 = cy + (diameter1 + i* distance + variation + distance)
                    * sin(radians(n));
                float x2 = cx + (diameter2 + i* distance + variation) * cos(radians(n));
                float y2 = cy + (diameter2 + i* distance + variation) * sin(radians(n));
                if(n > 275 && n < 360) {
                  // increase of both diameters 
                    variation = variation + getVariationOfDiameter(calculateVariationOfNextLine()) - 0.2;
                    rad1+=1;
                    rad2+=1;
      
                }
                line(x1, y1, x2, y2);
                
            }
        }  
    }
    
    /**
     * calculate how much do the total rads have to increase
     * in order to draw next block
     * 
     * @return variation of total rads
     */
    float calculateVariationOfNextLine() {
        if(circles == 5) 
            return 360 / ((float) 223 / 4);
        else 
            return 360 / ((float) 235 / 5);
    }
    
    /**
     * draw the Olympiad and Callipic calendar's dials
     * 
     * @param centx x - coordinate of the dial's center
     * @param centy y - coordinate of the dial's center
     * @param diameter diameter of the dial
     */
    void drawOlympiadandCallipicDials(float centx, float centy, float diameter) {
        beginShape();
        ellipse(centx, centy, diameter / 2, diameter / 2);
        line(centx + (diameter / 4) * cos(radians(270)),
          centy+ (diameter / 4) * sin(radians(270)),
          centx + (diameter / 4) * cos(radians(90)),
          centy + (diameter / 4) * sin(radians(90)));
        line(centx + (diameter / 4) * cos(radians(180)),
          centy+ (diameter / 4) * sin(radians(180)),
          centx + (diameter / 4) * cos(radians(0)),
          centy + (diameter / 4) * sin(radians(0)));
        endShape();    
    }
    
    /**
     * draw pointers of dials
     * 
     * @param centx x - coordinate of the dial's center
     * @param centy y - coordinate of the dial's center
     * @param diameter pointer's diameter
     * @param t total rads that the pointer has completed
     * @param direction direction of pointer's rotation
     */
    void drawPointer(float centx, float centy, float diameter, float t, String direction) {
        float x1;
        float y1;
        if(direction.equals("right")) {
            x1 = (int)(centx + (diameter / 2)*cos(t));
            y1 = (int)(centy + (diameter / 2)*sin(t));
        } else {
            x1 = (int)(centx + (diameter / 2)*sin(t + radians(90)));
            y1 = (int)(centy + (diameter / 2)*cos(t + radians(90)));
        }
        strokeWeight(2);
        stroke(250, 0, 0);
        line(centx, centy, x1, y1);
        stroke(0);
    }
    
    /**
     * get how many full rotations has the pointer completed
     * 
     * @param rad total rads that the pointer has completed
     * @return number of full rotations
     */
    int getTimes(float rad) {
        int counter = 0;
        float value = degrees(rad);
        while(value > 360) {
             value = value - 360;
             counter++;
        }
        return counter;
    }
    
    /**
     * get the variation of diameter based on the value given as parameter
     * 
     * @param variation variation of degrees
     * @return variation of diameter
     */
    float getVariationOfDiameter(float variation) {
        return variation / 5;
    }
    
    /**
     * Move Metonic calendar's pointer based on the total rads it has completed.
     * Diameter of pointer is increased accordingly to the point of dial it shows.
     * 
     * @param rads total rads that the pointer has completed
     */
    void moveMetonicCalendarPointer(float rads) {
        // get number of pointer's full rotations
        int times = getTimes(rads);
        if(degrees(rads) > 275 + times * 360) {
            float variation = degrees(rads) - (275 + times * 360);
            // new diameter of pointer
            float diameterOfPointer = 2 * (diameter1 + distance + distance * times
                + getVariationOfDiameter(variation));
            drawPointer(cx,  cy, diameterOfPointer, rads, "right");
        } else {
            float diameterOfPointer = 2 * (diameter1 + distance + distance * times);
            drawPointer(cx,  cy, diameterOfPointer, rads, "right");
        }
    }    
    
    /**
     * move Olympiad calendar's pointer based on the total rads it has completed
     * 
     * @param rads total rads that the pointer has completed
     */
    void moveOlympiadPointer(float rads) {
        float diameterOfPointer = diameter1 / 2;
        drawPointer(cx - diameter1 / 2, cy - diameter1 / 2, diameterOfPointer, rads, "left");
    }
    
    /**
     * move Callipic calendar's pointer based on the total rads it has completed
     * 
     * @param rads total rads that the pointer has completed
     */
    void moveCallipicCalendarPointer(float rads) {
        float diameterOfPointer = diameter1 / 2;
        drawPointer(cx + diameter1 / 2,  cy - diameter1 / 2, diameterOfPointer, rads, "right");
    }    
}

/**
 * a class that represents the Saros back dial, extending class BackDials
 * 
 * @author Thodoris Sotiropoulos
 * @version 1.1 February 2014 - April 2014
 *
 */
class SarosDial extends BackDials {
  
  
  /**
   * a constructor that initializes and draws dial
   * 
   * @param cx x - coordinate of dial's center 
   * @param cy y - coordinate of dial's center
   * @param diameter initial diameter of first spiral line
   */
    SarosDial(float cx, float cy, float diameter) {
        this.cx = cx;
        this.cy = cy;
        this.distance = 27;
        this.circles = 5;
        this.diameter1 = diameter;
        this.diameter2 = diameter1 + 20;
        noFill();  
        stroke(0);
        strokeWeight(2);
        // draw first spiral line
        this.drawFirstSpiral(diameter1);
        // draw second spiral line
        this.drawSecondSpiral(diameter2);
        stroke(0);
        strokeWeight(1);
        // draw dial's blocks
        this.drawLines();
        // draw Exeligmos dial
        drawExeligmos(cx + diameter1 / 2,  cy - diameter1 / 2, diameter1);

    }
    
    
    void drawFirstSpiral(float radius) {
        float firstValue = radius;
        int counter = 0;
        beginShape();  
        while(radius < ((circles * distance) + firstValue)) {
            int[] indexes = new int[2];
            indexes = beginAndEndIndexes(counter, "firstSpiral");
            for(int j = indexes[0]; j < indexes[1]; j++) {
                float x1 = cx + radius * cos(radians(j));
                float y1 = cy + radius * sin(radians(j));
                curveVertex(x1, y1);
                if(j > 270 & j < 360) {
                    radius += 3;
                    j+=10;
                }
            }
            counter++;
        }
        endShape();  
    }
    
    void drawSecondSpiral(float radius) {
        int counter = 0;
        beginShape();
        while(radius < ((circles - 1) * distance) + diameter1) {
            int[] indexes = new int[2];
            indexes = beginAndEndIndexes(counter, "secondSpiral");
            for(int j = indexes[0]; j < indexes[1]; j++) {
                float x1 = cx + radius * cos(radians(j));
                float y1 = cy + radius * sin(radians(j));
                curveVertex(x1, y1);
                if(j > 270 && j < 360) {
                    radius += 3;
                    j+=10;
            
                }
            }
            counter++;
        }
        endShape();  
    }
    
    float getVariationOfDiameter(float variation) {
        return (3 *variation) / 10;
    }
    
    
    /**
     * draw greek letter Eta 
     * 
     * @param rads completed rads of dial
     * @param diam1 current diameter of first spiral line
     * @param diam2 current diameter of second spiral line
     */
    void drawEta(float rads, float diam1, float diam2) {
      // distance from the first spiral line
        float dist1 = diam1 + (diameter2 - diameter1) / 3;
        // distance from the second spiral line
        float dist2 = diam2 - (diameter2 - diameter1) / 3;
        // distance from the current block line
        float varOfRads1 = calculateVariationOfNextLine() / 1.4;
        float varOfRads2 = calculateVariationOfNextLine() / 2;
        float x1 = cx + (dist1) * cos(radians(rads + varOfRads1));
        float y1 = cy + (dist1) * sin(radians(rads + varOfRads1));
        float x2 = cx + (dist2) * cos(radians(rads + varOfRads1));
        float y2 = cy + (dist2) * sin(radians(rads + varOfRads1));
        float x3 = cx + (dist1) * cos(radians(rads + varOfRads2));
        float y3 = cy + (dist1) * sin(radians(rads + varOfRads2));
        float x4 = cx + (dist2) * cos(radians(rads + varOfRads2));
        float y4 = cy + (dist2) * sin(radians(rads + varOfRads2));
        float Xm1 = (x1+x2) / 2;
        float Xm2 = (x3 + x4)/2;
        float Ym1 = (y1+y2)/2;
        float Ym2 = (y3+y4)/2;
        line(x1, y1, x2, y2);
        line(x3, y3, x4, y4);
        line(Xm1,Ym1, Xm2, Ym2);
                
    }
    
    
    /**
     * draw greek letter Sigma
     * 
     * @param rads completed rads of dial
     * @param diam1 current diameter of first spiral line
     * @param diam2 current diameter of second spiral line
     */
    void drawSigma(float rads, float diam1, float diam2) {
      // distance from the first spiral line
        float dist1 = diam1 + (diameter2 - diameter1) / 3;
        // distance from the second spiral line
        float dist2 = diam2 - (diameter2 - diameter1) / 3;
        // distance from the current block line
        float varOfRads1 = calculateVariationOfNextLine() / 3;
        float varOfRads2 = calculateVariationOfNextLine() / 8;
        float x1 = cx + (dist1) * cos(radians(rads + varOfRads1));
        float y1 = cy + (dist1) * sin(radians(rads + varOfRads1));
        float x2 = cx + (dist1) * cos(radians(rads + varOfRads2));
        float y2 = cy + (dist1) * sin(radians(rads + varOfRads2));
        float x3 = cx + (dist2) * cos(radians(rads + varOfRads1));
        float y3 = cy + (dist2) * sin(radians(rads + varOfRads1));
        float x4 = cx + (dist2) * cos(radians(rads + varOfRads2));
        float y4 = cy + (dist2) * sin(radians(rads + varOfRads2));
        float Xm1 = (x1 +x2 + x3 + x4 ) / 4 ;
        float Ym1 = (y1 + y2 + y3+ y4)/ 4 ;
        line(x1, y1, x2, y2);
        line(x3, y3, x4, y4);
        line(Xm1, Ym1, x2, y2);
        line(Xm1, Ym1, x4, y4);
    }
    
    /**
     * draw dial of Exeligmos
     * 
     * @param centx x - coordinate of dial's center
     * @param centy y - coordinate of dial's center
     * @param diameter diameter of dial
     */
    void drawExeligmos(float centx, float centy, float diameter) {
        beginShape();
        ellipse(centx, centy, diameter / 2, diameter / 2);
        line(centx, centy, centx + (diameter / 4) * cos(radians(90)),
          centy + (diameter / 4) * sin(radians(90)));
        line(centx, centy, centx+ (diameter / 4) * cos(radians(225)),
          centy + (diameter / 4) * sin(radians(225)));
        line(centx, centy, centx + (diameter / 4) * cos(radians(315)),
          centy + (diameter / 4) * sin(radians(315)));
        endShape();
    }
    
    
    /**
     * get the months for confirmed or hypothetical lunar and solar eclipses
     * 
     * @param type type of eclipse(solar/lunar, hypothetical/confirmed)
     * @return an array of months when eclipses are occured
     */
    int[] getMonthsOfEclipses(String type) {
        if(type.equals("lunar")) {
            int[] months = {2, 8, 14, 73, 84, 90, 96, 102, 108, 143, 149, 155,
                              161, 167, 196, 202, 208, 214, 219};
            return months;
        } else if(type.equals("hypothetical of lunar")) {
            int[] months = {20, 26, 67, 73, 114, 119, 120, 125, 131, 137, 172, 178, 184, 190};
            return months;
        } else if(type.equals("sun")) {
            int[] months = {8, 84, 90, 102, 107, 154, 166, 201, 207, 213, 219};
            return months;
        } else {  
            int[] months = {13, 25, 72, 78, 125, 131, 137, 172, 178, 184};
            return months;
        }
                
    }
    
    /**
     * Draw letters(Sigma for lunar eclipses or Eta for solar eclipses) on the
     * appropriate block of dial. The red colored letters are for the hypothetical
     * eclipses and black colored are for the confirmed eclipses by the archaeologists
     * 
     * @param colour color of letters
     * @param eclipse type of eclipse(lunar/solar)
     * @param month current block which represents a month
     * @param monthOfEclipses array of months of eclipses
     * @param rads completed rads of dial
     * @param diam1 current diameter of first spiral line
     * @param diam2 current diameter of second spiral line
     */
    void drawGlyphs(String colour, String eclipse, int month, int[] monthOfEclipses,
      float rads, float diam1, float diam2) {
         boolean contin = true;
         int i = 0;
         if(colour.equals("red"))
             stroke(200, 0, 0);
         else
             stroke(0);    
         while(i < monthOfEclipses.length && contin) {
              if(month == monthOfEclipses[i]) {
                  contin = false;
                  if(eclipse.equals("lunar")) 
                      drawSigma(rads, diam1,  diam2);
                  else
                      drawEta(rads, diam1,  diam2);   
              }
              i++;
         }
    }
    
    void drawLines() {
        float rad1 = diameter1;
        float rad2 = diameter2;
        int  j = 0;
        for(int i = 0; i < circles - 1; i++) {
            float variation = 0;
            int[] indexes = new int[2];
            // define the points where the line begins and ends
            indexes = beginAndEndIndexes(i, "lines");
            for(float n = indexes[0]; n < indexes[1]; n = n + calculateVariationOfNextLine()) {
                float x1 = cx + (diameter1 + i* distance + variation) * cos(radians(n));
                float y1 = cy + (diameter1 + i* distance + variation) * sin(radians(n));
                float x2 = cx + (diameter2 + i* distance + variation) * cos(radians(n));
                float y2 = cy + (diameter2 + i* distance + variation) * sin(radians(n));
                if(n > 270 && n < 360) {
                    variation = variation + getVariationOfDiameter(calculateVariationOfNextLine()) - 0.2;
                    rad1+=3;
                    rad2+=3;
      
                }
                stroke(0);
                line(x1, y1, x2, y2);
                j++;
                float rd1 = diameter1 + i* distance + variation;
                float rd2 = diameter2 + i* distance + variation;
                // get months of all types of eclipses
                int[] lunarEclipses = getMonthsOfEclipses("lunar");
                int[] sunEclipses = getMonthsOfEclipses("sun");
                int[] hypotheticalLunarEclipses = getMonthsOfEclipses("hypothetical of lunar");
                int[] hypotheticalSunEclipses = getMonthsOfEclipses("hypothetical of sun");
                // draw all letters on the appropriate dial's blocks
                drawGlyphs("red", "lunar", j, hypotheticalLunarEclipses, n, rd1, rd2);
                drawGlyphs("black", "lunar", j, lunarEclipses, n, rd1, rd2);
                drawGlyphs("red", "sun", j, hypotheticalSunEclipses, n, rd1, rd2);
                drawGlyphs("black", "sun", j, sunEclipses, n, rd1, rd2);
                
            }
        }  
    }
    
    /**
     * move Exeligmos pointer based on the total rads it has completed
     * 
     * @param rads total rads that the pointer has completed
     */
    void moveExeligmosPointer(float rads) {
        float diameterOfPointer = diameter1 / 2;
        drawPointer(cx + diameter1 / 2,  cy - diameter1 / 2, diameterOfPointer, rads, "right");      
    }
    
    /**
     * Move Saros pointer based on the total rads it has completed.
     * Diameter of pointer is increased accordingly to the point of dial it shows.
     * 
     * @param rads total rads that the pointer has completed
     */
    void moveSarosPointer(float rads) {
      // get number of pointer's full rotations
        int times = getTimes(rads);
        if(degrees(rads) > 275 + times * 360) {
            float variation = degrees(rads) - (275 + times * 360);
            float diameterOfPointer = 2 * (diameter1 + distance * times
                + getVariationOfDiameter(variation));
            drawPointer(cx,  cy, diameterOfPointer, rads, "right");
        } else {
            float diameterOfPointer = 2 * (diameter1 + distance * times);
            drawPointer(cx,  cy, diameterOfPointer, rads, "right");
        }
    }
}


