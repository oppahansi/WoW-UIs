-- =============================================================================
--  CLEARFONT BY KIRKBURN  v11100-2
--  Official website:  http://www.clearfont.co.uk/
-- =============================================================================
--  CLEARFONTADDONS.LUA - ADDON-SPECIFIC FONT OVERRIDES
-- =============================================================================
--  This is *not* a replacement for Step Two, but is merely an aid for it
--  If you do not require or wish to remove these overrides open !ClearFont.toc
--  in notepad and delete the line "ClearFontAddons.lua"
-- =============================================================================




-- =============================================================================
--  A. CLEARFONT FRAME & FONT LOCALS FOR BREVITY LATER
--  You can add your own font local, following the example (the last line)
-- =============================================================================

ClearFontAddons = CreateFrame("Frame", "ClearFontAddons");

-- Change 'Fonts' to 'Fonts2' if you wish to use the non-fixed width/height versions
local CLEAR_FONT_BASE = "Interface\\AddOns\\!ClearFont\\Fonts\\";

local CLEAR_FONT = CLEAR_FONT_BASE .. "ClearFont.ttf";
local CLEAR_FONT_BOLD = CLEAR_FONT_BASE .. "ClearFontBold.ttf";
local CLEAR_FONT_ITALIC = CLEAR_FONT_BASE .. "ClearFontItalic.ttf";
local CLEAR_FONT_BOLDITALIC = CLEAR_FONT_BASE .. "ClearFontBoldItalic.ttf";
local CLEAR_FONT_NUMBER = CLEAR_FONT_BASE .. "ClearFontNumber.ttf";

-- Add your own fonts
local YOUR_FONT_STYLE = CLEAR_FONT_BASE .. "YourFontName.ttf";

-- Font scale - e.g. if you want all fonts at 80% scale, change '1' to '0.8'
local CF_SCALE = 1




-- Check existence of overridable fonts & change them
-----------------------------------------------------

local function CanSetFont(object) 
   return (type(object)=="table" 
	   and object.SetFont and object.IsObjectType 
	      and not object:IsObjectType("SimpleHTML")); 
end




-- =============================================================================
--  B. ADDON-SPECIFIC OVERRIDES SECTION, LATEST VERSION TESTED LISTED
-- =============================================================================
--  BMRecLevel, DamageMeters, eCastingBar, EngInventory
--  SuperInspect, TipBuddy, TitanHonorPlus
-- =============================================================================
--  These overrides may or may not work, I cannot guarantee their success
--  If you wish to add your own, check the addon .xml files for 'fontstring's
--  If the name is unique you can try adding info here
--  Please don't ask me for help on this though, you need to find out yourself
-- =============================================================================
--  Addon overrides must be within an if statement, as shown below
--  Delete sections as required, and see ClearFont.lua for other info
-- =============================================================================


function ClearFontAddons:ApplyAddOnFonts()


-- BMRecLevel 2.10
------------------

   if (CanSetFont(BMRecLevelWorldMapText)) then 			BMRecLevelWorldMapText:SetFont(CLEAR_FONT_BOLD, 13 * CF_SCALE, "OUTLINE"); end
   if (CanSetFont(BMRecLevelText)) then 					BMRecLevelText:SetFont(CLEAR_FONT, 13 * CF_SCALE); end
   if (CanSetFont(BhaldieRecLevelFont)) then 				BhaldieRecLevelFont:SetFont(CLEAR_FONT, 13 * CF_SCALE); end


-- DamageMeters 4.2.0
---------------------

   if (CanSetFont(DamageMeters_TitleButtonText)) then 		DamageMeters_TitleButtonText:SetFont(CLEAR_FONT_BOLD, 12 * CF_SCALE); end
   if (CanSetFont(DamageMeters_TotalButtonText)) then 		DamageMeters_TotalButtonText:SetFont(CLEAR_FONT_BOLD, 12 * CF_SCALE); end
   if (CanSetFont(DMReportTypeButtonText)) then 			DMReportTypeButtonText:SetFont(CLEAR_FONT_BOLD, 12 * CF_SCALE); end


-- eCastingBar
--------------

   if (CanSetFont(eCastingBarFont)) then 					eCastingBarFont:SetFont(CLEAR_FONT_BOLD, 12 * CF_SCALE); end
   if (CanSetFont(eCastingBarText)) then 					eCastingBarText:SetFont(CLEAR_FONT_BOLD, 12 * CF_SCALE); end
   if (CanSetFont(eCastingBar_Time)) then 				eCastingBar_Time:SetFont(CLEAR_FONT_NUMBER, 12 * CF_SCALE); end
   if (CanSetFont(eCastingBar_Delay)) then 				eCastingBar_Delay:SetFont(CLEAR_FONT_NUMBER, 12 * CF_SCALE); end
   if (CanSetFont(eCastingBarDragButtonText)) then 			eCastingBarDragButtonText:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(eCastingBarMirrorDragButtonText)) then 		eCastingBarMirrorDragButtonText:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(eCastingBarSpellLengthText)) then 			eCastingBarSpellLengthText:SetFont(CLEAR_FONT_BOLD, 12 * CF_SCALE); end


-- EngInventory 23.03.06
------------------------

   if (CanSetFont(EngInventory_BigFont)) then 				EngInventory_BigFont:SetFont(CLEAR_FONT, 16 * CF_SCALE); end 


-- SuperInspect 1.18
--------------------

   if (CanSetFont(SuperInspect_NameText)) then 				SuperInspect_NameText:SetFont(CLEAR_FONT, 13 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_TitleText)) then 			SuperInspect_TitleText:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_BonusesText)) then 			SuperInspect_BonusesText:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_BonusesTextR)) then 			SuperInspect_BonusesTextR:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(SIDurabilityNumberFont)) then 			SIDurabilityNumberFont:SetFont(CLEAR_FONT, 15 * CF_SCALE, "OUTLINE"); end 
   if (CanSetFont(SINumberFontNormal)) then 				SINumberFontNormal:SetFont(CLEAR_FONT, 14 * CF_SCALE, "THICKOUTLINE"); end 
   if (CanSetFont(SuperInspect_ButtonText)) then 			SuperInspect_ButtonText:SetFont(CLEAR_FONT, 12 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_HonorText)) then 			SuperInspect_HonorText:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_HonorTextLarge)) then 			SuperInspect_HonorTextLarge:SetFont(CLEAR_FONT, 13 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_HonorTextSmall)) then 			SuperInspect_HonorTextSmall:SetFont(CLEAR_FONT_BOLD, 10 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_HonorTextHighlightSmall)) then	SuperInspect_HonorTextHighlightSmall:SetFont(CLEAR_FONT_BOLD, 10 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_ButtonTextHighlight)) then		SuperInspect_ButtonTextHighlight:SetFont(CLEAR_FONT, 12 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_ButtonTextDisable)) then		SuperInspect_ButtonTextDisable:SetFont(CLEAR_FONT, 12 * CF_SCALE); end 

   if (CanSetFont(SuperInspect_HonorFrameCurrentPVPTitle)) then 	SuperInspect_HonorFrameCurrentPVPTitle:SetFont(CLEAR_FONT_BOLD, 11 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_HonorFrameCurrentPVPRank)) then 	SuperInspect_HonorFrameCurrentPVPRank:SetFont(CLEAR_FONT, 10 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_HonorFrameHonorPercent)) then 	SuperInspect_HonorFrameHonorPercent:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_HonorFrameCurrentSessionTitle)) then	SuperInspect_HonorFrameCurrentSessionTitle:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_HonorFrameYesterdayTitle)) then 	SuperInspect_HonorFrameYesterdayTitle :SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_HonorFrameThisWeekTitle)) then 	SuperInspect_HonorFrameThisWeekTitle:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_HonorFrameLastWeekTitle)) then 	SuperInspect_HonorFrameLastWeekTitle:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_HonorFrameLifeTimeTitle)) then 	SuperInspect_HonorFrameLifeTimeTitle:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 

   if (CanSetFont(SuperInspect_ItemBonusesTitle)) then 		SuperInspect_ItemBonusesTitle:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_ItemBonusesText)) then 		SuperInspect_ItemBonusesText:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_ItemBonusesTextR)) then 		SuperInspect_ItemBonusesTextR:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 

   if (CanSetFont(SuperInspect_MagicResText1)) then 			SuperInspect_MagicResText1:SetFont(CLEAR_FONT_NUMBER, 14 * CF_SCALE, "OUTLINE"); end 
   if (CanSetFont(SuperInspect_MagicResText2)) then 			SuperInspect_MagicResText2:SetFont(CLEAR_FONT_NUMBER, 14 * CF_SCALE, "OUTLINE"); end 
   if (CanSetFont(SuperInspect_MagicResText3)) then 			SuperInspect_MagicResText3:SetFont(CLEAR_FONT_NUMBER, 14 * CF_SCALE, "OUTLINE"); end 
   if (CanSetFont(SuperInspect_MagicResText4)) then 			SuperInspect_MagicResText4:SetFont(CLEAR_FONT_NUMBER, 14 * CF_SCALE, "OUTLINE"); end 
   if (CanSetFont(SuperInspect_MagicResText5)) then 			SuperInspect_MagicResText5:SetFont(CLEAR_FONT_NUMBER, 14 * CF_SCALE, "OUTLINE"); end 

   if (CanSetFont(SuperInspect_SnTBonusesTitle)) then 		SuperInspect_SnTBonusesTitle:SetFont(CLEAR_FONT, 12 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_SnTBonusesText)) then 			SuperInspect_SnTBonusesText:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 

   if (CanSetFont(SuperInspect_MobInfoTitle)) then 			SuperInspect_MobInfoTitle:SetFont(CLEAR_FONT, 12 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_MobInfoText)) then 			SuperInspect_MobInfoText:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_MobInfoTextR)) then 			SuperInspect_MobInfoTextR:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 

   if (CanSetFont(SuperInspect_ItemBonusesNameCompare)) then 	SuperInspect_ItemBonusesNameCompare:SetFont(CLEAR_FONT, 12 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_ItemBonusesGuildCompare)) then 	SuperInspect_ItemBonusesGuildCompare:SetFont(CLEAR_FONT, 10 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_ItemBonusesTitleCompare)) then 	SuperInspect_ItemBonusesTitleCompare:SetFont(CLEAR_FONT, 12 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_ItemBonusesTextCompare)) then 	SuperInspect_ItemBonusesTextCompare:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(SuperInspect_ItemBonusesTextRCompare)) then 	SuperInspect_ItemBonusesTextRCompare:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 

   if (CanSetFont(SuperInspect_MagicResTextCompare1)) then 		SuperInspect_MagicResTextCompare1:SetFont(CLEAR_FONT_NUMBER, 14 * CF_SCALE, "OUTLINE"); end 
   if (CanSetFont(SuperInspect_MagicResTextCompare2)) then 		SuperInspect_MagicResTextCompare2:SetFont(CLEAR_FONT_NUMBER, 14 * CF_SCALE, "OUTLINE"); end 
   if (CanSetFont(SuperInspect_MagicResTextCompare3)) then 		SuperInspect_MagicResTextCompare3:SetFont(CLEAR_FONT_NUMBER, 14 * CF_SCALE, "OUTLINE"); end 
   if (CanSetFont(SuperInspect_MagicResTextCompare4)) then 		SuperInspect_MagicResTextCompare4:SetFont(CLEAR_FONT_NUMBER, 14 * CF_SCALE, "OUTLINE"); end 
   if (CanSetFont(SuperInspect_MagicResTextCompare5)) then 		SuperInspect_MagicResTextCompare5:SetFont(CLEAR_FONT_NUMBER, 14 * CF_SCALE, "OUTLINE"); end 

   if (CanSetFont(SI_DummyText)) then 					SI_DummyText:SetFont(CLEAR_FONT, 13 * CF_SCALE); end 


-- TipBuddy 2.1
---------------

   if (CanSetFont(TBGameFontNormal)) then 				TBGameFontNormal:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(TBGameFontHighlight)) then 				TBGameFontHighlight:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(TBGameFontDisable)) then 				TBGameFontDisable:SetFont(CLEAR_FONT, 11 * CF_SCALE); end 
   if (CanSetFont(TBGameFontNormalSmall)) then 				TBGameFontNormalSmall:SetFont(CLEAR_FONT, 9 * CF_SCALE); end 
   if (CanSetFont(TBGameFontHighlightSmall)) then 			TBGameFontHighlightSmall:SetFont(CLEAR_FONT, 9 * CF_SCALE); end
   if (CanSetFont(ToolTipBuddyText)) then 				ToolTipBuddyText:SetFont(CLEAR_FONT, 12 * CF_SCALE); end
   if (CanSetFont(ToolTipBuddyTextOutline)) then 			ToolTipBuddyTextOutline:SetFont(CLEAR_FONT, 16 * CF_SCALE, "OUTLINE"); end 
   if (CanSetFont(TB_HealthText)) then 					TB_HealthText:SetFont(CLEAR_FONT_NUMBER, 15 * CF_SCALE, "OUTLINE"); end 
   if (CanSetFont(TB_ManaText)) then 					TB_ManaText:SetFont(CLEAR_FONT_NUMBER, 13 * CF_SCALE, "OUTLINE"); end 
   if (CanSetFont(TB_TTGameFontNormalSmall)) then 			TB_TTGameFontNormalSmall:SetFont(CLEAR_FONT, 10 * CF_SCALE); end
   if (CanSetFont(TB_TTGameFontNormalSmallHighlight)) then		TB_TTGameFontNormalSmall:SetFont(CLEAR_FONT, 10 * CF_SCALE); end 


-- TitanHonorPlus
-----------------

   if (CanSetFont(TitanHonorPlus_TipBuddy_TargetName_Text)) then 	TitanHonorPlus_TipBuddy_TargetName_Text:SetFont(CLEAR_FONT, 12 * CF_SCALE); end 


end




-- =============================================================================
--  C. FUNCTION TO RELOAD EVERY TIME AN ADDON LOADS
--  They do like to mess up my addon!
-- =============================================================================

ClearFontAddons:SetScript("OnEvent",
		    function() 
		       if (event == "ADDON_LOADED") then
			  ClearFontAddons:ApplyAddOnFonts()
		       end
		    end);
ClearFontAddons:RegisterEvent("ADDON_LOADED");




-- =============================================================================
--  D. APPLY ALL THE ABOVE ON FIRST RUN
--  To start the ball rolling
-- =============================================================================

ClearFontAddons:ApplyAddOnFonts()
