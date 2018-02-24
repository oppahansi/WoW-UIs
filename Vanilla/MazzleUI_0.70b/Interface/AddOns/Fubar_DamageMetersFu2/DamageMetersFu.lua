DamageMetersFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0");
local L = AceLibrary("AceLocale-2.0"):new("DamageMetersFu");
local Tablet = AceLibrary("Tablet-2.0");

L:RegisterTranslations("enUS", function() return {
	["tabletHint"] = "Click to toggle DamageMeters.",
	["labelName"] = "DamageMeters",
} end);

DamageMetersFu:RegisterDB("DamageMetersFuDB");
DamageMetersFu.hasIcon = true;
DamageMetersFu.defaultPosition = "RIGHT";

local optionsTable = {
	handler = DamageMetersFu,
	type = "group",
	args = {};
};

DamageMetersFu:RegisterChatCommand({ "/dmfu" }, optionsTable);
DamageMetersFu.OnMenuRequest = optionsTable;

function DamageMetersFu:OnTextUpdate()
	if (self:IsTextShown()) then
		self:ShowText();
		self:SetText("|cffffffff"..L"labelName".."|r");
	else
		self:HideText();
	end
end

function DamageMetersFu:OnTooltipUpdate()
	Tablet:SetHint(L"tabletHint");
end

function DamageMetersFu:OnClick()
	DamageMeters_ToggleShow();
end