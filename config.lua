Config = {}

Config.ShowCenter = true
Config.Increment = 0.1
Config.FineIncrement = 0.01
Config.AngleIncrement = 5.0
Config.AngleFineIncrement = 0.5
Config.MinSize = 0.1

--Keyboard without Numpad
Config.Keymaps = { -- {index, name} from https://docs.fivem.net/docs/game-references/controls/
	IncToggle = {83, "INPUT_VEH_NEXT_RADIO_TRACK"}, -- Equal
	WidthLeft = {174, "INPUT_CELLPHONE_LEFT"}, -- ARROW LEFT
	WidthRight = {175, "INPUT_CELLPHONE_RIGHT"}, -- ARROW RIGHT
	LengthFwrd = {208, "INPUT_FRONTEND_RT"}, -- PAGE UP
	LengthBwrd = {207, "INPUT_FRONTEND_LT"}, -- PAGE DOWN
	HeightUp = {172, "INPUT_CELLPHONE_UP"}, -- ARROW UP
	HeightDown = {173, "INPUT_CELLPHONE_DOWN"}, -- ARROW DOWN
	GrowRotL = {39, "INPUT_SNIPER_ZOOM"}, -- [
	ShrinkRotR = {40, "INPUT_SNIPER_ZOOM_IN_ONLY"}, -- ]
	CopyVec3 = {47, "INPUT_DETONATE"}, -- G
	CopyQbt = {74, "INPUT_VEH_HEADLIGHT"}, -- H
	SwitchMode = {201, "INPUT_FRONTEND_ACCEPT"}, -- ENTER
	Cancel = {194, "INPUT_FRONTEND_RRIGHT"}, -- BACKSPACE
}

-- Full Keyboard
--[[
Config.Keymaps = { -- {index, name} from https://docs.fivem.net/docs/game-references/controls/
	IncToggle = {83, "INPUT_VEH_NEXT_RADIO_TRACK"}, -- Equal
	WidthLeft = {174, "INPUT_CELLPHONE_LEFT"}, -- ARROW LEFT
	WidthRight = {175, "INPUT_CELLPHONE_RIGHT"}, -- ARROW RIGHT
	LengthFwrd = {111, "INPUT_VEH_FLY_PITCH_UP_ONLY"}, -- NUMPAD 8
	LengthBwrd = {112, "INPUT_VEH_FLY_PITCH_DOWN_ONLY"}, -- NUMPAD 5
	HeightUp = {172, "INPUT_CELLPHONE_UP"}, -- ARROW UP
	HeightDown = {173, "INPUT_CELLPHONE_DOWN"}, -- ARROW DOWN
	GrowRotL = {108, "INPUT_VEH_FLY_ROLL_LEFT_ONLY"}, -- NUMPAD 4
	ShrinkRotR = {109, "INPUT_VEH_FLY_ROLL_RIGHT_ONLY"}, -- NUMPAD 6
	CopyVec3 = {47, "INPUT_DETONATE"}, -- G
	CopyQbt = {74, "INPUT_VEH_HEADLIGHT"}, -- H
	SwitchMode = {201, "INPUT_FRONTEND_ACCEPT"}, -- ENTER
	Cancel = {194, "INPUT_FRONTEND_RRIGHT"}, -- BACKSPACE
}
]]--
