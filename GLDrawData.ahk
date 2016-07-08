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



