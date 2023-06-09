-- Varaibles

local HelperBox
local Helping = false
local Position = vector3(0.0, 0.0, 0.0)
local Rotation = 0.0
local Width = 1.0
local Length = 1.0
local Height = 1.0
local Increment = Config.Increment
local AngleIncrement = Config.AngleIncrement
local Points = {}
local Mode = "move"


-- Functions

function GetPointPositions()
	Points[1] = GetOffsetFromPostionHeadingInWorldCoords(Position.x, Position.y, Position.z, Rotation, 0.0 - Width / 2, 0.0 - Length / 2, 0.0 - Height / 2)
	Points[2] = GetOffsetFromPostionHeadingInWorldCoords(Position.x, Position.y, Position.z, Rotation, 0.0 + Width / 2, 0.0 - Length / 2, 0.0 - Height / 2)
	Points[3] = GetOffsetFromPostionHeadingInWorldCoords(Position.x, Position.y, Position.z, Rotation, 0.0 + Width / 2, 0.0 + Length / 2, 0.0 - Height / 2)
	Points[4] = GetOffsetFromPostionHeadingInWorldCoords(Position.x, Position.y, Position.z, Rotation, 0.0 - Width / 2, 0.0 + Length / 2, 0.0 - Height / 2)
	Points[5] = GetOffsetFromPostionHeadingInWorldCoords(Position.x, Position.y, Position.z, Rotation, 0.0 - Width / 2, 0.0 - Length / 2, 0.0 + Height / 2)
	Points[6] = GetOffsetFromPostionHeadingInWorldCoords(Position.x, Position.y, Position.z, Rotation, 0.0 + Width / 2, 0.0 - Length / 2, 0.0 + Height / 2)
	Points[7] = GetOffsetFromPostionHeadingInWorldCoords(Position.x, Position.y, Position.z, Rotation, 0.0 + Width / 2, 0.0 + Length / 2, 0.0 + Height / 2)
	Points[8] = GetOffsetFromPostionHeadingInWorldCoords(Position.x, Position.y, Position.z, Rotation, 0.0 - Width / 2, 0.0 + Length / 2, 0.0 + Height / 2)
end

function UpdateHelperBox()
	Citizen.CreateThread(function()
		while Helping do
			if Config.ShowCenter then
				DrawSphere(Position, 0.01, 255, 255, 255, 1.0)
			end
			DrawLine(Points[1], Points[2], 255, 255, 255, 255)
			DrawLine(Points[2], Points[3], 255, 255, 255, 255)
			DrawLine(Points[3], Points[4], 255, 255, 255, 255)
			DrawLine(Points[4], Points[1], 255, 255, 255, 255)
			DrawLine(Points[5], Points[6], 255, 255, 255, 255)
			DrawLine(Points[6], Points[7], 255, 255, 255, 255)
			DrawLine(Points[7], Points[8], 255, 255, 255, 255)
			DrawLine(Points[8], Points[5], 255, 255, 255, 255)
			DrawLine(Points[5], Points[1], 255, 255, 255, 255)
			DrawLine(Points[6], Points[2], 255, 255, 255, 255)
			DrawLine(Points[7], Points[3], 255, 255, 255, 255)
			DrawLine(Points[8], Points[4], 255, 255, 255, 255)
			Citizen.Wait(0)
		end
	end)
end

function TargetBoxHelper()
	local PlayerPed = PlayerPedId()
	local PlayerPos = GetEntityCoords(PlayerPed)
	local PlayerHead = GetEntityHeading(PlayerPed)
	Position = PlayerPos
	HelpMessageUpdater()
	Message = ""
	RunMessage = true
	DrawNativeTextRunningMessage()
	GetPointPositions()
	UpdateHelperBox()
	local LastPress = 0
	local IncrementTime = 100
	Citizen.CreateThread(
		function()
			while Helping do
				local StartPos = GetOffsetFromEntityInWorldCoords(PlayerPed, -0.3, 0.5, 0.0)
				local StartHead = PlayerHead - 90.0
				if IsControlPressed(0, Config.Keymaps.WidthLeft[1]) then
					local CurTime = GetGameTimer()
					if (CurTime - LastPress) > IncrementTime then
						LastPress = CurTime
						if Mode == "scale" then
							Width = Width - Increment
							if Width < Config.MinSize then Width = Config.MinSize end
						else
							Position = vector3(Position.x - Increment, Position.y, Position.z)
						end
						GetPointPositions()
					end
				end
				if IsControlPressed(0, Config.Keymaps.WidthRight[1]) then
					local CurTime = GetGameTimer()
					if (CurTime - LastPress) > IncrementTime then
						LastPress = CurTime
						if Mode == "scale" then
							Width = Width + Increment
						else
							Position = vector3(Position.x + Increment, Position.y, Position.z)
						end
						GetPointPositions()
					end
				end
				if IsControlPressed(0, Config.Keymaps.LengthFwrd[1]) then
					local CurTime = GetGameTimer()
					if (CurTime - LastPress) >  IncrementTime then
						LastPress = CurTime
						if Mode == "scale" then
							Height = Height + Increment
						else
							Position = vector3(Position.x, Position.y, Position.z + Increment)
						end
						GetPointPositions()
					end
				end
				if IsControlPressed(0, Config.Keymaps.LengthBwrd[1]) then
					local CurTime = GetGameTimer()
					if (CurTime - LastPress) > IncrementTime then
						LastPress = CurTime
						if Mode == "scale" then
							Height = Height - Increment
							if Height < Config.MinSize then Height = Config.MinSize end
						else
							Position = vector3(Position.x, Position.y, Position.z - Increment)
						end
						GetPointPositions()
					end
				end
				if IsControlPressed(0, Config.Keymaps.HeightUp[1]) then
					local CurTime = GetGameTimer()
					if (CurTime - LastPress) > IncrementTime then
						LastPress = CurTime
						if Mode == "scale" then
							Length = Length + Increment
						else
							Position = vector3(Position.x, Position.y + Increment, Position.z)
						end
						GetPointPositions()
					end
				end
				if IsControlPressed(0, Config.Keymaps.HeightDown[1]) then
					local CurTime = GetGameTimer()
					if (CurTime - LastPress) > IncrementTime then
						LastPress = CurTime
						if Mode == "scale" then
							Length = Length - Increment
							if Length < Config.MinSize then Length = Config.MinSize end
						else
							Position = vector3(Position.x, Position.y - Increment, Position.z)
						end
						GetPointPositions()
					end
				end
				if IsControlPressed(0, Config.Keymaps.GrowRotL[1]) then
					local CurTime = GetGameTimer()
					if (CurTime - LastPress) > IncrementTime then
						LastPress = CurTime
						if Mode == "scale" then
							Width = Width - Increment
							if Width < Config.MinSize then Width = Config.MinSize end
							Length = Length - Increment
							if Length < Config.MinSize then Length = Config.MinSize end
							Height = Height - Increment
							if Height < Config.MinSize then Height = Config.MinSize end
						else
							Rotation = Rotation + AngleIncrement
							if Rotation >= 360.0 then Rotation = Rotation - 360.0 end
						end
						GetPointPositions()
					end
				end
				if IsControlPressed(0, Config.Keymaps.ShrinkRotR[1]) then
					local CurTime = GetGameTimer()
					if (CurTime - LastPress) > IncrementTime then
						LastPress = CurTime
						if Mode == "scale" then
							Width = Width + Increment
							Length = Length + Increment
							Height = Height + Increment
						else
							Rotation = Rotation - AngleIncrement
							if Rotation < 0.0 then Rotation = Rotation + 360.0 end
						end
						GetPointPositions()
					end
				end
				if IsControlJustReleased(0, Config.Keymaps.CopyVec3[1]) then
					local x = RoundOff(Position.x, 3)
					local y = RoundOff(Position.y, 3)
					local z = RoundOff(Position.z, 3)
					local w = RoundOff(Rotation, 3)
					SendNUIMessage({
						string = string.format('vector3(%s, %s, %s)', x, y, z) .. " --[" .. string.format('vector4(%s, %s, %s, %s)', x, y, z, w) .. "]--"
					})
					DrawNativeTextMessage("Position copied to clipboard", 4000)
				end
				if IsControlJustReleased(0, Config.Keymaps.CopyQbt[1]) then
					local x = RoundOff(Position.x, 3)
					local y = RoundOff(Position.y, 3)
					local z = RoundOff(Position.z, 3)
					SendNUIMessage({
						string = "exports['qb-target']:AddBoxZone(??, vector3(" .. x .. ", " .. y .. ", " .. z .. "), " .. Width .. ", " .. Length .. ", {" ..
							"\r\n\tname = ??," ..
							"\r\n\theading = " .. Rotation .. "," ..
							"\r\n\tdebugPoly = false," ..
							"\r\n\tMinZ = " .. z - Height / 2 .. "," ..
							"\r\n\tMaxZ = " .. z + Height / 2 .. ","
					})
					DrawNativeTextMessage("qb-target info copied to clipboard", 4000)
				end
				if IsControlJustReleased(0, Config.Keymaps.SwitchMode[1]) then
					if Mode == "scale" then
						Mode = "move"
						HelpMessage = MoveMessage
					else
						Mode = "scale"
						HelpMessage = ScaleMessage
					end
				end
				if IsControlJustReleased(0, Config.Keymaps.IncToggle[1]) then
					if Increment == Config.Increment then
						Increment = Config.FineIncrement
						AngleIncrement = Config.AngleFineIncrement
					else
						Increment = Config.Increment
						AngleIncrement = Config.AngleIncrement
					end
					HelpMessageUpdater()
				end
				if IsControlJustReleased(0, Config.Keymaps.Cancel[1]) then
					ExecuteCommand('targhelp')
				end
				Message = "vector3(" .. RoundOff(Position.x, 3) .. ", " .. RoundOff(Position.y, 3) .. ", " .. RoundOff(Position.z, 3) .. ")~n~W: " .. Width .. "   L: " .. Length .. "   H: " .. Height .. "~n~Heading: " .. Rotation .. "~n~M: " .. Mode
				Citizen.Wait(0)
			end
			RunHelpMessage = false
			RunMessage = false
		end
	)
end

function HelpMessageUpdater()
	ScaleMessage = "~" .. Config.Keymaps.SwitchMode[2] .. "~ Mode (scale) ~" .. Config.Keymaps.IncToggle[2] .. "~ " .. Increment .. "~n~\z
	~" .. Config.Keymaps.WidthLeft[2] .. "~~" .. Config.Keymaps.WidthRight[2] .. "~ Width (-/+)~n~\z
	~" .. Config.Keymaps.HeightUp[2] .. "~~" .. Config.Keymaps.HeightDown[2] .. "~ Length (-/+)~n~\z
	~" .. Config.Keymaps.LengthFwrd[2] .. "~~" .. Config.Keymaps.LengthBwrd[2] .. "~ Height (-/+)~n~\z
	~" .. Config.Keymaps.GrowRotL[2] .. "~~" .. Config.Keymaps.ShrinkRotR[2] .. "~ All (-/+)~n~\z
	~" .. Config.Keymaps.CopyVec3[2] .. "~~" .. Config.Keymaps.CopyQbt[2] .. "~ Copy (Vec/Target)~n~\z
	~" .. Config.Keymaps.Cancel[2] .. "~ Cancel"
	MoveMessage = "~" .. Config.Keymaps.SwitchMode[2] .. "~ Mode (move) ~" .. Config.Keymaps.IncToggle[2] .. "~ " .. Increment .. "~n~\z
	~" .. Config.Keymaps.WidthLeft[2] .. "~~" .. Config.Keymaps.WidthRight[2] .. "~ X (Left/Right)~n~\z
	~" .. Config.Keymaps.HeightUp[2] .. "~~" .. Config.Keymaps.HeightDown[2] .. "~ Y (Frwd/Bck)~n~\z
	~" .. Config.Keymaps.LengthFwrd[2] .. "~~" .. Config.Keymaps.LengthBwrd[2] .. "~ Z (Up/Down)~n~\z
	~" .. Config.Keymaps.GrowRotL[2] .. "~~" .. Config.Keymaps.ShrinkRotR[2] .. "~ Rotate (Left/Right)~n~\z
	~" .. Config.Keymaps.CopyVec3[2] .. "~~" .. Config.Keymaps.CopyQbt[2] .. "~ Copy (Vec/Target)~n~\z
	~" .. Config.Keymaps.Cancel[2] .. "~ Cancel"
	if Mode == "scale" then
		HelpMessage = ScaleMessage
	else
		HelpMessage = MoveMessage
	end
	RunHelpMessage = true
	DrawNativeTextHelpMessage()
end


-- Utility Functions

function DrawNativeTextMessage(str, timeout)
	BeginTextCommandPrint("STRING")
	AddTextComponentString(str)
	EndTextCommandPrint(timeout, true)
end

function DrawNativeTextRunningMessage()
	local Scale = 0.35
	if not MessageRunning then
		Citizen.CreateThread(
			function()
				while RunMessage do
					MessageRunning = true
					local MessageWidth = 0
					local MessageLines = 1
					local LastFound = 0
					local Next = 1
					while true do
						local Start, End = string.find(Message, "~n~", Next, true)
						if Start == nil then break end
						if MessageWidth == 0 then
							LastFound = Start
							MessageWidth = Start
						else
							if Start - LastFound > MessageWidth then
								MessageWidth = Start - LastFound
							end
							LastFound = Start
						end
						MessageLines = MessageLines + 1
						Next = End + 1
					end
					local width = (MessageWidth * Scale * 0.014) + 0.01 -- with border
					local height = (MessageLines * Scale * 0.07) + 0.01 -- with border
					local x = 0.95 - width
					local y = 0.85
					BeginTextCommandDisplayText('STRING')
					AddTextComponentSubstringPlayerName(Message)
					SetTextScale(1.0, Scale)
					EndTextCommandDisplayText(x, y)
					DrawRect(x + (0.5 * width) - 0.005, y + (0.5 * height) - 0.005, width, height, 0, 0, 0, 180)
					Citizen.Wait(0)
				end
				MessageRunning = false
			end
		)
	end
end

function DrawNativeTextHelpMessage()
	Citizen.CreateThread(
		function()
			while RunHelpMessage do
				AddTextEntry('HelpMsg', HelpMessage)
				BeginTextCommandDisplayHelp('HelpMsg')
				EndTextCommandDisplayHelp(0, false, true, -1)
				Citizen.Wait(0)
			end
		end
	)
end

function RoundOff(number, digits)
	local magnitude = 10 ^ digits
	return math.floor((number * magnitude) + 0.5) / (magnitude)
end

function GetOffsetFromPostionHeadingInWorldCoords(x, y, z, w, xoff, yoff, zoff) -- xoff is forward/backward, yoff is left/right, zoff is up/down
	local RefPos = vector3(x, y, z)
	local RefRot = w
	-- new X and Y based on xoff
	local OffX = RefPos.x + (math.cos(math.rad(RefRot + 90.0)) * xoff)
	local OffY = RefPos.y + (math.sin(math.rad(RefRot + 90.0)) * xoff)
	-- new X and Y based on yoff
	local OffX = OffX + (math.cos(math.rad(RefRot)) * yoff)
	local OffY = OffY + (math.sin(math.rad(RefRot)) * yoff)
	-- new Z based on zoff
	local OffZ = RefPos.z + zoff
	return vector3(OffX, OffY, OffZ)
end

-- Commands

RegisterCommand('targhelp',
	function()
		Helping = not Helping
		if Helping then
			TargetBoxHelper()
		end
	end
)