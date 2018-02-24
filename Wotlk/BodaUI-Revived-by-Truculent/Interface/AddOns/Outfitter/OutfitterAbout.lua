----------------------------------------
-- Outfitter Copyright 2009 John Stephen, wobbleworks.com
-- All rights reserved, unauthorized redistribution is prohibited
----------------------------------------

-- 0 Friend
-- 1 Tester
-- 2 Localizer
-- 3 Donor

Outfitter.CreditPlayersByRealm =
{
	[Outfitter.cGermanLocalization] =
	{
		["Ani"] = 2,
		["Zokrym"] = 2,
		["Dessa"] = 2,
	},
	[Outfitter.cChineseLocalization] =
	{
		["AndyAska"] = 2,
		["xingdvd"] = 2,
	},
	[Outfitter.cFrenchLocalization] =
	{
		["Jullye"] = 2,
		["Quetzaco"] = 2,
		["Ekhurr"] = 2,
		["Negwe"] = 2,
	},
	[Outfitter.cSpanishLocalization] =
	{
		["Marutak"] = 2,
		["Marosth"] = 2,
	},
	[Outfitter.cRussianLocalization] =
	{
		["Delika"] = 2,
	},
	[Outfitter.cKoreanLocalization] =
	{
		["Unknown"] = 2,
	},
	[Outfitter.cContributingDeveloper] =
	{
		["Dridzt"] = 1,
		["Bruce Quinton"] = 1,
		["Kal_Zakath13"] = 1,
		["Smurfy"] = 1,
		["XMinionX"] = 1,
		["Dussander"] = 1,
		["Echobravo"] = 1,
		["MacGregor"] = 1,
	},
	["Tester"] =
	{
		["Whishann"] = 1,
		["HunterZ"] = 1,
		["docthis"] = 1,
		["Irdx"] = 1,
		["TigaFIN"] = 1,
		["iceeagle"] = 1,
		["Denrax"] = 1,
		["rasmoe"] = 1,
		["Katlefiya"] = 1,
		["gtmsece"] = 1,
		["Militis"] = 1,
		["Casard"] = 1,
		["saltorio"] = 1,
		["elusif"] = 1,
		["DanoPDX"] = 1,
	},
	["Alterac Mountains"] =
	{
		["Asgeirr\n<The Stone Council>"] = 3,
	},
	["Aman'Thul"] =
	{
		["Blessmie\n<Chairman of the Horde>"] = 3,
		["Zanoroy\n<The Mighty Few>"] = 3,
	},
	["Antonidas"] =
	{
		["Colina\n<Drunken Monkey Brigade>"] = 3,
	},
	["Anvilmar"] =
	{
		["Droodwrmycar"] = 3,
	},
	["Azgalore"] =
	{
		["Dankris\n<Caligula's Pleasures>"] = 3,
	},
	["Blackwater Raiders"] =
	{
		["Maumau\n<No Quarter>"] = 3,
	},
	["Bronzebeard"] =
	{
		["Jiminimonka\n<Go Rin No Sho>"] = 3,
	},
	["Dalaran"] =
	{
		["Y C\n<Blurred Reality>"] = 3,
	},
	["Draenor"] =
	{
		["Emmerald\n<Adept>"] = 3,
	}, 
	["Draka"] =
	{
		["Nagem\n<Loch Modan Yacht Club"] = 3,
	},
	["Durotar"] =
	{
		["Haguen"] = 3,
	},
	Ghostlands =
	{
		Nounchok = 3,
	},
	["Gnomeregan"] =
	{
		["Calind\n<Swords of the Alliance>"] = 3,
	},
	["Jubei'Thos"] =
	{
		["Thoresen\n<Verb>"] = 3,
		["Thorgils"] = 3,
	},
	["Kargath"] =
	{
		["Leara"] = 3,
		["Burnaron\nLiga of Faliviens"] = 3,
	},
	["Khaz Modan"] =
	{
		["Faizal"] = 3,
	},
	["Khaz'goroth"] =
	{
		["Xentric\n<Cult of the Nuzzled Nark>"] = 3,
	},
	["Kul'Tiras"] =
	{
		["Tharca"] = 3,
	},
	["Lightbringer"] =
	{
		["Teldra\n<The Trust>"] = 3,
	},
	["Llane"] =
	{
		["Chirily"] = 3,
	},
	["Malfurion"] =
	{
		["Zetac\n<Hold Fast>"] = 3,
	},
	["Moonglade"] =
	{
		["Ciev"] = 3,
	},
	["Rexxar"] =
	{
		["Blitzi\n<Absolution>"] = 3,
	},
	["Scilla"] =
	{
		["Blam\n<Syndicate>"] = 3,
	},
	["Sentinels"] =
	{
		["Dhaktar"] = 3,
	},
	["Skywall"] =
	{
		["Valerya"] = 3,
	},
	["Suramar"] =
	{
		["Zendex"] = 3,
		["Klaxon\n<Forbidden Planet"] = 3,
	},
	["Terrokkar"] =
	{
		["Extropianus\n<The First Immortals>"] = 3,
	},
	["Thorium Brotherhood"] =
	{
		["Pitchifus\n<Bloodforged>"] = 0,
		Tiae = 0,
		Airmid = 0,
		Pistachio = 0,
		Fizzlebang = 0,
		[Outfitter.cGuildCreditFormat:format("Bloodforged")] = 1,
	},
	["Ysondre"] =
	{
		["Steikfrit"] = 3,
	},
	["Zangarmarsh"] =
	{
		["Feliany"] = 3,
	},
}

----------------------------------------
Outfitter._AboutView = {}
----------------------------------------

function Outfitter._AboutView:New(pParent)
	return OutfitterAboutFrame
end

function Outfitter._AboutView:Construct(pParent)
	self.Title = self:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	self.Title:SetPoint("TOP", self, "TOP", -4, -36)
	self.Title:SetWidth(230)
	self.Title:SetText(Outfitter.cAboutTitle:format(Outfitter.cVersion))
	
	self.AuthorText = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	self.AuthorText:SetPoint("TOP", self.Title, "BOTTOM", 0, -15)
	self.AuthorText:SetWidth(230)
	self.AuthorText:SetJustifyH("CENTER")
	self.AuthorText:SetText(Outfitter.cAboutAuthor)
	
	self.CopyrightText = self:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	self.CopyrightText:SetPoint("TOP", self.AuthorText, "BOTTOM", 0, -10)
	self.CopyrightText:SetWidth(230)
	self.CopyrightText:SetJustifyH("CENTER")
	self.CopyrightText:SetText(Outfitter.cAboutCopyright)
	
	self.ThanksText = self:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	self.ThanksText:SetPoint("TOP", self.CopyrightText, "BOTTOM", 0, -10)
	self.ThanksText:SetWidth(230)
	self.ThanksText:SetJustifyH("CENTER")
	self.ThanksText:SetText(Outfitter.cAboutThanks)
	
	self.Credits = Outfitter:New(Outfitter._Credits, self)
	self.Credits:SetPoint("TOP", self.ThanksText, "BOTTOM", 0, -10)
	self.Credits:SetWidth(230)
	self.Credits:SetHeight(200)
	
	--self.TestTexture = self.Credits:CreateTexture(nil, "OVERLAY")
	--self.TestTexture:SetAllPoints()
	--self.TestTexture:SetTexture(1, 0, 0, 0.5)
end

----------------------------------------
Outfitter._Credits = {}
----------------------------------------

function Outfitter._Credits:New(pParent)
	return CreateFrame("Frame", nil, pParent)
end

function Outfitter._Credits:Construct(pParent)
	self.CreditFrames = {}
	self.AvailableCreditFrames = {}
	
	self:SetScript("OnShow", self.OnShow)
	self:SetScript("OnHide", self.OnHide)
	self:SetScript("OnUpdate", self.OnUpdate)
	
	-- Compile the list
	
	-- Add everything except the current realm
	
	self.Players = {}
	
	for vRealm, vRealmPlayers in pairs(Outfitter.CreditPlayersByRealm) do
		if vRealm ~= Outfitter.RealmName then
			for vPlayerName, vPlayerInfo in pairs(vRealmPlayers) do
				if type(vPlayerInfo) == "number" then
					table.insert(self.Players,
					{
						Name = vPlayerName,
						Realm = vRealm,
						Level = vPlayerInfo
					})
				end
			end
		end
	end -- for
	
	-- Add the current realm
	
	local vRealmPlayers = Outfitter.CreditPlayersByRealm[Outfitter.RealmName]
	
	if vRealmPlayers then
		-- Calculate how many players there are in the current realm
		
		local vNumRealmPlayers = 0
		
		for vPlayerName, vPlayerInfo in pairs(vRealmPlayers) do
			vNumRealmPlayers = vNumRealmPlayers + 1
		end
		
		-- Calculate the desired percentage of players from this realm.  This
		-- ensures that donors and other contributors will show up more often
		-- to themselves and other players on their realms
		
		local vLocalPercentage = 0.02 * vNumRealmPlayers
		
		if vLocalPercentage > 0.5 then
			vLocalPercentage = 0.5
		end
		
		-- Calculate the minimum number of players to add and repeatedly add the
		-- realm until that minimum is met
		
		local vMinRealmPlayers = #self.Players * vLocalPercentage / (1 - vLocalPercentage)
		
		repeat
			for vPlayerName, vPlayerInfo in pairs(vRealmPlayers) do
				if type(vPlayerInfo) == "number" then
					table.insert(self.Players,
					{
						Name = vPlayerName,
						Realm = Outfitter.RealmName,
						Level = vPlayerInfo
					})
				end
				
				vMinRealmPlayers = vMinRealmPlayers - 1
			end
		until vMinRealmPlayers <= 0
	end
	
	self:Shuffle()
	
	self.PlayerIndex = 1
	self.NextPlayerTime = 0
end

function Outfitter._Credits:Shuffle()
	for _, vPlayerInfo in ipairs(self.Players) do
		vPlayerInfo.SortValue = math.random()
	end
	
	table.sort(self.Players, function (pInfo1, pInfo2)
		return pInfo1.SortValue < pInfo2.SortValue
	end)
end

function Outfitter._Credits:OnShow()
	while next(self.AvailableCreditFrames) do
		table.remove(self.AvailableCreditFrames)
	end
	
	for _, vCreditFrame in ipairs(self.CreditFrames) do
		table.insert(self.AvailableCreditFrames, vCreditFrame)
	end
end

function Outfitter._Credits:OnHide()
end

function Outfitter._Credits:OnUpdate(pElapsed)
	self.NextPlayerTime = self.NextPlayerTime - pElapsed
	
	if self.NextPlayerTime > 0 then
		return
	end
	
	self.NextPlayerTime = 1.2
	
	local vCreditFrame = table.remove(self.AvailableCreditFrames)
	
	if not vCreditFrame then
		vCreditFrame = Outfitter:New(Outfitter._CreditFrame, self)
		table.insert(self.CreditFrames, vCreditFrame)
	end
	
	vCreditFrame:SetPlayer(self.Players[self.PlayerIndex])
	vCreditFrame:Animate("DROPLET")
	
	self.PlayerIndex = self.PlayerIndex + 1
	
	if self.PlayerIndex > #self.Players then
		self:Shuffle()
		self.PlayerIndex = 1
	end
end

function Outfitter._Credits:ReleaseCreditFrame(pCreditFrame)
	table.insert(self.AvailableCreditFrames, pCreditFrame)
end

----------------------------------------
Outfitter._CreditFrame = {}
----------------------------------------

function Outfitter._CreditFrame:New(pParent)
	return CreateFrame("Frame", nil, pParent)
end

function Outfitter._CreditFrame:Construct(pParent)
	self.Width = 130
	self.Height = 30
	
	self.Line1 = self:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	self.Line1:SetPoint("TOP", self, "TOP")
	self.Line1:SetWidth(self.Width)
	
	self.Line2 = self:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	self.Line2:SetPoint("TOP", self.Line1, "BOTTOM")
	self.Line2:SetWidth(self.Width)
	
	self:SetWidth(self.Width)
	self:SetHeight(self.Height)
	
	--self.TestTexture = self:CreateTexture(nil, "OVERLAY")
	--self.TestTexture:SetAllPoints()
	--self.TestTexture:SetTexture(1, 0, 0, 0.5)
	
	self.DestWidth = self:GetParent():GetWidth() - self.Width
	self.DestHeight = self:GetParent():GetHeight() - self.Height
	
	self:SetScript("OnUpdate", self.OnUpdate)
end

function Outfitter._CreditFrame:SetPlayer(pPlayerInfo)
	self.Line1:SetText(pPlayerInfo.Name)
	self.Line2:SetText(pPlayerInfo.Realm)
end

function Outfitter._CreditFrame:Animate(pStyle)
	self.AnimationStyle = pStyle
	self.AnimationElapsed = 0
	
	if self.AnimationStyle == "DROPLET" then
		self.HorizPos = math.random() * self.DestWidth - 0.5 * self.DestWidth
		self.VertPos = 0
		
		self:SetPoint("TOP", self:GetParent(), "TOP", self.HorizPos, self.VertPos)
		self:SetAlpha(0)
		
		self.FadeInTime = 0.8
		
		self.VertVelocity = 0
		self.VertAccel = 0
	end
end

function Outfitter._CreditFrame:OnUpdate(pElapsed)
	if self.AnimationStyle == "DROPLET" then
		self.AnimationElapsed = self.AnimationElapsed + pElapsed
		
		if self.AnimationElapsed > self.FadeInTime then
			self:SetAlpha(1)
			
			self.VertAccel = -50
			self.VertVelocity = self.VertVelocity + self.VertAccel * pElapsed
			self.VertPos = self.VertPos + self.VertVelocity * pElapsed
			
			self:SetPoint("TOP", self:GetParent(), "TOP", self.HorizPos, self.VertPos)
			
			if self.VertPos < -self.DestHeight then
				self.AnimationStyle = nil
				self:SetAlpha(0)
				self:GetParent():ReleaseCreditFrame(self)
			end
		else
			self:SetAlpha(self.AnimationElapsed / self.FadeInTime)
		end
	end
end
