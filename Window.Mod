MODULE Window;
IMPORT SYSTEM, Raylib, Out;

CONST
  title = "Oberon";

VAR
  ScreenWidth: INTEGER;
  ScreenHeight: INTEGER;
  BgColor: Raylib.TColor;
  SnakePos: Raylib.TVector2;
  DeltaPos: Raylib.TVector2;
  Velocity: REAL;

PROCEDURE DrawSnake(pos:Raylib.TVector2);
VAR
  color: Raylib.TColor;
  size : Raylib.TVector2;
BEGIN
  (* color of snake *)
  color.r := 0FFX; color.g := 0X; color.b := 0X; color.a := 0FFX;

  (* size of snake *)
  size.x := 50.0; size.y := 50.0;

  Raylib.DrawRectangleV(pos, size, color);
END DrawSnake;

BEGIN
  ScreenWidth := 800;
  ScreenHeight:= 600;
  BgColor.r := 0X;
  BgColor.g := 0X;
  BgColor.b := 0X;
  BgColor.a := 0FFX;
  SnakePos.x := 0;
  SnakePos.y := SYSTEM.VAL(REAL, (ScreenHeight DIV 2));
  Velocity := 3.0;
  DeltaPos.x := 1*Velocity;
  DeltaPos.y := 0;

  Raylib.InitWindow(ScreenWidth, ScreenHeight, title);
  Raylib.SetTargetFPS(60);

  WHILE ~Raylib.WindowShouldClose() DO
    Raylib.BeginDrawing();

      Raylib.ClearBackground(BgColor);

      IF Raylib.IsKeyPressed(Raylib.KeyDown) THEN
        DeltaPos.x := 0.0; DeltaPos.y := 1.0*Velocity;
      ELSIF Raylib.IsKeyPressed(Raylib.KeyUp) THEN
        DeltaPos.x := 0.0; DeltaPos.y := -1.0*Velocity;
      ELSIF Raylib.IsKeyPressed(Raylib.KeyRight) THEN
        DeltaPos.x := 1.0*Velocity; DeltaPos.y := 0.0;
      ELSIF Raylib.IsKeyPressed(Raylib.KeyLeft) THEN
        DeltaPos.x := -1.0*Velocity; DeltaPos.y := 0.0;
      END;

      SnakePos.x := SnakePos.x + DeltaPos.x; SnakePos.y := SnakePos.y + DeltaPos.y;

      DrawSnake(SnakePos);


    Raylib.EndDrawing();
  END;

  Raylib.CloseWindow();





END Window.

