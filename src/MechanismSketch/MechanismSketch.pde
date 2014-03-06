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
    searchGraph(35, variation);    
      
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





