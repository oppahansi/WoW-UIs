
-- Saved variables are needed, to receive  VARIABLES_LOADED event
BookOfTracks_Data = {}

-- List of known tracking skills
local BookOfTracks_Skills = {}

local BookOfTrack_Events =
{
	"VARIABLES_LOADED",
	"PLAYER_AURAS_CHANGED",
	"SPELLS_CHANGED",
	"LEARNED_SPELL_IN_TAB"
}


-------------------------------------------------------------------------------
-- Feedback functions
-------------------------------------------------------------------------------

function BoT_ChatMsg( msg, verbose_only )

	if( DEFAULT_CHAT_FRAME and (not verbose_only or verbose_only==false) ) then
		DEFAULT_CHAT_FRAME:AddMessage( "[BoT] "..msg, 0.0, 1.0, 0.0 )
	end

end


-------------------------------------------------------------------------------
-- <OnLoad> handling
-------------------------------------------------------------------------------

function BoT_OnLoad()

	-- Register events
	for index, event in BookOfTrack_Events do
		this:RegisterEvent( event )
	end

end



-------------------------------------------------------------------------------
-- <OnEvent> handling
-------------------------------------------------------------------------------

function BoT_OnEvent()
	
	if( event=="PLAYER_AURAS_CHANGED" ) then

		-- Hide the default tracking icon.
		if( MiniMapTrackingFrame )then
			MiniMapTrackingFrame:Hide()
		end

		local icon = GetTrackingTexture()
		if ( icon ) then
			BookOfTracksIcon:SetTexture( icon )
		else
			BookOfTracksIcon:SetTexture("Interface\\AddOns\\BookOfTracks\\Images\\Empty")
		end

	elseif( event=="VARIABLES_LOADED" ) then

		BookOfTracksFrame:SetPoint( "TOPLEFT", "Minimap", "TOPLEFT", -15, 0 )

		BoT_FillDropDown()

	elseif( event=="SPELLS_CHANGED" or event=="LEARNED_SPELL_IN_TAB" ) then

		BoT_FillDropDown()

	end

end

-------------------------------------------------------------------------------
-- <OnMouseUp> handling : 'Disable tracking' or 'show menu'
-------------------------------------------------------------------------------

function BoT_OnClick( arg1 )

	local icon = GetTrackingTexture()

	if( arg1=="RightButton" and icon ) then
		CancelTrackingBuff()
	else
		BoT_ToggleDropDown()
	end

end


function BoT_ToggleDropDown()

	ToggleDropDownMenu( 1, nil, BookOfTracksDropDown )

end


-------------------------------------------------------------------------------
-- Dropdown is initialized when necessary. No need to refill on each toggle
-------------------------------------------------------------------------------


function BoT_FillDropDown()

	UIDropDownMenu_Initialize( BookOfTracksDropDown, BoT_DropDown_Init, "MENU" )

end

--- www.lua.org
function pairsByKeys (t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if a[i] == nil then
			return nil
		else
			return a[i], t[a[i]]
		end
	end
	return iter
end


function BoT_DropDown_Init()
	
	-- Reset skill table
	BookOfTracks_Skills = {}
		
	-- Scan spell book
	local continue_loop = true
	local num_skill = 1

	while continue_loop do
		local skill_name, skill_rank = GetSpellName( num_skill, BOOKTYPE_SPELL )
		if( skill_name ) then

			local pattern = "|"..skill_name.."|"

			-- Necessary split for search because of localization issues
			if( GetLocale()=="deDE" ) then
				if( string.find( BOT_ALL_SKILLS, pattern ) ) then
					BookOfTracks_Skills[num_skill] = skill_name
				end
			elseif( string.find( pattern, BOT_FINDS ) or string.find( pattern, BOT_TRACKS ) or string.find( pattern, BOT_SENSES ) ) then
				BookOfTracks_Skills[num_skill] = skill_name
			end

			-- Increase skill num
			num_skill = num_skill + 1

		else
			continue_loop = nil
		end
	end

	
	-- Fill dropdown, sorted by spell order in spells tab
	local info = {}
	info.notCheckable = 1
	info.justifyH = "Left"
	info.func = BoT_OnClickSkill

	local show_button = nil

	for num, skill in pairsByKeys(BookOfTracks_Skills) do
		show_button = true
		info.text = skill
		UIDropDownMenu_AddButton(info)
	end

	-- Show replacement icon (if at least one skill is usable)
	if( show_button ) then
		BookOfTracksFrame:Show()
	else
		BookOfTracksFrame:Hide()
	end
end


function BoT_OnClickSkill()
	CastSpellByName( this:GetText() )
	BoT_ToggleDropDown()
end
