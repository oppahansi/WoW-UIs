local AceLocale = AceLibrary("AceLocale-2.1")

AceLocale:RegisterTranslation("SkillsPlusFu", "enUS", function() 
    return {
        ["NAME"] = "FuBar - SkillsPlusFu",
        ["DESCRIPTION"] = "Show and access skills.",
        ["COMMANDS"] = {"/spf", "/skillsplusfu"},
        ["CMD_OPTIONS"] = {},
        
        ["FUBAR_LABEL"] = "Skills",
        
        ["MENU_SHOW_BOOLEAN_SKILLS"] = "Show boolean skills",
        
        ["TOOLTIP_HINT"] = "Click to access the named skill.\nAccess Right-click menu to select a skill.",
    }

end)

