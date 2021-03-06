﻿class GUI
{
	static Init := GUI.GUI()
	static x := 0, y := 0, w := A_ScreenWidth, h := A_ScreenHeight
	
	GUI()
	{
		Gui, new
		Gui +LastFound -Caption
		GUI.hWnD := WinExist()
		GUI.hDC  := DllCall("GetDC", "ptr",GUI.HWND ,"ptr")
		WinSet, Style, +0x04000000,% "ahk_id " . GUI.HWND
		WinSet, Style, +0x02000000,% "ahk_id " . GUI.HWND
		VarSetCapacity(pfd, 40, 0)
		NumPut(40, pfd, 0, "short")
		NumPut(1, pfd, 2, "short")
		NumPut(0x25, pfd, 4, "uint")
		NumPut(24, pfd, 9, "uchar")
		NumPut(0, pfd, 16, "uchar")
		NumPut(32, pfd, 18, "uchar")
		NumPut(24, pfd, 23, "uchar")
		NumPut(8, pfd, 24, "uchar")
		pf := DllCall("ChoosePixelFormat", "ptr", GUI.hDC, "ptr", &pfd, "int")
		DllCall("SetPixelFormat", "ptr", GUI.hDC, "int", pf, "ptr", &pfd)
		GUI.hRC := GL.wCreateContext(GUI.hDC)
		GL.wMakeCurrent(GUI.hDC,GUI.hRC)
	}
	
	Show()
	{
		Gui,Show, % "x" . GUI.x . " y" . GUI.y . " w" . GUI.w . " h" . GUI.h
		GUI.UpdateViewport()
	}
	
	UpdateViewport()
	{

		GL.Viewport(GUI.x,GUI.y,GUI.w,GUI.h)
		GL.MatrixMode(GL.Projection)
		GL.LoadIdentity()
		Cam.ApplyProjectionMatrix(GUI.w/GUI.h)
		GL.MatrixMode(GL.Modelview)
	}
	
	SwapBuffers()
	{
		DllCall("gdi32\SwapBuffers","UInt",GUI.hDC)
	}
	OnExit()
	{
		GUIClose:
		GUI,Destroy
		GUI.OnExit.Call()
		return
	}
	IsActive()
	{
		return (WinActive("A")==GUI.hWnD)
	}
}
