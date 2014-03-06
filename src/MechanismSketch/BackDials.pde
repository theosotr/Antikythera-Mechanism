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
