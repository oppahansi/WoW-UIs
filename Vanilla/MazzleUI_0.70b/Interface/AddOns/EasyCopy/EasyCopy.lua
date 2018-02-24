function EasyCopy_OnLoad()

	EasyCopy_SetItemRef_Original = SetItemRef;
	SetItemRef = EasyCopy_SetItemRef;
    local theChatFrame
    for i=1,5 do
        theChatFrame =  getglobal("ChatFrame"..i)
		theChatFrame.Original_AddMessage = theChatFrame.AddMessage;
		theChatFrame.AddMessage = EasyCopy_AddMessage;
    end
end

function EasyCopy_AddMessage(this, msg, r, g, b, id)
	local newmsg = "|Hezc:"..UnlinkMessage(msg).."|h|CFFD0D9D7@|h "..msg;
	this:Original_AddMessage(newmsg, r, g, b, id);
end

function UnlinkMessage(linkedmessage)
	local message = linkedmessage;
	local part1 = "";
	local part2 = "";
	local part3 = "";
	local pos   = 0;
	local lenbef= strlen(message);
	if (strfind(message,"|c")~=nil) then
		local done = false;
		message = gsub(message,"|r","");
		repeat
			part1 = message;
			pos   = strfind(message,"|c");
			part2 = strsub (part1,pos+10);
			part1 = strsub (part1,1,pos-1);
			message=part1..part2;
			if (strfind(message,"|c") == nil) then
				done = true;
			end
		until (done == true);
	end
	if (strfind(message,"|C")~=nil) then
		local done = false;
		message = gsub(message,"|r","");
		repeat
			part1 = message;
			pos   = strfind(message,"|C");
			part2 = strsub (part1,pos+10);
			part1 = strsub (part1,1,pos-1);
			message=part1..part2;
			if (strfind(message,"|C") == nil) then
				done = true;
			end
		until (done == true);
	end
	if (strfind(message,"|H")~=nil) then
		local done = false;
		repeat
			part1 = message;
			pos   = strfind(part1,"|H");
			part2 = strsub (part1,pos+2);
			part1 = strsub (part1,1,pos-1);
			pos   = strfind(part2,"|h");
			part2 = strsub (part2,pos+2);
			pos   = strfind(part2,"|h");
			part3 = strsub (part2,pos+2);
			part2 = strsub (part2,1,pos-1);
			message=part1..part2..part3;
			if (strfind(message,"|H") == nil) then
				done = true;
			end
		until (done == true);
	end
	message=gsub(message,"/","/1");
	message=gsub(message,"|","/2");
	return message;
end

function EasyCopy_SetItemRef(link, button)
	if ( strsub(link, 1, 3) == "ezc" ) then
		EasyCopy_core:Show();
		EasyCopyText:SetText(gsub(gsub(strsub(link,5),"/2","|"),"/1","/"));
		EasyCopyText:HighlightText();
		EasyCopyText:SetFont(DEFAULT_CHAT_FRAME:GetFont());
		return;
	end
	EasyCopy_SetItemRef_Original(link, button);
end