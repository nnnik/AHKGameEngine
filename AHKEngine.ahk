class Engine
{
	static CLEAR_BIT   := GL.COLOR_BUFFER_BIT
	static camModes    := {FPS:{Mode:"Frustrum"}}
	
	SetZFunc(zFunc="",clear="")
	{
		GL.Enable(GL.DEPTH_TEST)
		This.CLEAR_BIT := This.CLEAR_BIT|GL.DEPTH_BUFFER_BIT
		If (zFunc)
			GL.DepthFunc(GL[zFunc])
		If (clear!="")
			GL.ClearDepth(clear)
	}
	
	SetCam(mode="FPS")
	{
		Cam.Init(This.camModes[mode])
	}
	
	SetInputFunc(Fn)
	{
		If (IsFunc(Fn)&&(IsObject(Fn)||IsObject(Fn := Func(Fn))))
			This.UpdateInput := Fn
	}
	
	Start()
	{
		This.Start := 1
		GUI.Show()
		GUI.OnExit := Engine.Shutdown.Bind(Engine)
		SetTimer,Redraw,% (1000/This.fps)
	}
	
	Stop()
	{
		This.Start := 0
		SetTimer,Redraw, Off
	}
	
	Toggle()
	{
		return This.Start?This.Stop():This.Start()
	}
	
	Shutdown()
	{
		This.Stop()
		ExitApp,0
	}
	
	SetFps(fps)
	{
		This.fps := fps
		if (This.Start)
			SetTimer,Redraw,% (1000/This.fps)
	}
	
	DrawFrame()
	{
		Redraw:
		If GUI.IsActive()
		{
			Engine.UpdateInput.Call()
			GL.Clear(Engine.CLEAR_BIT)
			World.Draw()
			Gui.SwapBuffers()
		}
		return
	}
}
