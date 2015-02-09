library dd.line;
import "point.dart";

class Line implements Comparable {
  Point _v1, _v2;

  int _minY, _minYX, _maxY;
  double _slope;


  Point get v1 => this._v1;
  Point get v2 => this._v2;
  int get minY => this._minY;
  int get minYX => this._minYX;
  int get maxY => this._maxY;
  double get slope => this._slope;

  Line(Point v1, Point v2)
      : this._v1 = v1,
        this._v2 = v2 {

    if (this._v1.y < this._v2.y) {
      this._minY = _v1.y;
      this._minYX = _v1.x;
      this._maxY = _v2.y;
    } else {
      this._minY = _v2.y;
      this._minYX = _v2.x;
      this._maxY = _v1.y;
    }

    this._slope = (this._v1.y - this.v2.y) / (this._v1.x - this.v2.x);

  }

  int compareTo(_Edge) {
    return 1;
  }
  
  static Point intersectsPoints(Point a, Point b, Point e, Point f, [bool asSegment = true, Point result]) {

//    if (typeof asSegment === 'undefined') { asSegment = true; }
      if (result == null) {
        result = new Point(0, 0);
      }

      var a1 = b.y - a.y;
      var a2 = f.y - e.y;
      var b1 = a.x - b.x;
      var b2 = e.x - f.x;
      var c1 = (b.x * a.y) - (a.x * b.y);
      var c2 = (f.x * e.y) - (e.x * f.y);
      var denom = (a1 * b2) - (a2 * b1);
      
      if (denom == 0) {
        return null;
      }

      result.x = ((b1 * c2) - (b2 * c1)) ~/ denom;
      result.y = ((a2 * c1) - (a1 * c2)) ~/ denom;


      if (asSegment) {
        var uc = ((f.y - e.y) * (b.x - a.x) - (f.x - e.x) * (b.y - a.y));
        var ua = (((f.x - e.x) * (a.y - e.y)) - (f.y - e.y) * (a.x - e.x)) / uc;
        var ub = (((b.x - a.x) * (a.y - e.y)) - ((b.y - a.y) * (a.x - e.x))) / uc;
        if (ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1) {
          return result;
        } else {
          return null;
        }
      }

      return result;

    }

}
