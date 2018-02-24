AutoAcceptInvite = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0")
AutoAcceptInvite:RegisterDB("AutoAcceptInviteVars")
AutoAcceptInvite:RegisterDefaults("account",{["accept"]={},["deny"]={},["settings"]={}})

AutoAcceptInvite:RegisterChatCommand({"/autoacceptinvite","/aai"},{
	type= 'group',
	args= {
		accept= {
			name= "Allow List",
			desc= "Add a name to autoaccept list", 
			type= 'text', 
			usage="<name>", 
			set= function(name)
				name=strlower(name)
				AutoAcceptInvite.db.account.accept[name]=1
				AutoAcceptInvite.db.account.deny[name]=nil
			end, 
			get=function()
				local x=""
				for k,v in AutoAcceptInvite.db.account.accept do
					if x=="" then
						x=x..k
					else
						x=x..", "..k
					end
				end
				return x
			end, 
			validate = function(name)
				return string.find(name, "^%w+$")
			end
		},
		deny = {
			name= "Deny List",
			desc= "Add a name to autodeny list", 
			type= 'text', 
			usage="<name>", 
			set= function(name)
				name=strlower(name)
				AutoAcceptInvite.db.account.accept[name]=nil
				AutoAcceptInvite.db.account.deny[name]=1
			end, 
			get=function()
				local x=""
				for k,v in AutoAcceptInvite.db.account.deny do
					if x=="" then
						x=x..k
					else
						x=x..", "..k
					end
				end
				return x
			end, 
			validate = function(name)
				return string.find(name, "^%w+$")
			end
		},
		remove = {
			name= "Remove From List",
			desc= "Remove a name from list (returns to popup)", type= 'text', 
			usage="<name>", 
			set= function(name)
				name=strlower(name)
				AutoAcceptInvite.db.account.deny[name]=nil
				AutoAcceptInvite.db.account.accept[name]=nil
			end, 
			get=function()
				local x,y="","";
				for k,v in AutoAcceptInvite.db.account.accept do
					if x=="" then
						x=x..k
					else
						x=x..", "..k
					end
				end
				for k,v in AutoAcceptInvite.db.account.deny do
					if x=="" then
						x=x..k
					else
						x=x..", "..k
					end
				end
				return x
			end, 
			validate = function(name)
				return string.find(name, "^%w+$")
			end
		},
		guild = {
			name= "Allow Guild",
			desc="Allow auto-invites from Guildies", 
			type='execute', 
			func= function()
				AutoAcceptInvite.db.account.settings.guild=not(AutoAcceptInvite.db.account.settings.guild) or nil
				AutoAcceptInvite:Print("Accept invites from guildmates set to:"..(AutoAcceptInvite.db.account.settings.guild and "true" or "false"))
			end,
			get= function()
				return AutoAcceptInvite.db.account.settings.guild and "true" or "false"
			end
		},
		friend = {
			name="Allow Friend",
			desc="Allow auto-invites from Friends",
			type='execute',
			func= function()
				AutoAcceptInvite.db.account.settings.friend=not(AutoAcceptInvite.db.account.settings.friend) or nil
				AutoAcceptInvite:Print("Accept invites from friends set to:"..(AutoAcceptInvite.db.account.settings.friend and "true" or "false"))
			end,
			get= function()
				return AutoAcceptInvite.db.account.settings.friend and "true" or "false"
			end
		},
		reset = {
			name= "Reset",	
			desc= "Reset allow/deny lists",
			type= 'execute',
			func= function()
				AutoAcceptInvite.db.account.accept={}
				AutoAcceptInvite.db.account.deny={}
				AuotAcceptInvite.db.account.settings.guild=nil
			end
		}
	}
})

function AutoAcceptInvite:OnInitialize()
	self:RegisterEvent("PARTY_INVITE_REQUEST")
	self:Print("Enabled")
end


function AutoAcceptInvite:OnEnable()
	self:RegisterEvent("PARTY_INVITE_REQUEST")
	self:Print("Enabled")
end

function AutoAcceptInvite:OnDisable()
	self:Print("Disabled")
end

function AutoAcceptInvite:PARTY_INVITE_REQUEST(name)
	local name=strlower(name)
	self:Print(name,"requesting invite!")
	if self.db.account.deny[name] then
		DeclineGroup()
		StaticPopup_Hide("PARTY_INVITE")
		self:Print("Invite from",name,"declined")
	end
	if self.db.account.accept[name] or (self.db.account.settings.guild and AutoAcceptInvite:IsGuildmate(name)) or (self.db.account.settings.friend and AutoAcceptInvite:IsFriend(name)) then
		AcceptGroup()
		StaticPopup_Hide("PARTY_INVITE")
	end
end

function AutoAcceptInvite:IsGuildmate(name)
	if (IsInGuild()) then
		local ngm=GetNumGuildMembers()
		for i=1, ngm do
			if (strlower((GetGuildRosterInfo(i))) == strlower(name)) then
				return true
			end
		end
	end
end

function AutoAcceptInvite:IsFriend(name)
	local nf=GetNumFriends()
	for i=1, nf do
		if (strlower((GetFriendInfo(i))) == strlower(name)) then
			return true
		end
	end
end

