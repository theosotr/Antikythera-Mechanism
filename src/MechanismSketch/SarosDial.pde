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
