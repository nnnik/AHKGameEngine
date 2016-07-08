#Include GL.ahk
#Include GLCamera.ahk
#Include GLGUI.ahk
#Include 3DMatrix.ahk
#Include GLDrawData.ahk
#Include AHKEngine.ahk

#Persistent
SetBatchLines,-1
SetMouseDelay,-1

TriangleCount := 1000

Triangle := new DrawObject()
Triangle.Begin(GL.Triangles)
Triangle.Scale(10,10,1)
Triangle.Rotate(120,0,0,1)
Triangle.Color(0x00FF00)
Triangle.Vector([0,1,0])
Triangle.Rotate(120,0,0,1)
Triangle.Color(0xFF0000)
Triangle.Vector([0,1,0])
Triangle.Rotate(120,0,0,1)
Triangle.Color(0x0000FF)
Triangle.Vector([0,1,0])
Triangle.End()
Triangle.Finish()
Triangle.Compile()

Loop % TriangleCount
	World.Add(0,0,-A_Index*5,Triangle)

Engine.SetZFunc()
Engine.SetCam()
Engine.SetFPS(60)
Engine.SetInputFunc("UpdateInput")
Engine.Start()

Space::Engine.Toggle()
esc::Engine.Shutdown()



UpdateInput()
{
	static init
	if !init
	{
		MouseMove,A_ScreenWidth/2,A_ScreenHeight/2,0
		init := 1
		DllCall("ShowCursor","UInt",0)
	}
	MouseGetPos,newX,newY
	MouseMove,A_ScreenWidth/2,A_ScreenHeight/2,0
	Cam.LocalMove((GetKeyState("w")-GetKeyState("s"))*0.2,0,(GetKeyState("a")-GetKeyState("d"))*0.2)
	Cam.Rotate((newX-A_ScreenWidth/2)/24,(newY-A_ScreenHeight/2)/24)
}