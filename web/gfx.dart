library gfx;

import 'package:malison/malison.dart';
import 'dart:html' as html;
import 'dart:math';
import 'dart:async';
import 'dart:collection';

class Gfx {

  RetroTerminal _terminal;
  html.CanvasElement _canvas;

  Gfx(int width, int height) {

    _canvas = new html.CanvasElement();
    html.document.body.children.add(_canvas);

    html.window.onClick.listen((event) => _canvas.requestFullscreen());
    

    // Create a new terminal. CanvasTerminal uses your browser's fonts.
    // RetroTerminal uses a built in DOS-style Code Page 437 font.
    _terminal = new RetroTerminal.shortDos(width, height, this._canvas);
    
    // Position in dom
    _canvas.style.top = '50%';
    _canvas.style.left = '50%';
    _canvas.style.position = 'absolute';
    _canvas.style.marginLeft = (0 - _canvas.clientWidth / 2).toString() + "px";
    _canvas.style.marginTop = (0 - _canvas.clientHeight / 2).toString() + "px";

  }

  // TEST LINE FUNCTION IMPLEMENT THIS SOMEWHERE ELSE LOL; Also this was originall JS
  // http://www.codeproject.com/Articles/16564/Drawing-lines-in-Mozilla-based-browsers-and-the-In
  void drawEdge(_Edge edge) {

    var x1 = edge.v1.x,
        y1 = edge.v1.y,
        x2 = edge.v2.x,
        y2 = edge.v2.y;

    var dx = x2 - x1;
    var sx = 1;
    var dy = y2 - y1;
    var sy = 1;

    if (dx < 0) {
      sx = -1;
      dx = -dx;
    }
    if (dy < 0) {
      sy = -1;
      dy = -dy;
    }

    dx = dx << 1;
    dy = dy << 1;
    _terminal.writeAt(x1, y1, "*");
    if (dy < dx) {
      var fraction = dy - (dx >> 1);
      while (x1 != x2) {
        if (fraction >= 0) {
          y1 += sy;
          fraction -= dx;
        }
        fraction += dy;
        x1 += sx;
        _terminal.writeAt(x1, y1, "*");
      }
    } else {
      var fraction = dx - (dy >> 1);
      while (y1 != y2) {
        if (fraction >= 0) {
          x1 += sx;
          fraction -= dy;
        }
        fraction += dx;
        y1 += sy;
        _terminal.writeAt(x1, y1, "*");
      }
    }
  }

  void drawLine(x1, y1, x2, y2) {
    drawEdge(new _Edge(new Point(x1, y1), new Point(x2, y2)));
  }

  void drawPolygon(List<Point> points, [bool fill]) {
    assert(points.length >= 3);

    _Polygon poly = new _Polygon.fromPoints(points);
    for (var i = 0; i < poly.edges.length; i++) {
      drawEdge(poly.edges[i]);
    }

    if (fill != null && fill) {

      List<_Edge> sortedEdges = [];
      sortedEdges = poly.edges;

    }

    return;
  }

  void drawRect(x1, y1, x2, y2, x3, y3, x4, y4) {
    drawEdge(new _Edge(new Point(x1, y1), new Point(x2, y2)));
    drawEdge(new _Edge(new Point(x2, y2), new Point(x3, y3)));
    drawEdge(new _Edge(new Point(x3, y3), new Point(x4, y4)));
    drawEdge(new _Edge(new Point(x4, y4), new Point(x1, y1)));
  }
  
  // TODO: COMPENSATE FOR WORD WRAP
  void slowText(String text) {
    this.clear();
    
    Point center = new Point(5,5);
    
    printChar(x, y, String text, i) {
      if(i == text.length - 1) {
        _terminal.writeAt(x + i, y, text.substring(i));
        this.render();
      } else {
        _terminal.writeAt(x + i, y, text.substring(i, i+1));
        this.render();
        new Timer(const Duration(milliseconds: 100), () => printChar(x, y, text, i+1));
      }
      
    }
    printChar(center.x, center.y, text, 0);
        
    this.render();
  
    
//    new Timer(const Duration(milliseconds: 100), () => slowText(x,y,i+1));

  }
  
  void clear() {
    _terminal.clear();
  }
  
  void render() {
    _terminal.render();
  }

}

class _Edge implements Comparable {
  Point _v1, _v2;

  int _minY, _minYX, _maxY;
  double _slope;


  Point get v1 => this._v1;
  Point get v2 => this._v2;
  int get minY => this._minY;
  int get minYX => this._minYX;
  int get maxY => this._maxY;
  double get slope => this._slope;

  _Edge(Point v1, Point v2)
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

}

class _Polygon {

  List<_Edge> _edges = [];

  List<_Edge> get edges => this._edges;

  // Constructors
  _Polygon.fromEdges(List<_Edge> edges) : this._edges = edges;

  _Polygon.fromPoints(List<Point> points) {
    for (var i = 0; i < points.length; i++) {
      Point v1 = points[i];
      Point v2 = (i < points.length - 1) ? points[i + 1] : points[0];
      _edges.add(new _Edge(v1, v2));
    }
  }

}
