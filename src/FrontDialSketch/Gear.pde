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
