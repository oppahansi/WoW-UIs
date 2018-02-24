KC_Mobility = AceAddon:new({
    name          = KC_MOBILITY.NAME,
    version       = ".90",
    releaseDate   = "09/18/05",
    aceCompatible = "102", -- Check ACE_COMP_VERSION in Ace.lua for current.
    author        = "Kaelten",
    email         = "kaelten@gmail.com",
    website       = "http://kaelcycle.wowinterface.com",
    category      = "misc",
    db            = AceDatabase:new("KC_MobilityDB"),
    cmd           = AceChatCmd:new(KC_MOBILITY.COMMANDS, KC_MOBILITY.CMD_OPTIONS),
	framelist	  = KC_MOBILITY.FRAMELIST,
})

function KC_Mobility:Initialize()
    self:RegisterEvent("ADDON_LOADED", "Enable")
	local frames = self.db:get("frames");
	if (frames) then
		for index in frames do
			local framedesc = self.framelist[index];
			tinsert(KC_MOBILITY.CMD_OPTIONS[1].args, {option = index, desc = framedesc})
            tinsert(UISpecialFrames, index);
		end
	end
end

function KC_Mobility:Enable()
	for index in self.framelist do
		local frame = getglobal(index);
		if (frame) then
			self:HookScript(frame, "OnMouseDown", "ProcessOnMouseDown")
			self:HookScript(frame, "OnMouseUp", "ProcessOnMouseUp");

			if (frame:GetName() ~= "PaperDollFrame"  or this:GetName() ~= "ReputationFrame" or this:GetName() ~= "SkillFrame" or this:GetName() ~= "HonorFrame" or this:GetName() ~= "PetPaperDollFrame") then
				frame:SetMovable(true);	
			else
				frame:GetParent():SetMovable(true);
			end
		end
	end
	self:Hook("ShowUIPanel");
end


-- Movement functions
function KC_Mobility:ProcessOnMouseDown()
	if (arg1 == "LeftButton") then
		if (this:GetName() == "PaperDollFrame" or this:GetName() == "ReputationFrame" or this:GetName() == "SkillFrame" or this:GetName() == "HonorFrame" or this:GetName() == "PetPaperDollFrame") then
			this:GetParent():StartMoving();	
		else
			this:StartMoving();
		end
		self.moving = TRUE;
	else
		self:CallScript(this, "OnMouseDown");
	end
end

function KC_Mobility:ProcessOnMouseUp()
	if (self.moving) then
		local point = {};
		point.top = this:GetTop();
		point.left = this:GetLeft();
		self.moving = FALSE;

		local frame = this;
		local name = frame:GetName();

		if (name == "PaperDollFrame" or name == "ReputationFrame" or name == "SkillFrame" or name == "HonorFrame" or name == "PetPaperDollFrame") then
			frame = this:GetParent();
			name = frame:GetName();
		end

		point.parent = frame:GetParent():GetName();

		frame:StopMovingOrSizing();
		
		if (not self.db:get({"frames"}, name)) then
			tinsert(self.cmd.options[3].args, {option = name, desc = self.framelist[name]});			
		end
		
		self.db:set({"frames"}, name, point);
		
	end
	
	self:CallScript(this, "OnMouseUp");
end

function KC_Mobility:ShowUIPanel(frame)
	local point = self.db:get({"frames"}, frame:GetName())
	if (point) then
		frame:ClearAllPoints();
		frame:SetPoint("TOPLEFT", point.parent, "BOTTOMLEFT", point.left, point.top);
		frame:Show();
	else
		self:CallHook("ShowUIPanel", frame);
	end
end

function KC_Mobility:resetframe(framename)
	self.db:set({"frames"}, framename, nil);
	self.cmd.options[3].args = {};

	local frames = self.db:get("frames");
	if (frames) then
		for index in frames do
			local framedesc = self.framelist[index];
			tinsert(self.cmd.options[3].args, {option = index, desc = framedesc})
		end
	end

end

-- Register Addon to get processing from ace.
KC_Mobility:RegisterForLoad()
