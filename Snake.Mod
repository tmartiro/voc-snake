MODULE Snake;
IMPORT SYSTEM, Raylib, Out, Math, Strings, VT100;

TYPE
  pTSnake= POINTER TO TSnake;
  TSnake = RECORD
    color: Raylib.TColor;
    pos: Raylib.TVector2;
    size: Raylib.TVector2;
    len: INTEGER;
    tail: ARRAY 256 OF Raylib.TVector2;
  END;
  pTRabbit = POINTER TO TRabbit;
  TRabbit = RECORD
    color: Raylib.TColor;
    pos: Raylib.TVector2;
    size: Raylib.TVector2;

    END;

CONST
  title = "Vishap";

VAR
  ScreenWidth: INTEGER;
  ScreenHeight: INTEGER;
  BgColor: Raylib.TColor;
  SnakePos: Raylib.TVector2;
  DeltaPos: Raylib.TVector2;
  Velocity: REAL;
  Snake: pTSnake;
  Rabbit: pTRabbit;
  Score: ARRAY 256 OF CHAR;

PROCEDURE NewRabbit():pTRabbit;
VAR
 r: pTRabbit;
BEGIN
  NEW(r);
  r.color.r := 0FFX;
  r.color.g := 0X;
  r.color.b := 0AAX;
  r.color.a := 0FFX;
  r.size.x := 15.0;
  r.size.y := 15.0;
  r.pos.x := SYSTEM.VAL(REAL, Raylib.GetRandomValue(0, ScreenWidth));
  r.pos.y := SYSTEM.VAL(REAL, Raylib.GetRandomValue(0, ScreenHeight));
  RETURN r;
END NewRabbit;


PROCEDURE NewSnake():pTSnake;
VAR
 s: pTSnake;
BEGIN
  NEW(s);
  s.color.r := 0X;
  s.color.g := 0FFX;
  s.color.b := 0X;
  s.color.a := 0FFX;
  s.size.x := 25.0;
  s.size.y := 25.0;
  s.pos.x := 0;
  s.pos.y := 100;
  s.len := 0;
  RETURN s;
END NewSnake;

PROCEDURE DrawSnake(s:pTSnake);
VAR
  i:INTEGER;
BEGIN
  FOR i:= 0 TO s.len DO
    Raylib.DrawRectangleV(s.tail[i], s.size, s.color);
  END;
  Raylib.DrawRectangleV(s.pos, s.size, s.color);
END DrawSnake;

PROCEDURE DrawRabbit(r:pTRabbit);
VAR
  earpos : Raylib.TVector2;
  earsize: Raylib.TVector2;
BEGIN
  (* draw ears *)
  earpos.x := r.pos.x + 2; earpos.y := r.pos.y - 4;
  earsize.x := r.size.x/6; earsize.y := r.size.y/3;
  Raylib.DrawRectangleV(earpos, earsize, r.color);
  earpos.x := r.pos.x + r.size.x/1.5;
  Raylib.DrawRectangleV(earpos, earsize, r.color);
  (* draw body *)
  Raylib.DrawRectangleV(r.pos, r.size, r.color);
END DrawRabbit;


PROCEDURE Eat(S:pTSnake; R:pTRabbit);
VAR
X: REAL;
Y: REAL;
BEGIN
  IF (R.pos.x < S.pos.x+S.size.x) & (R.pos.x+R.size.x > S.pos.x) & (R.pos.y < S.pos.y+S.size.y) & (R.pos.y + R.size.y > S.pos.y ) THEN
    X:= Math.round(SYSTEM.VAL(REAL, Raylib.GetRandomValue(0, ScreenWidth-100)) / 5.0) * 5.0;
    Y:= Math.round(SYSTEM.VAL(REAL, Raylib.GetRandomValue(0, ScreenHeight-100)) / 5.0) * 5.0;
    R.pos.x := X+(R.size.x/2);
    R.pos.y := Y+(R.size.y/2);
    S.len := S.len + 1;
  END;
END Eat;

PROCEDURE HandleControls();
VAR
  i:INTEGER;
BEGIN
      IF (Raylib.IsKeyPressed(Raylib.KeyDown)) & (DeltaPos.y # -1.0*Velocity) THEN
        DeltaPos.x := 0.0; DeltaPos.y := 1.0*Velocity;
      ELSIF (Raylib.IsKeyPressed(Raylib.KeyUp)) & (DeltaPos.y # 1.0*Velocity) THEN
        DeltaPos.x := 0.0; DeltaPos.y := -1.0*Velocity;
      ELSIF (Raylib.IsKeyPressed(Raylib.KeyRight)) & (DeltaPos.x # -1.0*Velocity) THEN
        DeltaPos.x := 1.0*Velocity; DeltaPos.y := 0.0;
      ELSIF (Raylib.IsKeyPressed(Raylib.KeyLeft)) & (DeltaPos.x # 1.0 *Velocity) THEN
        DeltaPos.x := -1.0*Velocity; DeltaPos.y := 0.0;
      END;

      (* Tail *)
      FOR i := Snake.len TO 0 BY -1 DO
        IF i = 0 THEN
          Snake.tail[0] := Snake.pos;
        ELSE
          Snake.tail[i] := Snake.tail[i - 1];
        END;
      END;


      (* Head *)
      Snake.pos.x := Snake.pos.x + DeltaPos.x;
      Snake.pos.y := Snake.pos.y + DeltaPos.y;

      IF Snake.pos.x > ScreenWidth THEN
        Snake.pos.x := 0
      ELSIF Snake.pos.x < 0 THEN
        Snake.pos.x := ScreenWidth;
      END;

      IF Snake.pos.y > ScreenHeight THEN
        Snake.pos.y := 0;
      ELSIF Snake.pos.y < 0 THEN
        Snake.pos.y := ScreenHeight;
      END;
END HandleControls;


BEGIN
  ScreenWidth := 800;
  ScreenHeight:= 600;
  BgColor.r := 0X;
  BgColor.g := 0X;
  BgColor.b := 0X;
  BgColor.a := 0FFX;


  Velocity := 5;
  DeltaPos.x := 1 * Velocity;
  DeltaPos.y := 0;

  Raylib.SetRandomSeed(0FAAH);



  Snake := NewSnake();
  Rabbit := NewRabbit();

  Raylib.InitWindow(ScreenWidth, ScreenHeight, title);
  Raylib.SetTargetFPS(60);

  WHILE ~Raylib.WindowShouldClose() DO
    Raylib.BeginDrawing();
    Raylib.ClearBackground(BgColor);
    VT100.IntToStr(Snake.len, Score);
    Raylib.DrawText(Score,0,0,30,Snake.color);
    HandleControls();
    DrawSnake(Snake);
    DrawRabbit(Rabbit);
    Eat(Snake, Rabbit);
    Raylib.EndDrawing();
  END;

  Raylib.CloseWindow();

END Snake.

