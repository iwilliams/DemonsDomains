library renderer;

import 'gfx.dart';
import 'room.dart';

class Renderer {
  
  Gfx _g;
  
  Renderer(Gfx g) : this._g = g;
  
  void render(Renderable o) {
    switch (o.runtimeType) {
      case Room :
        break;
    }
  }
  
}

abstract class Renderable {
  
}