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
