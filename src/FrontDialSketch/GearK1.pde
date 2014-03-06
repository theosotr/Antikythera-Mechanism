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
