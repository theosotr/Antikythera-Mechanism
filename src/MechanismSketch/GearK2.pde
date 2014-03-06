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
