--[[ $Id: EQCompare.lua 71243 2008-04-24 14:27:23Z scorpio0920 $ ]]--

local INVTYPE_GUN, INVTYPE_CROSSBOW, INVTYPE_WAND, INVTYPE_THROWN, INVTYPE_GUNPROJECTILE, INVTYPE_BOWPROJECTILE

EQCompare_KEY_DESC = "Only display compare tooltip while holding custom key."
EQCompare_RESET_DESC = "Reset All settings."
EQCompare_RESET = "All settings are resetted."
EQCompare_HOVERLINK_DESC = "Enable display tooltip while hovering hyperlink in ChatFrame."
EQCompare_HOVERLINK_SAFE_DESC = "Use safe mode to display hovering hyperlink."
EQCompare_SKIN_DESC = "Turn off oSkin/Skinner tooltip texture."
EQCompare_MERCHANTAUCTIONKEY_DESC = "Enable Merchant/Auction comparision holding key."
EQCompare_HOVERLINKKEY_DESC = "Enable Hoverlink comparision holding key."

if (GetLocale() == "deDE") then
	INVTYPE_GUN = "Schusswaffe"
	INVTYPE_CROSSBOW="Armbrust"
	INVTYPE_WAND = "Zauberstab"
	INVTYPE_THROWN = "Geworfen"
	INVTYPE_GUNPROJECTILE = "Projektil Kugel"
	INVTYPE_BOWPROJECTILE = "Projektil Pfeil"

	EQCompare_KEY_DESC="Zeige die Vergleichsfenster nur an wenn die gesetzte Taste gedrückt gehalten wird."
	EQCompare_RESET_DESC="Zurrücksetzen Aller Einstellungen."
	EQCompare_RESET="Alle Einstellungen wurden zurrück gesetzt."
	EQCompare_HOVERLINK_DESC="Aktiviere das Anzeigen des Vergleichsfensters wenn über einen Link im Chat mit der Maus gegangen wird."
	EQCompare_HOVERLINK_SAFE_DESC="Benutze sicheren Modus wenn über einen Link mit der Maus gegangen wird."
	EQCompare_SKIN_DESC="Schalte die Vergleichsfenster Textur von oSkin/Skinner aus."
	EQCompare_MERCHANTAUCTIONKEY_DESC="Aktiviere Händler/Auktionshaus Vergleichsfenster nur bei gedrückt halten der Vergleichstaste."
	EQCompare_HOVERLINKKEY_DESC="Aktiviere Link Vergleichsfenster nur bei gedrückt halten der Vergleichstaste."
elseif (GetLocale() == "frFR") then
	INVTYPE_GUN = "Arme \195\160 feu"
	INVTYPE_CROSSBOW = "Arbal\195\168te"
	INVTYPE_WAND = "Baguette"
	INVTYPE_THROWN = "Armes de jet"
	INVTYPE_GUNPROJECTILE = "Projectile"
	INVTYPE_BOWPROJECTILE = "Projectile"
elseif (GetLocale() == "zhTW") then
	INVTYPE_GUN = "槍械"
	INVTYPE_WAND = "魔杖"
	INVTYPE_CROSSBOW = "弩"
	INVTYPE_THROWN = "投擲武器"
	INVTYPE_GUNPROJECTILE = "子彈"
	INVTYPE_BOWPROJECTILE = "箭"

	EQCompare_KEY_DESC = "當按住設定的按鍵時才顯示對比資訊"
	EQCompare_RESET_DESC = "重置所有選項"
	EQCompare_RESET = "所有選項已重置"
	EQCompare_HOVERLINK_DESC = "當滑鼠移動到聊天視窗的連結時自動顯示資訊"
	EQCompare_HOVERLINK_SAFE_DESC = "使用安全模式顯示滑鼠所在處連結資訊"
	EQCompare_SKIN_DESC = "關閉 oSkin/Skinner 的支援"
	EQCompare_MERCHANTAUCTIONKEY_DESC = "啟用 商人販售和拍賣場比對資訊顯示 需要按住設定按鍵"
	EQCompare_HOVERLINKKEY_DESC = "啟用 滑鼠移動到聊天視窗的連結時資訊顯示 需要按住設定按鍵"
elseif (GetLocale() == "koKR") then
	INVTYPE_GUN = "총"
	INVTYPE_CROSSBOW = "석궁"
	INVTYPE_WAND = "마법봉"
	INVTYPE_THROWN = "투척 무기"
	INVTYPE_GUNPROJECTILE = "투사체"
	INVTYPE_BOWPROJECTILE = "투사체"

	EQCompare_KEY_DESC = "사용자 키가 눌려진 동안에만 비교 툴팁이 표시됩니다.."
	EQCompare_RESET_DESC = "모든 설정을 초기화합니다."
	EQCompare_RESET = "모든 설정이 초기화 되었습니다."
	EQCompare_HOVERLINK_DESC = "대화창에 링크위에 마우스를 올렸을 때 툴팁을 표시합니다."
	EQCompare_HOVERLINK_SAFE_DESC = "링크 툴팁을 위해 안전 모드를 사용합니다."
	EQCompare_SKIN_DESC = "oSkin/Skinner 툴팁 텍스쳐를 사용하지 않습니다."
	EQCompare_MERCHANTAUCTIONKEY_DESC = "상점/경매장 비교시 키 고정을 활성화합니다."
	EQCompare_HOVERLINKKEY_DESC = "대화창 링크 비교시 키 고정을 활성화 합니다."
elseif (GetLocale() == "zhCN") then
	INVTYPE_GUN = "枪械"
	INVTYPE_CROSSBOW="弩"
	INVTYPE_WAND = "魔杖"
	INVTYPE_THROWN = "投掷武器"
	INVTYPE_GUNPROJECTILE = "弹药"
	INVTYPE_BOWPROJECTILE = "弹药"

	EQCompare_KEY_DESC = "当按住设定的按键时才显示对比信息."
	EQCompare_RESET_DESC = "重置所有选项."
	EQCompare_RESET = "所有选项已重置."
	EQCompare_HOVERLINK_DESC = "当鼠标移动到聊天窗口的超链接时自动显示信息."
	EQCompare_HOVERLINK_SAFE_DESC = "使用安全模式显示鼠标所在处超链接信息."
	EQCompare_SKIN_DESC = "关闭oSkin的支持."
	EQCompare_MERCHANTAUCTIONKEY_DESC = "启用 商人售卖和拍卖行对比信息显示 需要按住设定按键."
	EQCompare_HOVERLINKKEY_DESC = "启用 鼠标移动到聊天窗口的超链接时信息显示 需要按住设定按键."
else
	INVTYPE_GUN = "Gun"
	INVTYPE_CROSSBOW = "Crossbow"
	INVTYPE_WAND = "Wand"
	INVTYPE_THROWN = "Thrown"
	INVTYPE_GUNPROJECTILE = "Projectile"
	INVTYPE_BOWPROJECTILE = "Projectile"
end

EQCompare = AceLibrary("AceAddon-2.0"):new("AceHook-2.1", "AceDB-2.0", "AceConsole-2.0")

function EQCompare:OnInitialize()
	self.CMP_INV_SLOT = {
		[INVTYPE_2HWEAPON]={16,17},
		[INVTYPE_BODY]={4},
		[INVTYPE_CHEST]={5},
		[INVTYPE_CLOAK]={15},
		[INVTYPE_FEET]={8},
		[INVTYPE_FINGER]={11,12},
		[INVTYPE_HAND]={10},
		[INVTYPE_HEAD]={1},
		[INVTYPE_HOLDABLE]={17},
		[INVTYPE_LEGS]={7},
		[INVTYPE_NECK]={2},
		[INVTYPE_RANGED]={18},
		[INVTYPE_RELIC]={18},
		[INVTYPE_ROBE]={5},
		[INVTYPE_SHIELD]={17},
		[INVTYPE_SHOULDER]={3},
		[INVTYPE_TABARD]={19},
		[INVTYPE_TRINKET]={13,14},
		[INVTYPE_WAIST]={6},
		[INVTYPE_WEAPON]={16,17},
		[INVTYPE_WEAPONMAINHAND]={16},
		[INVTYPE_WEAPONOFFHAND]={17},
		[INVTYPE_WRIST]={9},
		-- need localization for following
		[INVTYPE_GUN]={18},
		[INVTYPE_CROSSBOW]={18},
		[INVTYPE_WAND]={18},
		[INVTYPE_THROWN]={18},
		[INVTYPE_GUNPROJECTILE]={0},
		[INVTYPE_BOWPROJECTILE]={0},
	}

	--init saved variables
	self:RegisterDB("EQCompareDB")
	self:RegisterDefaults("profile", {
		key = "none",
		hoverLink = false,
		hoverLinkSafe = true,
		skin = true,
		hoverLinkKey = true,
		merchantAuctionKey = true
	})

	-- register console slash commands
	self:RegisterChatCommand(
		{ "/eqcompare", "/eqc" },
		{
			type = "group",
			args = {
				key = {
					order = 100,
					type = "text",
					name = "key",
					desc = EQCompare_KEY_DESC,
					usage = "<keyname>",
					validate = {"none","ctrl","alt","shift"},
					get = function() return self.db.profile.key end,
					set = function(c)
						self.db.profile.key = c
						self:SetupOriginHook()
					end
				},
				hoverlink = {
					order = 200,
					type = "toggle",
					name = "hoverlink",
					desc = EQCompare_HOVERLINK_DESC,
					get = function() return self.db.profile.hoverLink end,
					set = function(c)
						self.db.profile.hoverLink = c
						self:HoverHyperlink_Toggle()
					end
				},
				hoverlink_safe = {
					order = 210,
					type = "toggle",
					name = "hoverlink safe mode",
					desc = EQCompare_HOVERLINK_SAFE_DESC,
					get = function() return self.db.profile.hoverLinkSafe end,
					set = function(c)
						self.db.profile.hoverLinkSafe = c
					end
				},
				merchantauctionkey = {
					order = 220,
					type = "toggle",
					name = "Merchant/Auction holding key",
					desc = EQCompare_MERCHANTAUCTIONKEY_DESC,
					get = function() return self.db.profile.merchantAuctionKey end,
					set = function(c)
						self.db.profile.merchantAuctionKey = c
					end
				},
				hoverlinkkey = {
					order = 230,
					type = "toggle",
					name = "Hoverlink holding key",
					desc = EQCompare_HOVERLINKKEY_DESC,
					get = function() return self.db.profile.hoverLinkKey end,
					set = function(c)
						self.db.profile.hoverLinkKey = c
					end
				},
				skin = {
					order = 300,
					type = "toggle",
					name = "Turn off oSkin/Skinner support",
					desc = EQCompare_SKIN_DESC,
					get = function() return self.db.profile.skin end,
					set = function(c)
						self.db.profile.skin = c
					end
				},
				reset = {
					order = 400,
					type = "execute",
					name = "reset",
					desc = EQCompare_RESET_DESC,
					func = function()
						self:ResetDB("profile")
						self:HoverHyperlink_Toggle()
						self:SetupOriginHook()
						self:Print(EQCompare_RESET)
					end
				}
			}
		}
	)
	--save bliz origin functions
	self.origin={ShoppingTooltip1={}, ShoppingTooltip2={}}
	local _G = getfenv(0)
	self.origin.ShoppingTooltip1.SetAuctionCompareItem = _G.ShoppingTooltip1.SetAuctionCompareItem
	self.origin.ShoppingTooltip1.SetMerchantCompareItem = _G.ShoppingTooltip1.SetMerchantCompareItem
	self.origin.ShoppingTooltip2.SetAuctionCompareItem = _G.ShoppingTooltip2.SetAuctionCompareItem
	self.origin.ShoppingTooltip2.SetMerchantCompareItem = _G.ShoppingTooltip2.SetMerchantCompareItem
end

function EQCompare:OnEnable()
	self:SecureHook("SetItemRef")
	self:HookScript(ItemRefTooltip, "OnHide", "Tooltip_OnHide")
	self:HookScript(GameTooltip, "OnShow", "Tooltip_OnShow")
	self:HoverHyperlink_Toggle()
	self:Compatibility()
	self:SetupOriginHook()
end

function EQCompare:OnDisable()
	self:Compatibility()
	self:SetupOriginHook(true)
end

function EQCompare:GetInventorySlot(tooltip)
	--possible texts starting at 2nd line. the first line is item name
	for i=2,5 do
		local text=getglobal(tooltip:GetName().."TextLeft"..i):GetText()
		if text and self.CMP_INV_SLOT[text] then
			local match_inv = self.CMP_INV_SLOT[text]

			-- check used slot
			local slot = {}
			for _,v in ipairs(match_inv) do
				local item=GetInventoryItemLink("player",v)
				if item then
					tinsert(slot, v)
				end
			end
			return slot
		end
	end
	return {}
end

function EQCompare:Tooltip_OnShow(object)
	--call origin script hook except ItemRefTooltip
	--call this at first may fix a lot problem, and keep compat with other mods
	if object ~= ItemRefTooltip then
		self.hooks[object].OnShow(object)
	end

	--check object if valid
	if type(object)~="table" then return end

	--check compare holding key
	if not self:CheckHoldKey() then return end

	--bypass these frame, WorldFrame, player's paperdoll, weapon enchants
	local frame=GetMouseFocus() and GetMouseFocus():GetName() or ""
	if frame == "WorldFrame" or strfind(frame,"^Character.*Slot$") or strfind(frame,"^TempEnchant%d+$")	then return end

	--check if any matched inventory items
	local slot = self:GetInventorySlot(object)
	if getn(slot) == 0 then return end

	--use custom tooltip to display compare info for ItemRefTooltip.
	--so it's stick display while mouse hover other things.
	local tooltip
	if object == ItemRefTooltip then
		tooltip = "EQCompareTooltip"
	else
		tooltip = "ShoppingTooltip"
	end

	--place code copy from QuickCompare, correct anchor if tooltip is in right half of screen
	local anchor,align="TOPLEFT","TOPRIGHT"
	local scale=object:GetScale()
	local tipleft=object:GetLeft()
	if tipleft and tipleft*scale>=UIParent:GetRight()/2 then
		anchor, align = align, anchor
	end
	local anchorframe = object
	local dy=-10*scale

	--display compare tooltip matched inv slot
	for i,invslot in ipairs(slot) do
		local shoptip=getglobal(tooltip..i)
		local shoptiptext=getglobal(shoptip:GetName().."TextLeft1")

		shoptip:SetOwner(object, "ANCHOR_NONE")
		shoptip:SetInventoryItem("player",invslot)
		shoptip:SetScale(scale)
		--reset tooltip point, so it can get the correct bottom and top position later.
		shoptip:ClearAllPoints()
		shoptip:SetPoint(anchor,anchorframe,align,0,dy)

		--show Currently Equipped in lightyellow
		local oldtext=shoptiptext:GetText() or ""
		local newtext=LIGHTYELLOW_FONT_COLOR_CODE..CURRENTLY_EQUIPPED.. FONT_COLOR_CODE_CLOSE.."\n"
		shoptiptext:SetText(newtext..oldtext)
		shoptiptext:SetJustifyH("LEFT")

		--place code copy from QuickCompare, correct placement, don't go off screen
		--coords get larger as move up: 0 at bottom, screen height at top
		local bottom,top=shoptip:GetBottom(),shoptip:GetTop()
		local uibottom,uitop=UIParent:GetBottom(),UIParent:GetTop()
		if bottom and bottom*scale-10<=uibottom then
			--10 for padding
			dy=uibottom-bottom+(10*scale)
		elseif top and (top+32)*scale>=uitop then
			--32 for icon
			top=(top+32)*scale
			dy=uitop-top-20
		end
		shoptip:ClearAllPoints()
		shoptip:SetPoint(anchor,anchorframe,align,0,dy)

		if (IsAddOnLoaded("oSkin") and self.db.profile.skin) then
			oSkin:skinTooltip(shoptip)
		end
		
		if (IsAddOnLoaded("Skinner") and self.db.profile.skin) then
			Skinner:skinTooltip(shoptip)
		end

		shoptip:Show()

		--last comparison tooltip becomes anchorframe for next comparison tooltip
		anchorframe=shoptip
		dy=0
	end
end

--[[ Hook SetItemRef, for display compare tooltip while clicked hyperlink in ChatFrame ]]--
function EQCompare:SetItemRef(link, text, button)
	--only process tooltip for item
	if strfind(link,"^item") then
		--because SetItemRef will not display item tooltip while holding shift and ctrl key
		local key = self:CheckHoldKey()
		if key and key~="none" and key~="alt" then
			ShowUIPanel(ItemRefTooltip);
			if ( not ItemRefTooltip:IsVisible() ) then
				ItemRefTooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
			end
			ItemRefTooltip:SetHyperlink(link);
		end

		EQCompareTooltip1:Hide()
		EQCompareTooltip2:Hide()
		self:Tooltip_OnShow(ItemRefTooltip)
	end
end

--[[ Custom tooltip OnHide codes ]]--
function EQCompare:Tooltip_OnHide()
	self.hooks[this].OnHide()
	EQCompareTooltip1:Hide()
	EQCompareTooltip2:Hide()
end

--[[ ShoppingTooltip OnHide codes ]]--
function EQCompare:ShoppingTooltip_OnHide()
	self.hooks[this].OnHide()
	ShoppingTooltip1:Hide()
	ShoppingTooltip2:Hide()
end

--[[ Codes for display tooltip while mouse hovering hyperlink in ChatFrame ]]--
function EQCompare:CheckHoldKey()
	local key = self.db.profile.key
	if key == "none" then
		return "none"
	elseif key == "ctrl" and IsControlKeyDown() then
		return "ctrl"
	elseif key == "alt" and IsAltKeyDown() then
		return "alt"
	elseif key == "shift" and IsShiftKeyDown() then
		return "shift"
	end
end

function EQCompare:HoverHyperlink_Toggle()
	if self.db.profile.hoverLink then
		for i=1, NUM_CHAT_WINDOWS do
			local frame=getglobal("ChatFrame"..i)
			if not self:IsHooked(frame, "OnHyperlinkEnter") then
				self:HookScript(frame, "OnHyperlinkEnter")
			end
			if not self:IsHooked(frame, "OnHyperlinkLeave") then
				self:HookScript(frame, "OnHyperlinkLeave")
			end
		end
	else
		for i=1, NUM_CHAT_WINDOWS do
			local frame=getglobal("ChatFrame"..i)
			if self:IsHooked(frame, "OnHyperlinkEnter") then
				self:Unhook(frame, "OnHyperlinkEnter")
			end
			if self:IsHooked(frame, "OnHyperlinkLeave") then
				self:Unhook(frame, "OnHyperlinkLeave")
			end
		end
	end
end

function EQCompare:OnHyperlinkEnter(object)
	--checking if hoverlink feature is enabled
	if not self.db.profile.hoverLink then
		self:HoverHyperlink_Toggle()
		return self.hooks[object].OnHyperlinkEnter()
	end
	--chekcing holding key
	if not self:CheckHoldKey() and self.db.profile.hoverLinkKey then
		return self.hooks[object].OnHyperlinkEnter()
	end

	local link=arg1
	--only display tooltip for item or enchanting
	if strfind(link,"^item") then
		--process safe check for item link, don't disconnect me.
		local name,elink,quality=GetItemInfo(link)

		if self.db.profile.hoverLinkSafe then
			if name then
				GameTooltip:SetOwner(object,"ANCHOR_TOPRIGHT")
				GameTooltip:SetHyperlink(link)
				GameTooltip:Show()

				--Auctioneer/Enchantrix/EnhTooltip/Informant support
				if (EnhTooltip and elink and quality) then
					local item = EnhTooltip.FakeLink(elink, quality, name)
					EnhTooltip.TooltipCall(GameTooltip, name, item, quality, 1)
				end
			end
		else
			GameTooltip:SetOwner(object,"ANCHOR_TOPRIGHT")
			GameTooltip:SetHyperlink(link)
			GameTooltip:Show()

			--Auctioneer/Enchantrix/EnhTooltip/Informant support
			if (EnhTooltip and name and elink and quality) then
				local item = EnhTooltip.FakeLink(elink, quality, name)
				EnhTooltip.TooltipCall(GameTooltip, name, item, quality, 1)
			end
		end

	elseif strfind(link,"^enchant") then
		GameTooltip:SetOwner(object,"ANCHOR_TOPRIGHT")
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	end

	return self.hooks[object].OnHyperlinkEnter()
end

function EQCompare:OnHyperlinkLeave(object)
	if not self.db.profile.hoverLink then
		self:HoverHyperlink_Toggle()
	end
	GameTooltip:Hide()
	return self.hooks[object].OnHyperlinkLeave()
end

--[[ Support for other mod to register tooltip hook ]]--
function EQCompare:RegisterTooltip(tooltip)
	if type(tooltip)~="table" then return end

	if not self:IsHooked(tooltip, "OnShow") then
		self:HookScript(tooltip, "OnShow", "Tooltip_OnShow")
	end
	if not self:IsHooked(tooltip, "OnHide") then
		self:HookScript(tooltip, "OnHide", "ShoppingTooltip_OnHide")
	end
end

function EQCompare:UnRegisterTooltip(tooltip)
	if type(tooltip)~="table" then return end

	if self:IsHooked(tooltip, "OnShow") then
		self:Unhook(tooltip, "OnShow")
	end
	if self:IsHooked(tooltip, "OnHide") then
		self:Unhook(tooltip, "OnHide")
	end
end

--[[ Compat codes ]]--
function EQCompare:Compatibility()
	if self:IsActive() then
		--compat EquipCompare
		EquipCompare_RegisterTooltip=function(t) EQCompare:RegisterTooltip(t) end
		EquipCompare_UnregisterTooltip=function(t) EQCompare:UnRegisterTooltip(t) end
		--compat AtlasLoot
		if AtlasLootTooltip then
			AtlasLootOptionsFrameEquipCompare:SetChecked(true)
			AtlasLoot.db.profile.EquipCompare = true
			self:RegisterTooltip(AtlasLootTooltip)
		end

	--EQC disable codes
	else
		--compat EquipCompare
		EquipCompare_RegisterTooltip=nil
		EquipCompare_UnregisterTooltip=nil
		--compat AtlasLoot
		if AtlasLootTooltip then
			self:UnRegisterTooltip(AtlasLootTooltip)
		end
	end
end

--[[ Setup Bliz origin compare tooltip hook for holding key enabled ]]--
function EQCompare:SetupOriginHook(unload)
	--restore origin functions
	if self.db.profile.key=="none" or unload then
		ShoppingTooltip1.SetAuctionCompareItem = self.origin.ShoppingTooltip1.SetAuctionCompareItem
		ShoppingTooltip1.SetMerchantCompareItem = self.origin.ShoppingTooltip1.SetMerchantCompareItem
		ShoppingTooltip2.SetAuctionCompareItem = self.origin.ShoppingTooltip2.SetAuctionCompareItem
		ShoppingTooltip2.SetMerchantCompareItem = self.origin.ShoppingTooltip2.SetMerchantCompareItem
	else
		ShoppingTooltip1.SetAuctionCompareItem = function(a1,a2,a3,a4,a5)
			if EQCompare:CheckHoldKey() or not self.db.profile.merchantAuctionKey then
				return EQCompare.origin.ShoppingTooltip1.SetAuctionCompareItem(a1,a2,a3,a4,a5)
			end
		end
		ShoppingTooltip1.SetMerchantCompareItem = function(a1,a2,a3,a4,a5)
			if EQCompare:CheckHoldKey() or not self.db.profile.merchantAuctionKey then
				return EQCompare.origin.ShoppingTooltip1.SetMerchantCompareItem(a1,a2,a3,a4,a5)
			end
		end
		ShoppingTooltip2.SetAuctionCompareItem = function(a1,a2,a3,a4,a5)
			if EQCompare:CheckHoldKey() or not self.db.profile.merchantAuctionKey then
				return EQCompare.origin.ShoppingTooltip2.SetAuctionCompareItem(a1,a2,a3,a4,a5)
			end
		end
		ShoppingTooltip2.SetMerchantCompareItem = function(a1,a2,a3,a4,a5)
			if EQCompare:CheckHoldKey() or not self.db.profile.merchantAuctionKey then
				return EQCompare.origin.ShoppingTooltip2.SetMerchantCompareItem(a1,a2,a3,a4,a5)
			end
		end
	end
end
