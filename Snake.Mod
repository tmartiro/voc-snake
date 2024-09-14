MODULE Snake;
IMPORT SYSTEM, Raylib, Out, Math, Strings, VT100;

TYPE
  (* pTSnake= POINTER TO TSnake; *)
  TSnake = RECORD
    color: Raylib.TColor;
    pos: Raylib.TVector2;
    size: Raylib.TVector2;
    len: INTEGER;
    tail: ARRAY 256 OF Raylib.TVector2;
  END;
  (* pTRabbit = POINTER TO TRabbit; *)
  TRabbit = RECORD
    color: Raylib.TColor;
    pos: Raylib.TVector2;
    size: Raylib.TVector2;

    END;

CONST
  title = "Vishap";

VAR
  BgColor: Raylib.TColor;
  SnakePos: Raylib.TVector2;
  DeltaPos: Raylib.TVector2;
  Velocity: REAL;
  Snake: TSnake;
  Rabbit: TRabbit;
  Score: ARRAY 256 OF CHAR;

PROCEDURE NewRabbit(VAR r:TRabbit);
BEGIN
  r.color.r := 0FFX;
  r.color.g := 0X;
  r.color.b := 0AAX;
  r.color.a := 0FFX;
  r.size.x := 15.0;
  r.size.y := 15.0;
  r.pos.x := SYSTEM.VAL(REAL, Raylib.GetRandomValue(0, Raylib.GetScreenWidth()));
  r.pos.y := SYSTEM.VAL(REAL, Raylib.GetRandomValue(0, Raylib.GetScreenHeight()));
END NewRabbit;


PROCEDURE NewSnake(VAR s: TSnake);
BEGIN
  (* NEW(s); *)
  s.color.r := 0X;
  s.color.g := 0FFX;
  s.color.b := 0X;
  s.color.a := 0FFX;
  s.size.x := 25.0;
  s.size.y := 25.0;
  s.pos.x := 0;
  s.pos.y := 100;
  s.len := 0;
END NewSnake;

PROCEDURE DrawSnake(VAR s:TSnake);
VAR
  i:INTEGER;
BEGIN
  FOR i:= 0 TO s.len DO
    Raylib.DrawRectangleV(s.tail[i], s.size, s.color);
  END;
  Raylib.DrawRectangleV(s.pos, s.size, s.color);
END DrawSnake;

PROCEDURE DrawRabbit(VAR r:TRabbit);
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


PROCEDURE Eat(VAR S:TSnake; VAR R:TRabbit);
VAR
X: REAL;
Y: REAL;
BEGIN
  IF (R.pos.x < S.pos.x+S.size.x) & (R.pos.x+R.size.x > S.pos.x) & (R.pos.y < S.pos.y+S.size.y) & (R.pos.y + R.size.y > S.pos.y ) THEN
    X:= Math.round(SYSTEM.VAL(REAL, Raylib.GetRandomValue(0, Raylib.GetScreenWidth()-100)) / 5.0) * 5.0;
    Y:= Math.round(SYSTEM.VAL(REAL, Raylib.GetRandomValue(0, Raylib.GetScreenHeight()-100)) / 5.0) * 5.0;
    R.pos.x := X+(R.size.x/2);
    R.pos.y := Y+(R.size.y/2);
    S.len := S.len + 1;
  END;
END Eat;

PROCEDURE HandleControls(VAR s:TSnake);
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
      FOR i := s.len TO 0 BY -1 DO
        IF i = 0 THEN
          s.tail[0] := s.pos;
        ELSE
          s.tail[i] := s.tail[i - 1];
        END;
      END;


      (* Head *)
      s.pos.x := s.pos.x + DeltaPos.x;
      s.pos.y := s.pos.y + DeltaPos.y;

      IF s.pos.x > Raylib.GetScreenWidth() THEN
        s.pos.x := 0
      ELSIF s.pos.x < 0 THEN
        s.pos.x := Raylib.GetScreenWidth();
      END;

      IF s.pos.y > Raylib.GetScreenHeight() THEN
        s.pos.y := 0;
      ELSIF s.pos.y < 0 THEN
        s.pos.y := Raylib.GetScreenHeight();
      END;
END HandleControls;

PROCEDURE Update*();
BEGIN
    Raylib.BeginDrawing();
    Raylib.ClearBackground(BgColor);
    VT100.IntToStr(Snake.len, Score);
    Raylib.DrawText(Score,0,0,30,Snake.color);
    HandleControls(Snake);
    DrawSnake(Snake);
    DrawRabbit(Rabbit);
    Eat(Snake, Rabbit);
    Raylib.EndDrawing();
END Update;


PROCEDURE Init*();
VAR
  addr: SYSTEM.ADDRESS;
BEGIN
  BgColor.r := 0X;
  BgColor.g := 0X;
  BgColor.b := 0X;
  BgColor.a := 0FFX;
  Velocity := 5;
  DeltaPos.x := 1 * Velocity;
  DeltaPos.y := 0;
  Raylib.SetRandomSeed(0FAAH);
  NewSnake(Snake);
  NewRabbit(Rabbit);
  Raylib.InitWindow(800, 600, title);
  Raylib.SetTargetFPS(60);
  (* go fullscreen with native resolution *)
  (* Raylib.ToggleFullscreen(); *)
END Init;


BEGIN

  Init();

  (* Game objects - heap allocated *)

  WHILE ~Raylib.WindowShouldClose() DO
    Update();
  END;

  Raylib.CloseWindow();

END Snake.

