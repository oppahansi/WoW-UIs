local LibButtonFacade = LibStub("LibButtonFacade",true)
if not LibButtonFacade then
	return
end

LibButtonFacade:AddSkin("simpleSquare",{
	-- Skin data start.
	Backdrop = {
		Width = 32,
		Height = 32,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_simpleSquare\Textures\simpleSquareBackdrop]],
	},
	Icon = {
		Width = 32,
		Height = 32,
	},
	Flash = {
		Width = 40,
		Height = 40,
		BlendMode = "BLEND",
		Texture = [[Interface\AddOns\ButtonFacade_simpleSquare\Textures\simpleSquareFlash]],
	},
	Cooldown = {
		Width = 37,
		Height = 37,
		Scale = .75,
	},
	AutoCast = {
		Width = 29,
		Height = 28,
		OffsetY = -1,
	},
	Normal = {
		Width = 40,
		Height = 40,
		Static = true,
		Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_simpleSquare\Textures\simpleSquareBase]],
	},
	Pushed = {
		Width = 40,
		Height = 40,
		Color = {0, 0, 0, 1},
		Texture = [[Interface\AddOns\ButtonFacade_simpleSquare\Textures\simpleSquareHighlight]],
		BlendMode = "ADD",
	},
	Border = {
		Width = 40,
		Height = 40,
		BlendMode = "ADD",
		Color = {0, 1, 0, 1},
		Texture = [[Interface\AddOns\ButtonFacade_simpleSquare\Textures\simpleSquareHighlight]],
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = 40,
		Height = 40,
		BlendMode = "BLEND",
		Color = {0, 0.75, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_simpleSquare\Textures\simpleSquareActive]],
	},
	AutoCastable = {
		Width = 54,
		Height = 54,
		OffsetY = -1,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]],
	},
	Highlight = {
		Width = 40,
		Height = 40,
		BlendMode = "BLEND",
		--Color = {1, 1, 1, 1},
		Texture = [[Interface\AddOns\ButtonFacade_simpleSquare\Textures\simpleSquareHighlight]],
	},
	Gloss = {
		Width = 40,
		Height = 40,
		Texture = [[Interface\AddOns\ButtonFacade_simpleSquare\Textures\simpleSquareGloss]],
	},
	HotKey = {
		OffsetX = 0,
		OffsetY = 7,
	},
	Count = {
		OffsetX = 0,
		OffsetY = -8,
	},
	Name = {
		Width = 32,
		Height = 10,
		OffsetY = -6,
	},
	-- Skin data end.

},true)