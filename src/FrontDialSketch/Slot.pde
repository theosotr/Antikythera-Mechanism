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
