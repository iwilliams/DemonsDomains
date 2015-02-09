library dd.point;

class Point {
  
  int x,
      y;
  
  
  Point([int x, int y]): this.x = x, this.y = y;
  
  String toString() {
    return this.x.toString() + ", " + this.y.toString();
  }
  
}