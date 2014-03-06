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
