//The clientside file for spectating. Bind a key to +spectatemenu

local function spectate()

	Frame = vgui.Create("DFrame")
	Frame:SetPos(400,290)
	Frame:SetSize(200,310)
	Frame:SetTitle("Spectate Menu")
	Frame:ShowCloseButton( true )
	Frame:SetVisible( true )
	Frame:MakePopup()

	List = vgui.Create("DListView", Frame)
	List:SetPos(25,25)
	List:SetSize(150,200)
	List:SetMultiSelect(false)
	List:AddColumn("Players")

	for k,v in pairs(player.GetAll()) do
		line = List:AddLine(v:Nick())
		line.PlayerIndex = v:EntIndex()
	end

	Spectate = vgui.Create("DButton", Frame)
	Spectate:SetPos(50,235)
	Spectate:SetSize(100,25)
	Spectate:SetText("Spectate")
	Spectate.DoClick = function()
			line = List:GetSelected()[1]
			RunConsoleCommand("spectate", line.PlayerIndex)
	end

	Unspectate = vgui.Create("DButton", Frame)
	Unspectate:SetPos(50,270)
	Unspectate:SetSize(100,25)
	Unspectate:SetText("Unspectate")
	Unspectate.DoClick = function()
			RunConsoleCommand("unspectate")
	end

end
concommand.Add("+spectatemenu", spectate)

local function hide()
	Frame:SetVisible(false)
end
concommand.Add("-spectatemenu", hide)