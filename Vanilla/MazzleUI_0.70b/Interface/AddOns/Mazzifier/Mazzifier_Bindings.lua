-- Copyright © 2006 Mazin Assanie
-- All Rights Reserved.
-- 
-- Permission to use, copy, modify, and distribute this software in any way
-- is not granted without expressed written agreement.  In the case that it
-- is granted, the above copyright notice and this paragraph must appear in
-- all copies, modifications, and distributions.
--
-- To contact the author of this work, use mazzlefizz@gmail.com 
-- For more information on copyright, visit http://copyright.gov/ or http://whatiscopyright.org/
--

function Setup_Bindings()

    MazzleUI_CreatePath( "myBindingsDB.profiles."..Mazzifier_PlayerName.."\32of\32"..Mazzifier_ServerName..".bindings.dummy")
    
    if ((not Mazzifier_LastInstalledVersion) or (Mazzifier_LastInstalledVersion == Mazzifier_Version) or (Mazzifier_LastInstalledVersion < 0.40)) then
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["Toggle Buff/Debuff view"] = {["bind1"] = "ALT-B",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["PSPOT_CYCLE_MODE"] = {["bind1"] = "ALT-P",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["PSPOT_CYCLE_HLIGHT"] = {["bind1"] = "CTRL-P",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["CHARACTERSVIEWER_BANKTOGGLE"] = {["bind1"] = "CTRL-B",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["AUTOBAR_BUTTON2"] = {["bind1"] = "SHIFT-]",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["AUTOBAR_BUTTON3"] = {["bind1"] = "SHIFT-[",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["AUTOBAR_BUTTON4"] = {["bind1"] = "[",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["AUTOBAR_BUTTON5"] = {["bind1"] = "]",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["ALLNAMEPLATES"] = {["bind1"] = "ALT-CTRL-SHIFT-V",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["NAMEPLATES"] = {["bind1"] = "CTRL-SHIFT-V",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["FRIENDNAMEPLATES"] = {["bind1"] = "ALT-CTRL-V",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["ASSISTTARGET"] = {["bind1"] = "SHIFT-F",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLEALPHAMAP"] = {["bind1"] = "M",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLEKEYRING"] = {["bind1"] = "CTRL-K",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["CAMERAZOOMIN"] = {["bind1"] = "MOUSEWHEELUP",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["CAMERAZOOMOUT"] = {["bind1"] = "MOUSEWHEELDOWN",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["CHARACTERSVIEWER_BANKTOGGLE"] = {["bind1"] = "CTRL-B",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["CHATBOTTOM"] = {["bind1"] = "SHIFT-PAGEDOWN",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["CHATPAGEDOWN"] = {["bind1"] = "PAGEDOWN",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["CHATPAGEUP"] = {["bind1"] = "PAGEUP",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["COMBATLOGBOTTOM"] = {["bind1"] = "CTRL-SHIFT-PAGEDOWN",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["COMBATLOGPAGEDOWN"] = {["bind1"] = "CTRL-PAGEDOWN",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["COMBATLOGPAGEUP"] = {["bind1"] = "CTRL-PAGEUP",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["CUSTOM4MESSAGE"] = {["bind1"] = "ALT-CTRL-SHIFT-F",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["DMSB_TOGGLE"] = {["bind1"] = "P",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["FOLLOWTARGET"] = {["bind1"] = "'",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["JUMP"] = {["bind2"] = "NUMPAD0", ["bind1"] = "SPACE",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["KC_Items_LinkView"] = {["bind1"] = "Y",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZ3DSAVEMOB"] = {["bind1"] = "F8",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUICONTEXT"] = {["bind1"] = "SHIFT-BUTTON4", ["bind2"] = "SHIFT-BUTTON3",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIDEBUG"] = {["bind1"] = "CTRL-.",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUINEXTVIEW"] = {["bind1"] = "CTRL-[",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIPREVVIEW"] = {["bind1"] = "CTRL-]",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIVIEW1"] = {["bind1"] = "CTRL-F1",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIVIEW2"] = {["bind1"] = "CTRL-F2",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIVIEW3"] = {["bind1"] = "CTRL-F3",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MINIMAPZOOMIN"] = {["bind1"] = "NUMPADPLUS",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MINIMAPZOOMOUT"] = {["bind1"] = "NUMPADMINUS",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MONKEYBUDDY_OPEN"] = {["bind1"] = "CTRL-L",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MONKEYQUEST_CLOSE"] = {["bind1"] = "L",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MOVEBACKWARD"] = {["bind2"] = "DOWN", ["bind1"] = "S",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MOVEFORWARD"] = {["bind2"] = "UP", ["bind1"] = "W",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["NEXTVIEW"] = {["bind1"] = "END",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TinyPad Toggle"] = {["bind1"] = "J",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["OPENALLBAGS"] = {["bind1"] = "B",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["OPENBAGS1"] = {["bind1"] = "B",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["OPENCHAT"] = {["bind1"] = "ENTER",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["OPENCHATSLASH"] = {["bind1"] = "/",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["PETATTACK"] = {["bind1"] = "`",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["PHOENIXSHOW"] = {["bind1"] = "SHIFT-P",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["PITCHDOWN"] = {["bind1"] = "DELETE",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["PITCHUP"] = {["bind1"] = "INSERT",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["PREVVIEW"] = {["bind1"] = "HOME",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["REPLY"] = {["bind1"] = "ALT-R",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["SAASSIST"] = {["bind1"] = "F",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["SASET"] = {["bind1"] = "CTRL-F",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["SITORSTAND"] = {["bind1"] = "CTRL-X",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["STRAFELEFT"] = {["bind1"] = "Q",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["STRAFERIGHT"] = {["bind1"] = "E",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["SUPERINSPECT"] = {["bind1"] = "I",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETLASTHOSTILE"] = {["bind1"] = "CTRL-R",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETNEARESTENEMY"] = {["bind1"] = "TAB",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETNEARESTFRIEND"] = {["bind1"] = "CTRL-TAB",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETPARTYMEMBER1"] = {["bind1"] = "F2",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETPARTYMEMBER2"] = {["bind1"] = "F3",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETPARTYMEMBER3"] = {["bind1"] = "F4",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETPARTYPET1"] = {["bind1"] = "SHIFT-F2",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETPARTYPET2"] = {["bind1"] = "SHIFT-F3",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETPARTYPET3"] = {["bind1"] = "SHIFT-F4",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETPARTYPET4"] = {["bind1"] = "SHIFT-F5",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETPET"] = {["bind1"] = "SHIFT-F1",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETPREVIOUSENEMY"] = {["bind1"] = "SHIFT-TAB",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETPREVIOUSFRIEND"] = {["bind1"] = "CTRL-SHIFT-TAB",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TARGETSELF"] = {["bind1"] = "F1",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["Toggle ItemRack"] = {["bind1"] = "SHIFT-I",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["Toggle View"] = {["bind1"] = "CTRL-V",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLEAUTORUN"] = {["bind2"] = "BUTTON4", ["bind1"] = "NUMLOCK",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLEBATTLEFIELDMINIMAP"] = {["bind1"] = "SHIFT-M",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLECHARACTER0"] = {["bind2"] = "C",["bind1"] = "CTRL-C",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLECHARACTER1"] = {["bind1"] = "K",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLECHARACTER3"] = {["bind1"] = ";",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLEGAMEMENU"] = {["bind1"] = "ESCAPE",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLEGUILDTAB"] = {["bind1"] = "SHIFT-O",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLEMUSIC"] = {["bind1"] = "CTRL-M",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLERAIDTAB"] = {["bind1"] = "CTRL-O",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLERUN"] = {["bind1"] = "\\",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLESHEATH"] = {["bind1"] = "CTRL-Z",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLESOCIAL"] = {["bind1"] = "O",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLESOUND"] = {["bind1"] = "CTRL-S",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLETALENTS"] = {["bind1"] = "N",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLEUI"] = {["bind1"] = "ALT-Z",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLEWHOTAB"] = {["bind1"] = "CTRL-SHIFT-O",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TOGGLEWORLDSTATESCORES"] = {["bind1"] = "SHIFT-SPACE",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TURNLEFT"] = {["bind2"] = "LEFT", ["bind1"] = "A",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["TURNRIGHT"] = {["bind2"] = "RIGHT", ["bind1"] = "D",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["Use Bottom Trinket"] = {["bind1"] = "SHIFT-C",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["Use Top Trinket"] = {["bind1"] = "C",}
    end
    if ((Mazzifier_LastInstalledVersion == Mazzifier_Version) or (Mazzifier_LastInstalledVersion < 0.50)) then
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["DCRCLEAN"] = nil
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["DCRPRSHOW"] = nil
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["DCRSHOW"] = nil
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["DCRSKSHOW"] = nil
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["CLEAN"] = {["bind1"] = "CTRL-D",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["PRIORITYADD"] = {["bind1"] = "ALT-D",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["PRIORITYDEL"] = {["bind1"] = "ALT-CTRL-D",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZ3DFORCEHUMAN"] = nil
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZ3DGUESSNEXT"] = nil
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZ3DGUESSPREVIOUS"] = nil
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZ3DOVERWRITE"] = nil
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZ3DPRINTINFO"] = nil
    end
    if ((Mazzifier_LastInstalledVersion == Mazzifier_Version) or (Mazzifier_LastInstalledVersion < 0.60)) then
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["CFE_LASTWHISPER"] = nil
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["CFE_WHISPER_TARGET"] = nil
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["REPLY2"] = {["bind1"] = "SHIFT-R",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUITTELL"] = {["bind1"] = "ALT-T",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["SCREENSHOT"] = {["bind1"] = "PRINTSCREEN",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIVIEW4"] = nil
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIVIEW5"] = nil
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIVIEW6"] = nil
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIVIEW7"] = nil

        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIMT1"] = {["bind1"] = "CTRL-F4",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIMT2"] = {["bind1"] = "CTRL-F5",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIMT3"] = {["bind1"] = "CTRL-F6",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIPARTYSHOW"] = {["bind1"] = "CTRL-F7",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["MAZZLEUIPARTYHIDE"] = {["bind1"] = "CTRL-SHIFT-F7",}
    end
    if ((Mazzifier_LastInstalledVersion == Mazzifier_Version) or (Mazzifier_LastInstalledVersion < 0.70)) then
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["BONUSACTIONBUTTON1"] = {["bind1"] = "ALT-1",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["BONUSACTIONBUTTON10"] = {["bind1"] = "ALT-0",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["BONUSACTIONBUTTON2"] = {["bind1"] = "ALT-2",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["BONUSACTIONBUTTON3"] = {["bind1"] = "ALT-3",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["BONUSACTIONBUTTON4"] = {["bind1"] = "ALT-4",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["BONUSACTIONBUTTON5"] = {["bind1"] = "ALT-5",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["BONUSACTIONBUTTON6"] = {["bind1"] = "ALT-6",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["BONUSACTIONBUTTON7"] = {["bind1"] = "ALT-7",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["BONUSACTIONBUTTON8"] = {["bind1"] = "ALT-8",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["BONUSACTIONBUTTON9"] = {["bind1"] = "ALT-9",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["AUTOBAR_BUTTON1"] = {["bind1"] = "[",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["AUTOBAR_BUTTON2"] = {["bind1"] = "]",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["AUTOBAR_BUTTON3"] = {["bind1"] = "SHIFT-[",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["AUTOBAR_BUTTON4"] = {["bind1"] = "SHIFT-]",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["AUTOBAR_BUTTON5"] = {["bind1"] = "ALT-[",}
        myBindingsDB.profiles[Mazzifier_PlayerName.." of "..Mazzifier_ServerName].bindings["AUTOBAR_BUTTON6"] = {["bind1"] = "ALT-]",}
    end
end

