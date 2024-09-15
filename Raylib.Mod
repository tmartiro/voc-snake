MODULE Raylib;

IMPORT SYSTEM;
CONST
    KeyA*               = 65;       (* Key: A | a *)
    KeyB*               = 66;       (* Key: B | b *)
    KeyC*               = 67;       (* Key: C | c *)
    KeyD*               = 68;       (* Key: D | d *)
    KeyE*               = 69;       (* Key: E | e *)
    KeyF*               = 70;       (* Key: F | f *)
    KeyG*               = 71;       (* Key: G | g *)
    KeyH*               = 72;       (* Key: H | h *)
    KeyI*               = 73;       (* Key: I | i *)
    KeyJ*               = 74;       (* Key: J | j *)
    KeyK*               = 75;       (* Key: K | k *)
    KeyL*               = 76;       (* Key: L | l *)
    KeyM*               = 77;       (* Key: M | m *)
    KeyN*               = 78;       (* Key: N | n *)
    KeyO*               = 79;       (* Key: O | o *)
    KeyP*               = 80;       (* Key: P | p *)
    KeyQ*               = 81;       (* Key: Q | q *)
    KeyR*               = 82;       (* Key: R | r *)
    KeyS*               = 83;       (* Key: S | s *)
    KeyT*               = 84;       (* Key: T | t *)
    KeyU*               = 85;       (* Key: U | u *)
    KeyV*               = 86;       (* Key: V | v *)
    KeyW*               = 87;       (* Key: W | w *)
    KeyX*               = 88;       (* Key: X | x *)
    KeyY*               = 89;       (* Key: Y | y *)
    KeyZ*               = 90;       (* Key: Z | z *)
    KeySpace*           = 32;       (* Key: Space *)
    KeyEscape*          = 256;      (* Key: Esc *)
    KeyEnter*           = 257;      (* Key: Enter *)
    KeyTab*             = 258;      (* Key: Tab *)
    KeyBackspace*       = 259;      (* Key: Backspace *)
    KeyInsert*          = 260;      (* Key: Ins *)
    KeyDelete*          = 261;      (* Key: Del *)
    KeyRight*           = 262;      (* Key: Cursor right *)
    KeyLeft*            = 263;      (* Key: Cursor left *)
    KeyDown*            = 264;      (* Key: Cursor down *)
    KeyUp*              = 265;      (* Key: Cursor up *)

TYPE
  TColor* = RECORD
    r*: CHAR;
    g*: CHAR;
    b*: CHAR;
    a*: CHAR;
  END;

  TVector2* = RECORD
    x*: REAL;
    y*: REAL;
  END;

  TRect* = RECORD
    x*: REAL;
    y*: REAL;
    width*: REAL;
    height*: REAL;
  END;



PROCEDURE -AinclRaylib*() '#include "./raylib/src/raylib.h"';
PROCEDURE -InitWindow*(width:LONGINT; height:LONGINT; title:ARRAY OF CHAR) "InitWindow(width,height,title)";
PROCEDURE -CloseWindow*() "CloseWindow()";
PROCEDURE -BeginDrawing*() "BeginDrawing()";
PROCEDURE -EndDrawing*() "EndDrawing()";
PROCEDURE -WindowShouldClose*():BOOLEAN "(bool)WindowShouldClose()";
PROCEDURE -SetTargetFPS*(fps:LONGINT) "SetTargetFPS(fps)";
PROCEDURE -GetColor*(hexValue:SET):SET "(Color)GetColor(hexValue)";
PROCEDURE -GetScreenWidth*():LONGINT "(int)GetScreenWidth()";
PROCEDURE -GetScreenHeight*():LONGINT "(int)GetScreenHeight()";
PROCEDURE -ToggleFullscreen*() "ToggleFullscreen()";
PROCEDURE -IsKeyPressed*(key:LONGINT):BOOLEAN "(bool)IsKeyPressed(key)";
PROCEDURE -GetFrameTime*():REAL "(float)GetFrameTime()";
PROCEDURE -GetRandomValue*(min:LONGINT; max:LONGINT):LONGINT "(int)GetRandomValue(min,max)";
PROCEDURE -SetRandomSeed*(seed:LONGINT) "SetRandomSeed(seed)";
PROCEDURE -GetTime*():REAL "(double)GetTime()";

PROCEDURE -colorInit(R:CHAR; G:CHAR; B:CHAR; A:CHAR):SET "(struct Color){ .r = R, .g = G, .b = B, .a = A }";
PROCEDURE -vector2Init(X:REAL; Y:REAL):INTEGER "(struct Vector2){ .x = X, .y = Y }";
PROCEDURE -rectInit(X:REAL; Y:REAL; W:REAL; H:REAL):INTEGER "(struct Rectangle){ .x = X, .y = Y, .width = W, .height = H }";
PROCEDURE -clearBackgroundR(color:SET) "ClearBackground(color)";
PROCEDURE -drawRectangleVR(pos:REAL; size:REAL; color:SET) "DrawRectangleV(pos,size,color)";
PROCEDURE -drawRectangleR(posx:LONGINT; posy:LONGINT; width:LONGINT; height:LONGINT; color:SET) "DrawRectangle(posx, posy, width, height, color)";
PROCEDURE -drawTextR(VAR text:ARRAY OF CHAR; posX:LONGINT; posY:LONGINT; fontSize:LONGINT; color:SET) "DrawText(text,posX,posY,fontSize,color)";



PROCEDURE DrawText*(text:ARRAY OF CHAR; posx:LONGINT; posy:LONGINT; fontSize:LONGINT; C:TColor);
BEGIN
  drawTextR(text,posx,posy,fontSize,colorInit(C.r, C.g, C.b, C.a));
END DrawText;

PROCEDURE DrawRectangle*(posx:LONGINT; posy:LONGINT; width:LONGINT; height:LONGINT; C:TColor);
BEGIN
  drawRectangleR(posx, posy, width, height, colorInit(C.r, C.g, C.b, C.a));
END DrawRectangle;


PROCEDURE DrawRectangleV*(pos:TVector2; size:TVector2; C:TColor);
BEGIN
  drawRectangleVR(vector2Init(pos.x, pos.y), vector2Init(size.y, size.y), colorInit(C.r, C.g, C.b, C.a));
END DrawRectangleV;


PROCEDURE ClearBackground*(C:TColor);
BEGIN
      clearBackgroundR(colorInit(C.r, C.g, C.b, C.a));
END ClearBackground;

END Raylib.
