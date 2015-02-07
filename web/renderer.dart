library dd.renderer;

import 'gfx.dart';
import 'room.dart';
import 'ui.dart';

class Renderer {
  
  Gfx _g;
  
  Renderer(Gfx g) : this._g = g;
  
  void render(Renderable o) {
    switch (o.runtimeType) {
      case Room :
        break;
      case Ui :
        break;
    }
  }
  
}

abstract class Renderable {
  
}