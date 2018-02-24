--[[

   Bank containers handling. 
   
   All recipes stored in bank are recorded in 
   BookOfCrafts_Data.Characters[i].InBank

   Please read "ReadMe.txt" and "ChangeNotes.txt" for more information

--]]


-- List of global variables
--
--    BookOfCrafts_Data : database
--    BC_char_index     : current character index in database
--



-------------------------------------------------------------------------------
-- PURPOSE
--    Given a container number, content is analyzed for recipes presence.
--
-- PARAMETERS
--    container : Container ID (BANK_CONTAINER, 1, 2, ...)
-------------------------------------------------------------------------------

function BoC_InBank_AnalyzeContainer( container )

	local slot

	for slot = 1, GetContainerNumSlots( container ) do
		local item_link = GetContainerItemLink( container, slot )
		if( item_link ) then
			local item_name = BoC_ExtractNameFromLink( item_link )
			if( BoC_GetCraftedObjectFromHeader( item_name ) ) then
				local in_bank = BookOfCrafts_Data.Characters[BC_char_index].InBank[item_name]
				if( in_bank == nil ) then
					BookOfCrafts_Data.Characters[BC_char_index].InBank[item_name] = 1
				else
					BookOfCrafts_Data.Characters[BC_char_index].InBank[item_name] = in_bank + 1
				end
				BoC_ChatMsg( "InBank: ".."("..container..") "..item_name, true )
			end
		end
	end
end


function BoC_ScanBlizzardBank()

	-- Clear character "InBank" list
	BookOfCrafts_Data.Characters[BC_char_index].InBank = {}

	-- Search for recipes in bank main window
	BoC_InBank_AnalyzeContainer( BANK_CONTAINER )

	-- Search for recipes in bank bags
	for bag = 5, 10 do
		BoC_InBank_AnalyzeContainer( bag )
	end
end
