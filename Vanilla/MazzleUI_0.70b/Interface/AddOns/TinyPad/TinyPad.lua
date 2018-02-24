--[[ TinyPad 1.4

	TinyPad is a notepad mod.

	__ New in 1.4 __

	- Fixed Run Page bug (page saves before running)
	- Moved Font, Lock and Search buttons to pull-out panel
	- Reduced minimum width of window

	To summon: /tinypad or /pad or set a key binding
	To resize: drag the resize grip in the lower right corner

	v1.4, 8/22/05, bug fix: run script saves page to run, changed: moved buttons to search panel, reduced minimum width
	v1.3, 8/5/06, added undo, widened page number
	v1.2, 6/23/06, added search, lock, fonts, /pad <page>, /pade run <page>
	v1.1, 12/18/05, remove autofocus, added confirmation on delete
	v1.0, 12/16/05, initial release
]]

-- SavedVariables
TinyPadPages = { "" } -- numerically-indexed table of pages
TinyPadSettings = {} -- Lock, Font

TinyPad = {

	-- tooltip info for controls
	controls = {
		{"TinyPadNew","New Page","Create a new page at end of book.  Hold Shift to insert after current page."},
		{"TinyPadDelete","Delete Page","Permanently remove this page.  Hold Shift to delete without confirmation."},
		{"TinyPadRun","Run Page","Run this page as a script."},
		{"TinyPadStart","First Page","Go to first page"},
		{"TinyPadLeft","Flip Back","Go back one page."},
		{"TinyPadRight","Flip Forward","Go forward one page."},
		{"TinyPadEnd","Last Page","Go to the last page."},
		{"TinyPadClose","Close TinyPad","Close the book."},
		{"TinyPadLock","Lock","Lock or Unlock window."},
		{"TinyPadFont","Font","Cycle through different fonts."},
		{"TinyPadSearch","Options","Search pages for text, change fonts or lock window."},
		{"TinyPadSearchNext","Find Next","Find next page with this text"},
		{"TinyPadSearchEditBox","Search Criterea","Enter the text to search for here."},
		{"TinyPadUndo","Undo","Revert page to last saved text."},
	},

	-- list of fonts to cycle through
	fonts = {
		{"Fonts\\FRIZQT__.TTF",10},
		{"Fonts\\FRIZQT__.TTF",12}, -- default
		{"Fonts\\FRIZQT__.TTF",16},
		{"Fonts\\ARIALN.TTF",12},
		{"Fonts\\ARIALN.TTF",16},
		{"Fonts\\ARIALN.TTF",20},
		{"Fonts\\MORPHEUS.ttf",16,"OUTLINE"},
		{"Fonts\\MORPHEUS.ttf",24,"OUTLINE"}
		-- add fonts here
	},

	current_page = 1, -- page currently viewed
	first_use = 1 -- whether this was used this session
}

BINDING_HEADER_TINYPAD = "TinyPad"
StaticPopupDialogs["TINYPADCONFIRM"] = { text = "Delete this page?", button1 = "Yes", button2 = "No", timeout = 0, whileDead = 1, OnAccept = function() TinyPad.DeletePage() end}

function TinyPad.OnLoad()
	this:SetMinResize(236,96)
	table.insert(UISpecialFrames,"TinyPadFrame")
	table.insert(UISpecialFrames,"TinyPadSearchFrame")

	SlashCmdList["TINYPADSLASH"] = TinyPad.SlashHandler
	SLASH_TINYPADSLASH1 = "/pad"
	SLASH_TINYPADSLASH2 = "/tinypad"
	this:RegisterEvent("PLAYER_LOGIN")
end

function TinyPad.OnEvent()
	TinyPadSettings.Font = TinyPadSettings.Font or 2
	TinyPad.UpdateFont()
	TinyPad.UpdateLock()
end

-- /pad # will go to a page, /pad run # will run a page, /pad alone toggles window
function TinyPad.SlashHandler(msg)
	local _,_,page = string.find(msg or "","(%d+)")
	if page then
		page = tonumber(page)
		if TinyPadPages[page] then
			if string.find(string.lower(msg),"run") then
				RunScript(TinyPadPages[page])
			else
				TinyPad.current_page = page
				TinyPad.ShowPage()
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("TinyPad: Page "..page.." doesn't exist.")
		end
	else
		TinyPad.Toggle()
	end
end

-- for use in macros, TinyPad.Run(#) to run a page
function TinyPad.Run(page)
	if page and tonumber(page) then
		TinyPad.SlashHandler("run "..page)
	end
end

-- toggles window on/off screen
function TinyPad.Toggle(msg)
	if TinyPadFrame:IsVisible() then
		TinyPadFrame:Hide()
	else
		TinyPadFrame:Show()
	end
end

-- window movement
function TinyPad.StartMoving()
	if arg1=="LeftButton" and not TinyPadSettings.Lock then
		TinyPadFrame:StartMoving()
	end
end

function TinyPad.StopMoving()
	if arg1=="LeftButton" then
		TinyPadFrame:StopMovingOrSizing()
	end
end

function TinyPad.Tooltip()
	local which = this:GetName()
	for i in TinyPad.controls do
		if TinyPad.controls[i][1]==which then
			GameTooltip_SetDefaultAnchor(GameTooltip,UIParent)
			GameTooltip:AddLine(TinyPad.controls[i][2])
			GameTooltip:AddLine(TinyPad.controls[i][3],.85,.85,.85,1)
			GameTooltip:Show()
			break
		end
	end
end

-- Titlebar button clicks
function TinyPad.OnClick()

	local which = this:GetName()
	local new_page
	local book = TinyPadPages

	if which=="TinyPadUndo" then
		TinyPadEditBox:SetText(TinyPadPages[TinyPad.current_page])
	end

	if which=="TinyPadNew" then
		if not IsShiftKeyDown() then
			table.insert(book,"")
			new_page = table.getn(book)
		else
			table.insert(book,TinyPad.current_page+1,"")
			new_page = TinyPad.current_page + 1
		end
	elseif which=="TinyPadDelete" then
		if not IsShiftKeyDown() and string.len(book[TinyPad.current_page])>0 then
			StaticPopup_Show("TINYPADCONFIRM")
		else
			TinyPad.DeletePage() -- delete empty pages without confirmation
		end
	elseif which=="TinyPadRun" then
		TinyPadPages[TinyPad.current_page] = TinyPadEditBox:GetText()
		TinyPadUndo:Disable()
		RunScript(book[TinyPad.current_page])
	elseif which=="TinyPadStart" then
		new_page = 1
	elseif which=="TinyPadLeft" then
		new_page = math.max(TinyPad.current_page-1,1)
	elseif which=="TinyPadRight" then
		new_page = math.min(TinyPad.current_page+1,table.getn(book))
	elseif which=="TinyPadEnd" then
		new_page = table.getn(book)
	elseif which=="TinyPadClose" then
		TinyPadFrame:Hide()
	elseif which=="TinyPadLock" then
		TinyPadSettings.Lock = not TinyPadSettings.Lock
		TinyPad.UpdateLock()
	elseif which=="TinyPadFont" then
		TinyPadSettings.Font = TinyPadSettings.Font+1
		TinyPad.UpdateFont()
	elseif which=="TinyPadSearch" then
		if TinyPadSearchFrame:IsVisible() then
			TinyPadSearchFrame:Hide()
		else
			TinyPadSearchFrame:Show()
		end
	elseif which=="TinyPadSearchNext" then
		TinyPad.DoSearch()
	end

	if new_page then
		TinyPadPages[TinyPad.current_page] = TinyPadEditBox:GetText()
		TinyPad.current_page = new_page
		TinyPad.ShowPage()
	end
end

-- removes the current page
function TinyPad.DeletePage()

	local book = TinyPadPages

	table.remove(book,TinyPad.current_page)
	if table.getn(book)==0 then
		table.insert(book,"")
	end
	TinyPad.current_page = math.min(TinyPad.current_page,table.getn(book))
	TinyPad.ShowPage()
end

-- disables/enables page movement buttons depending on page
function TinyPad.ValidateButtons()

	-- nil for disabled, 1 for enabled
	local function set_state(button,enabled)
		if enabled then
			button:SetAlpha(1)
			button:Enable()
		else
			button:SetAlpha(.5)
			button:Disable()
		end
	end

	set_state(TinyPadStart,1)
	set_state(TinyPadLeft,1)
	set_state(TinyPadRight,1)
	set_state(TinyPadEnd,1)

	if TinyPad.current_page==1 then
		set_state(TinyPadStart)
		set_state(TinyPadLeft)
	end
	if TinyPad.current_page==table.getn(TinyPadPages) then
		set_state(TinyPadRight)
		set_state(TinyPadEnd)
	end
end

-- shows/updates the current page
function TinyPad.ShowPage()
	if not TinyPadFrame:IsVisible() then
		TinyPadFrame:Show()
	end
	if TinyPadPages[TinyPad.current_page] then
		TinyPadPageNum:SetText(TinyPad.current_page)
		TinyPadEditBox:SetText(TinyPadPages[TinyPad.current_page])
		TinyPad.ValidateButtons()
	end
end

-- refreshes window when shown
function TinyPad.OnShow()
	if TinyPad.first_use then
		-- only when the pad is first shown show last page
		TinyPad.current_page = table.getn(TinyPadPages)
		TinyPad.first_use = nil
	end
	TinyPad.ShowPage()
	TinyPadEditBox:SetWidth(TinyPadFrame:GetWidth()-50)
end

-- saves page when window hides
function TinyPad.OnHide()
	TinyPadPages[TinyPad.current_page] = TinyPadEditBox:GetText()
	TinyPadUndo:Disable()
	TinyPadEditBox:ClearFocus()
end

-- changes border and resize grip depending on lock status
function TinyPad.UpdateLock()
	if TinyPadSettings.Lock then
		TinyPadFrame:SetBackdropBorderColor(0,0,0,1)
		TinyPadSearchFrame:SetBackdropBorderColor(0,0,0,1)
		TinyPadResizeGrip:Hide()
	else
		TinyPadFrame:SetBackdropBorderColor(1,1,1,1)
		TinyPadSearchFrame:SetBackdropBorderColor(1,1,1,1)
		TinyPadResizeGrip:Show()
	end
	TinyPad.MakeESCable("TinyPadFrame",TinyPadSettings.Lock)
end

-- updates EditBox font to current settings
function TinyPad.UpdateFont()
	if TinyPadSettings.Font > table.getn(TinyPad.fonts) then
		TinyPadSettings.Font = 1
	end
	local font = TinyPadSettings.Font
	TinyPadEditBox:SetFont(TinyPad.fonts[font][1],TinyPad.fonts[font][2],TinyPad.fonts[font][3])
end

-- adds frame to UISpecialFrames, removes frame if disable true
function TinyPad.MakeESCable(frame,disable)
	local idx
	for i=1,table.getn(UISpecialFrames) do
		if UISpecialFrames[i]==frame then
			idx = i
			break
		end
	end
	if idx and disable then
		table.remove(UISpecialFrames,idx)
	elseif not idx and not disable then
		table.insert(UISpecialFrames,1,frame)
	end
end
	
-- when search summoned, remove ESCability of main window (only search cleared with ESC)
function TinyPad.SearchOnShow()
	TinyPad.MakeESCable("TinyPadFrame","disable")
end

-- when search dismissed, restore ESCability to main window and reset search elements
function TinyPad.SearchOnHide()
	if not TinyPadSettings.Lock then
		TinyPad.MakeESCable("TinyPadFrame")
	end
	TinyPadSearchResults:SetText("Search:")
	TinyPadSearchEditBox:ClearFocus()
end

-- does a count
function TinyPad.SearchEditBoxOnChange()
	local search = string.lower(TinyPadSearchEditBox:GetText() or "")
	if string.len(search)<1 then
		TinyPadSearchResults:SetText("Search:")
	else
		local count = 0
		for i=1,table.getn(TinyPadPages) do
			count = count + (string.find(string.lower(TinyPadPages[i]),search,1,1) and 1 or 0)
		end
		TinyPadSearchResults:SetText(count.." found")
	end
end

-- performs a search for the text in the search box
function TinyPad.DoSearch()
	local search = string.lower(TinyPadSearchEditBox:GetText() or "")
	if string.len(search)<1 then
		return
	end
	local page = TinyPad.current_page
	for i=1,table.getn(TinyPadPages) do
		page = page + 1
		if page > table.getn(TinyPadPages) then
			page = 1
		end
		if string.find(string.lower(TinyPadPages[page]),search,1,1) then
			TinyPadPages[TinyPad.current_page] = TinyPadEditBox:GetText()
			TinyPad.current_page = page
			TinyPad.ShowPage()
			return
		end
	end
end

function TinyPad.OnTextChanged()
	local scrollBar = getglobal(this:GetParent():GetName().."ScrollBar")
	this:GetParent():UpdateScrollChildRect()
	local min, max = scrollBar:GetMinMaxValues()
	if ( max > 0 and (this.max ~= max) ) then
		this.max = max
		scrollBar:SetValue(max)
	end
	if this:GetText()~=TinyPadPages[TinyPad.current_page] then
		TinyPadUndo:Enable()
	else
		TinyPadUndo:Disable()
	end
end
