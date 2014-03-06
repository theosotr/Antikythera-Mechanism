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
