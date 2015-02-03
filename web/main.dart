// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

//import 'package:lison/malison.dart';
import 'package:piecemeal/piecemeal.dart';
import 'dart:async';
import 'dart:html';
import 'dart:collection';

import 'gfx.dart';

void main() {
  // Create or query a <canvas> element to bind it to.
//  var canvas = new CanvasElement();
//  document.body.children.add(canvas);

  var width = 120,
      height = 50;

  var g = new Gfx(width, height);

  // Create a new terminal. CanvasTerminal uses your browser's fonts.
  // RetroTerminal uses a built in DOS-style Code Page 437 font.
//  var terminal = new RetroTerminal.shortDos(width, height, canvas);

  // You can draw strings at given positions.
//  terminal.writeAt(0, 0, "This is a terminal!");

//  for (var y = 0; y < height; y++) {
//    for (var x = 0; x < width; x++) {
//      if (y == 0 || y == height - 1) {
//        terminal.writeAt(x, y, "*", Color.DARK_GOLD, Color.DARK_PURPLE);
//      } else if (x == 0 || x == width - 1) {
//        terminal.writeAt(x, y, "*", Color.DARK_GOLD, Color.DARK_PURPLE);
//      }
//    }
//  }
  // You can control the foreground and background color.
  //terminal.writeAt(0, 1, "This is blue on green", Color.BLUE, Color.GREEN);


  //g.drawLine(0, 0, 100, 30);
  //g.drawRect(0, 0, width-1, 0, width-1, height-1, 0, height-1);
  //g.drawRect(0, height - 1 - (height~/4), width-1, height - 1 - (height~/4), width-1, height-1, 0, height-1);

  Queue dialog = new Queue();
  dialog.addFirst("You stand at the precipice of a cavernous maw...");
  dialog.addFirst("A thick silver fog billows out from below...");
  dialog.addFirst("In the myasma you see your reflection...");
  
  window.onKeyPress.listen((KeyboardEvent event) {
    KeyEvent keyEvent = new KeyEvent.wrap(event);
    if (keyEvent.keyCode == KeyCode.ENTER) {
      if(dialog.isNotEmpty) {
        g.clear();
        g.slowText(dialog.removeLast());
//        g.slowText('Test');
      }
    }
  });


  int farWallWidth = 65;
  int farWallHeight = 30;


  // Front Wall
  Point frontTopLeft = new Point(((width - 1) - farWallWidth) ~/ 2, ((height - 2) - farWallHeight) ~/ 2);
  Point frontTopRight = new Point(frontTopLeft.x + farWallWidth, frontTopLeft.y);
  Point frontBottomRight = new Point(frontTopRight.x, frontTopLeft.y + farWallHeight);
  Point frontBottomLeft = new Point(frontTopLeft.x, frontBottomRight.y);

  g.drawPolygon([frontTopLeft, frontTopRight, frontBottomRight, frontBottomLeft]);


  // Left Wall
  Point leftTopLeft = new Point(0, 0);
  Point leftTopRight = frontTopLeft;
  Point leftBottomRight = frontBottomLeft;
  Point leftBottomLeft = new Point(0, height - 1);

  g.drawPolygon([leftTopLeft, leftTopRight, leftBottomRight, leftBottomLeft], true);

  // Top Wall

  Point topTopLeft = leftTopLeft;
  Point topTopRight = new Point(width - 1, 0);
  Point topBottomRight = frontTopRight;
  Point topBottomLeft = frontTopLeft;

  // Right Wall
  Point rightTopLeft = topBottomRight;
  Point rightTopRight = topTopRight;
  Point rightBottomRight = new Point(width - 1, height - 1);
  Point rightBottomLeft = frontBottomRight;

  g.drawPolygon([rightTopLeft, rightTopRight, rightBottomRight, rightBottomLeft]);

  g.drawPolygon([topTopLeft, topTopRight, topBottomRight, topBottomLeft]);


  // Far door
  var doorWidth = farWallWidth ~/ 3.5;
  var doorHeight = farWallHeight ~/ 1.8;

  Point frontDoorTopLeft = new Point((farWallWidth - doorWidth) ~/ 2 + frontTopLeft.x, frontBottomLeft.y - doorHeight);
  Point frontDoorTopRight = new Point(frontDoorTopLeft.x + doorWidth, frontDoorTopLeft.y);
  Point frontDoorBottomRight = new Point(frontDoorTopRight.x, frontBottomRight.y);
  Point frontDoorBottomLeft = new Point(frontDoorTopLeft.x, frontDoorBottomRight.y);

  g.drawPolygon([frontDoorTopLeft, frontDoorTopRight, frontDoorBottomRight, frontDoorBottomLeft]);

  //  g.terminal.writeAt(0, 37, "LIFE: ", Color.WHITE);
//  g.terminal.drawGlyph(6, 37, new Glyph.fromCharCode(CharCode.BLACK_HEART_SUIT, Color.RED));
//  g.terminal.drawGlyph(7, 37, new Glyph.fromCharCode(CharCode.BLACK_HEART_SUIT, Color.RED));
//  g.terminal.drawGlyph(8, 37, new Glyph.fromCharCode(CharCode.BLACK_HEART_SUIT, Color.RED));

  // You can also draw individual glyphs -- character+color units.
//  terminal.drawGlyph(3, 4, new Glyph.fromCharCode(CharCode.BLACK_HEART_SUIT, Color.RED, Color.BLACK));
//
//  terminal.drawGlyph(10, 10, new Glyph.fromCharCode(CharCode.PI, Color.AQUA));

//  var testString = "Hello... Welcome to Demon's Dwelling...";
//  void slowText(x, y, i) {
//    if(i!=0) {
//      x = x+1;
//    }
//
//    terminal.writeAt(x, y, testString.substring(i, i+1));
//    terminal.render();
//
//    if(i < testString.length -1){
//      new Timer(const Duration(milliseconds: 100), () => slowText(x,y,i+1));
//    }
//  }
//
//  slowText(3, 7, 0);

  // Use the rng
//  var r = new Rng(23).vecInRect(new Rect(0, 10, 10, 10));
//  terminal.writeAt(r.x, r.y, "X");

  // When you're done drawing, tell it to render all of the changes. It renders
  // in batches for performance.
//  terminal.render();

//  canvas.style.margin = "0 auto";
//  canvas.style.top = '50%';
//  canvas.style.left = '50%';
//  canvas.style.position = 'absolute';
//  canvas.style.marginLeft = (0 - canvas.clientWidth / 2).toString() + "px";
//  canvas.style.marginTop = (0 - canvas.clientHeight / 2).toString() + "px";




}
