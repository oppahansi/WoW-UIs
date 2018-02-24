local MAJOR_VERSION = "Threat-2.0"
local MINOR_VERSION = tonumber(("$Revision: 73134 $"):match("%d+"))

if MINOR_VERSION > _G.ThreatLib_MINOR_VERSION then _G.ThreatLib_MINOR_VERSION = MINOR_VERSION end

ThreatLib_funcs[#ThreatLib_funcs+1] = function()

	local ThreatLib = _G.ThreatLib
	local VERAS_ID = 22952

	ThreatLib:GetModule("NPCCore"):RegisterModule(VERAS_ID, function(Council)
		function Council:Init()
			self:RegisterCombatant(VERAS_ID, true)
			-- Veras Darkshadow vanish
			self.buffFades[41479] = function(self, npc_id)
					if npc_id == VERAS_ID then
						self:WipeRaidThreatOnMob(npc_id)
					end
				end
		end
	end)
end
