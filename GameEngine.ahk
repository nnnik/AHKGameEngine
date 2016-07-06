class GL 
{
	static Init := GL.GL()
	
	static ALPHA_TEST := 0x0BC0, BLEND := 0x0BE2, TEXTURE_2D := 0x0DE1, DEPTH_TEST := 0x0B71, CULL_FACE := 0x0B44
	static SRC_ALPHA := 0x0302, ONE_MINUS_SRC_ALPHA := 0x0303
	static DONT_CARE := 0x1100, FASTEST := 0x1101, NICEST := 0x1102
	static NEVER := 0x0200, LESS := 0x0201,EQUAL := 0x0202, LEQUAL := 0x0203, GREATER := 0x0204, NOTEQUAL := 0x0205, GEQUAL := 0x0206, ALWAYS := 0x0207
	static COLOR_BUFFER_BIT := 0x4000, DEPTH_BUFFER_BIT := 0x100
	static MODELVIEW := 0x1700, PROJECTION := 0x1701
	static TEXTURE_MAG_FILTER := 0x2800, TEXTURE_MIN_FILTER := 0x2801
	static NEAREST := 0x2600, LINEAR := 0x2601
	static Triangles := 0x4
	static Compile := 0x1300
	
	enableLogging()
	{
		GL := {base:GL}
	}
	
	;~ __Call(p*)
	;~ {
		;~ FileAppend, % Disp(p),log.txt
	;~ }
	
	GL()
	{
		GL.hgl  := DllCall("LoadLibrary", "str", "opengl32", "ptr")
		GL.hglu := DllCall("LoadLibrary", "str", "glu32", "ptr")
		GL.onExit := {base:{__delete:GL.Free()}}
	}
	
	Free()
	{
		DllCall("FreeLibrary", ptr, DllCall("GetModuleHandle", "str", "opengl32", "ptr"))
		DllCall("FreeLibrary", ptr, DllCall("GetModuleHandle", "str", "glu32", "ptr"))
	}
	
	Enable(cap)
	{
		return DllCall("opengl32\glEnable","UInt",cap)
	}
	
	BlendFunc(src,target)
	{
		return DllCall("opengl32\glBlendFunc","uint",Src,"uint",Target)
	}
	
	Hint(target,mode)
	{
		return DllCall("opengl32\glHint","UInt",target,"UInt",mode)
	}
	
	DepthFunc(mode)
	{
		return DllCall("opengl32\glDepthFunc","uint",mode)
	}
	
	ClearDepth(depth)
	{
		return DllCall("opengl32\glClearDepth","double",depth)
	}
	
	PolygonMode(sides,fillmode)
	{
		return DllCall("opengl32\glPolygonMode","UInt",sides,"UInt",fillmode)
	}
	
	Clear(mask)
	{
		return DllCall("opengl32\glClear","UInt",mask)
	}
	
	Viewport(x,y,w,h)
	{
		return DllCall("opengl32\glViewport","Int", x,"Int", y,"Int", w,"Int", h)
	}
	
	MatrixMode(mat)
	{
		return DllCall("opengl32\glMatrixMode","UInt",mat)
	}
	
	LoadIdentity()
	{
		return DllCall("opengl32\glLoadIdentity")
	}
	
	Frustrum( minX, maxX, minY, maxY, minZ, maxZ )
	{
		return DllCall("opengl32\glFrustum","Double", minX,"Double", maxX,"Double", minY,"Double", maxY,"Double", minZ,"Double", maxZ) ;keep in mind that minz needs to be larger than 0
	}
	
	Ortho( minX, maxX, minY, maxY, minZ, maxZ )
	{
		return DllCall("opengl32\glOrtho","Double", minX,"Double", maxX,"Double", minY,"Double", maxY,"Double", minZ,"Double", maxZ)
	}
	
	GenTextures(n,byref buffer)
	{
		VarSetCapacity(buffer,n*4)
		return DllCall("opengl32\glGenTextures","int", n, "ptr", &buffer)
	}
	
	GenTexture()
	{
		DllCall("opengl32\glGenTextures","int", 1, "int*", i )
		return i
	}
	
	BindTexture(tex,id)
	{
		return DllCall("opengl32\glBindTexture","int",tex,"int",id)
	}
	
	TexParami(tex,mode,filter)
	{
		return DllCall("opengl32\glTexParameteri","uint", tex,"uint", mode,"int", filter )
	}
	
	TexImage2d()
	{
		return DllCall("opengl32\glTexImage2D","UInt",0xDE1,"Int",0,"Int",4,"Int",Width,"Int",Height,"Int",0,"UInt",0x80E1,"UInt",0x1401,"UInt",Bits) 
	}
	
	Translated(x,y,z)
	{
		return DllCall("opengl32\glTranslated","Double",x ,"Double",y , "Double",z )
	}
	
	Rotated(angle,X,Y,Z)
	{
		return DllCall("opengl32\glRotated", "Double",angle ,"Double",X ,"Double",Y ,"Double",Z)
	}
	
	Begin(mode)
	{
		return DllCall("opengl32\glBegin", "UInt",mode)
	}
	
	End()
	{
		return DllCall("opengl32\glEnd")
	}
	
	Vertex3d(x,y,z)
	{
		return DllCall("opengl32\glVertex3d","double",x, "double",y, "double",z )
	}
	
	TexCoord2d(x,y)
	{
		return DllCall("opengl32\glTexCoord2d","double",x, "double",y )
	}
	
	wCreateContext(hDC)
	{
		return DllCall("opengl32\wglCreateContext", "ptr", hDC, "ptr")
	}
	
	wMakeCurrent(hDC,hRC)
	{
		return DllCall("opengl32\wglMakeCurrent", "ptr", hDC, "ptr", hRC)
	}
	
	GetError()
	{
		return DllCall("opengl32\glGetError","UInt")
	}
	
	Color3ub(R,G,B)
	{
		return DllCall("opengl32\glColor3ub","UChar",R ,"UChar",G ,"UChar",B )
	}
	
	PushMatrix()
	{
		return DllCall("opengl32\glPushMatrix")
	}
	
	PopMatrix()
	{
		return DllCall("opengl32\glPopMatrix")
	}
	
	GenLists(n)
	{
		return DllCall("opengl32\glGenLists","UInt",n)
	}
	
	NewList(Id,mode)
	{
		return DllCall("opengl32\glNewList", "UInt",Id, "UInt",mode )
	}
	
	EndList()
	{
		DllCall("opengl32\glEndList")
	}
	
	CallList(Id)
	{
		DllCall("opengl32\glCallList", "UInt",Id)
	}
	
	MultMatrix(Mat)
	{
		static buf := "",Init := VarSetCapacity(buf,128,0)
		For y,Row in Mat
			For x,Value in Row
				NumPut(Value,buf,((x-1)*4+(y-1))*8,"Double")
		DllCall("opengl32\glMultMatrixd","ptr",&buf)
	}
}


class GUI
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
}

class World
{
	static Content := []
	

	
	Add( x ,y ,z ,DrawObject ,PhysicalObject="" ,Behaviour="" )
	{
		World.Content.Push([[x,y,z],DrawObject,PhysicalObject,Behaviour])
	}
	
	Draw()
	{
		For each,Obj in World.Content
		{
			Cam.ApplyView()
			GL.PushMatrix()
			GL.Translated((Obj.1)*)
			Obj.2.Draw()
			GL.PopMatrix()
		}
	}
}

class DrawObject
{
	__New()
	{
		this.Matrix      := New Matrix()
		this.DrawData    := []
		this.Draw        := ""
		this.Compile     := ""
		this.CompileDraw := ""
	}
	
	Begin(mode)
	{
		this.DrawData.Push([GL.Begin,[mode]])
	}
	
	End()
	{
		this.DrawData.Push([GL.End,[]])
	}
	
	Vector(vec)
	{
		vec2 := []
		vec := this.Matrix.Vector(vec)
		Loop 3
			vec2[A_Index] := vec[A_Index]
		  
		this.DrawData.Push([GL.Vertex3d,vec2])
	}
	
	Translate(x,y,z)
	{
		this.Matrix.Translate(x,y,z)
	}
	
	Rotate(angle,x,y,z)
	{
		this.Matrix.Rotate(angle,x,y,z)
	}
	
	Scale(x,y,z)
	{
		this.Matrix.Scale(x,y,z)
	}
	
	Color(RGB)
	{
		This.DrawData.Push([GL.Color3ub,[RGB>>16,(RGB>>8)&0xFF,RGB&0xFF]])
	}
	
	Finish()
	{
		This.Vector    := ""
		This.Translate := ""
		This.Rotate    := ""
		This.Scale     := ""
		This.Color     := ""
		This.Finish    := ""
		This.Remove("Draw")
		This.Remove("Compile")
	}
	
	Compile()
	{
		This.List := GL.GenLists(1)
		GL.NewList(This.List,Gl.Compile)
		This.Draw()
		GL.EndList()
		This.Draw := this.base.CompileDraw
	}
	
	CompileDraw()
	{
		Gl.CallList(this.list)
	}
	
	Draw()
	{
		For each, Command in this.DrawData
		{
			a := Command.2
			Command.1.Call(gl,a*)
		}
	}
}

class Cam
{
	static Mode        := "Ortho"
	static BoxSize     := 1
	static ClipNear    := 1
	static ClipFar     := 100
	static FieldOfView := 90
	
	Init(Settings="")
	{
		For each, val in Settings
			This[each] := val
		THis.ApplyProjectionMatrix := Cam[This.Mode]
		This.Matrix := new Matrix()
		this.x := 0
		this.y := 0
		this.z := 0
		this.ry := 0
		this.rx := 0
	}
	
	Move(x,y,z)
	{
		this.x+=x
		this.y+=y
		this.z+=z
	}
	
	LocalMove(x,y,z)
	{
		static pt := (ATan(1)*4)/180
		this.x+=x*cos(this.rx*pt)+z*sin(this.rx*pt)
		this.y+=y
		this.z+=-x*sin(this.rx*pt)+z*cos(this.rx*pt)
	}
	
	Rotate(x,y)
	{
		this.ry+=y
		this.rx+=x
	}
	
	Frustrum(ratio)
	{
		MaxY := This.ClipNear * Tan(This.FieldOfView * 0.00872664626)
		MaxX := MaxY * ratio
		GL.Frustrum(-MaxX ,MaxX ,-MaxY ,MaxY ,This.ClipNear ,This.ClipFar)
	}
		
	Ortho(ratio)
	{
		GL.Ortho(-This.Boxsize*ratio,This.BoxSize*Ratio,-This.BoxSize,This.BoxSize,-This.BoxSize,This.BoxSize)
	}
	
	Ortho2d(ratio)
	{
		GL.Ortho2d(-This.BoxSize*ratio,This.BoxSize*ratio,-This.BoxSize,This.BoxSize)
	}
	
	ApplyView()
	{
		GL.LoadIdentity()
		GL.Rotated(this.ry,1,0,0)
		GL.Rotated(this.rx,0,1,0)
		GL.Translated(this.z,this.y,this.x)
	}
}

class Matrix
{

	__New()
	{
		return {base:Matrix,1:[1,0,0,0],2:[0,1,0,0],3:[0,0,1,0],4:[0,0,0,1]}
	}
	
	Vector(vec)
	{
		while (vec.MaxIndex()<4)
			vec.push(vec.MaxIndex()=3)
		res := [0,0,0,0]
		Loop 4
		{
			y := A_Index
			Loop 4
				res[y] += this[y,A_Index]*vec[A_Index]
		}
		return res
	}
	
	Matrix(m1)
	{
		m2 := This.Clone()
		Loop 4
		{
			y := A_Index
			This[y] := []
			Loop 4
			{
				x := A_Index
				This[y,x] := 0
				Loop 4
					This[y,x] += m2[y,A_Index]*m1[A_Index,x]
			}
		}
		return this
	}
	
	Matrix2(m1)
	{
		m2 := This.Clone()
		Loop 4
		{
			y := A_Index
			This[y] := []
			Loop 4
			{
				x := A_Index
				This[y,x] := 0
				Loop 4
					This[y,x] += m1[y,A_Index]*m2[A_Index,x]
			}
		}
		return this
	}
	
	Scale(p*)
	{
		For x, val in p
			Loop 4
				This[A_Index,x] *= val 
	}
	
	Translate(x,y,z)
	{
		Loop 4
			This[A_Index,4] += x*This[A_Index,1]+y*This[A_Index,2]+z*This[A_Index,3]
	}
	
	Rotate(angle,x,y,z)
	{
		This.Matrix(This.newRotate(angle,x,y,z))
	}
	
	Rotate2(angle,x,y,z)
	{
		This.Matrix2(This.newRotate(angle,x,y,z))
	}
	
	loadIdentity()
	{
		This.RemoveAt(1,4)
		This.InsertAt(1,[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1])
	}
	
	newScale(x,y,z)
	{
		return {base:Matrix,1:[x,0,0,0],2:[0,y,0,0],3:[0,0,z,0],4:[0,0,0,1]}
	}
	
	newTranslate(x,y,z)
	{
		return {base:Matrix,1:[1,0,0,x],2:[0,1,0,y],3:[0,0,1,z],4:[0,0,0,1]}
	}
	
	newRotate(angle,x,y,z)
	{
		t := (((x**2)+(y**2)+(z**2))**0.5)
		x := x/t
		y := y/t
		z := z/t
		s := sin(angle*((ATan(1)*4)/180))
		c := cos(angle*((ATan(1)*4)/180))
		return {base:Matrix,1:[x**2*(1-c)+c,x*y*(1-c)-z*s,x*z*(1-c)+y*s,0],2:[y*x*(1-c)+z*s,y**2*(1-c)+c,y*z*(1-c)+x*s,0],3:[x*z*(1-c)-y*s,y*z*(1-c)+x*s,z**2*(1-c)+c,0],4:[0,0,0,1]}
	}
}

;~ class Engine
;~ {
	;~ static Z_Order := 0
	;~ static Textures:= 0
	
	

	
	
	
	
	
	
	
	
;~ }

SetBatchLines,-1
SetMouseDelay,-1
Cam.Init({Mode:"Frustrum",ClipFar:100})
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
Gui.Show()
GL.Enable(GL.DEPTH_TEST)
GL.DepthFunc(GL.GREATER)
GL.ClearDepth(-Cam.ClipFar)
MouseMove,A_ScreenWidth/2,A_ScreenHeight/2,0
Loop
{
	GL.Clear(GL.COLOR_BUFFER_BIT|GL.DEPTH_BUFFER_BIT)
	MouseGetPos,newX,newY
	MouseMove,A_ScreenWidth/2,A_ScreenHeight/2,0
	Cam.LocalMove((GetKeyState("w")-GetKeyState("s"))*0.2,0,(GetKeyState("a")-GetKeyState("d"))*0.2)
	Cam.Rotate((newX-A_ScreenWidth/2)/24,(newY-A_ScreenHeight/2)/24)
	World.Draw()
	Gui.SwapBuffers()
}

esc::
GuiClose:
ExitApp
