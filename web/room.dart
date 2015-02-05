import "renderer.dart";

class Room implements Renderable {
  List _objects;
  
  Room(List objs) {
    this._objects = objs;
  }
}