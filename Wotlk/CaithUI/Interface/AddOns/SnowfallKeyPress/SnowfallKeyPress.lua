--------------------------------------------------------------------------------
-- Initialization

local templates = {
  {command = "^ACTIONBUTTON(%d+)$",          attributes = {{"type", "macro"}, {"actionbutton", "%1"                         }}},  -- Action Buttons
  {command = "^MULTIACTIONBAR1BUTTON(%d+)$", attributes = {{"type", "click"}, {"clickbutton",  "MultiBarBottomLeftButton%1" }}},  -- BottomLeft Action Buttons
  {command = "^MULTIACTIONBAR2BUTTON(%d+)$", attributes = {{"type", "click"}, {"clickbutton",  "MultiBarBottomRightButton%1"}}},  -- BottomRight Action Buttons
  {command = "^MULTIACTIONBAR3BUTTON(%d+)$", attributes = {{"type", "click"}, {"clickbutton",  "MultiBarRightButton%1"      }}},  -- Right Action Buttons (rightmost)
  {command = "^MULTIACTIONBAR4BUTTON(%d+)$", attributes = {{"type", "click"}, {"clickbutton",  "MultiBarLeftButton%1"       }}},  -- Right ActionBar 2 Buttons (2nd from right)
  {command = "^SHAPESHIFTBUTTON(%d+)$",      attributes = {{"type", "click"}, {"clickbutton",  "ShapeshiftButton%1"         }}},  -- Special Action Buttons (shapeshift/stance)
  {command = "^BONUSACTIONBUTTON(%d+)$",     attributes = {{"type", "click"}, {"clickbutton",  "PetActionButton%1"          }}},  -- Secondary Action Buttons (pet/bonus)
  {command = "^MULTICASTSUMMONBUTTON(%d+)$", attributes = {{"type", "click"}, {"multicastsummon", "%1"                      }}},  -- Call of the Elements/Ancestors/Spirits
  {command = "^MULTICASTRECALLBUTTON1$",     attributes = {{"type", "click"}, {"clickbutton",  "MultiCastRecallSpellButton" }}},  -- Totemic Recall
  {command = "^CLICK (.+):([^:]+)$",         attributes = {{"type", "click"}, {"clickbutton",  "%1"                         }}},  -- Clicks
  {command = "^MACRO (.+)$",                 attributes = {{"type", "macro"}, {"macro",        "%1"                         }}},  -- Macros
--{command = "^SPELL (.+)$",                 attributes = {{"type", "spell"}, {"spell",        "%1"                         }}},  -- Spells
--{command = "^ITEM (.+)$",                  attributes = {{"type", "item" }, {"item",         "%1"                         }}},  -- Items
};

local hook = true;

local bindingKeys = {};

local overrideFrame = CreateFrame("Frame");

local allowedTypeAttributes = {
  ["actionbar"] = true,
  ["action"] = true,
  ["pet"] = true,
  ["multispell"] = true,
  ["spell"] = true,
  ["item"] = true,
  ["macro"] = true,
  ["cancelaura"] = true,
  ["stop"] = true,
  ["target"] = true,
  ["focus"] = true,
  ["assist"] = true,
  ["maintank"] = true,
  ["mainassist"] = true
};



--------------------------------------------------------------------------------
-- Clear key binding mode so that the Blizzard key binding UI doesn't look for overrides and generate bogus messages like: "CLICK SnowfallKeyPress_Button_1:LeftButton Function is Now Unbound!"

hooksecurefunc("ShowUIPanel", function() if (KeyBindingFrame) then KeyBindingFrame.mode = nil; end end);



--------------------------------------------------------------------------------
-- Helper functions

local function addGetBindingKeys(_, ...)
  for i = 1, select("#", ...) do
    bindingKeys[select(i, ...)] = true;
  end
end


local function isSecureButton(x)
  return not not (
    type(x) == "table"
    and type(x.IsObjectType) == "function"
    and issecurevariable(x, "IsObjectType")
    and x:IsObjectType("Button")
    and select(2, x:IsProtected())
  );
end


-- Accelerate a key, which we must not currently be overriding
local function accelerateKey(key)
  local command;
  local bindButtonName, bindButton;
  local attributeName, attributeValue;
  local mouseButton, harmButton, helpButton;
  local mouseType, harmType, helpType;
  local clickButtonName, clickButton;

  -- Make sure this key is bound to a command
  command = GetBindingAction(key, true);
  if (not command or command == "") then
    return;
  end

  for _, template in ipairs(templates) do
    if (string.match(command, template.command)) then
      -- make sure there are attributes. Otherwise, this key is blacklisted
      if (template.attributes) then
        clickButtonName, mouseButton = string.match(command, "^CLICK (.+):([^:]+)$");
        if (clickButtonName) then
          -- For clicks, check that the target is a SecureActionButton that isn't doing anything that could possibly rely on differentiating down/up clicks
          clickButton = _G[clickButtonName];
          if (not isSecureButton(clickButton) or clickButton:GetAttribute("", "downbutton", mouseButton)) then
            return;
          end
          harmButton = SecureButton_GetModifiedAttribute(clickButton, "harmbutton", mouseButton);
          helpButton = SecureButton_GetModifiedAttribute(clickButton, "helpbutton", mouseButton);
          mouseType = SecureButton_GetModifiedAttribute(clickButton, "type", mouseButton);
          harmType = SecureButton_GetModifiedAttribute(clickButton, "type", harmButton);
          helpType = SecureButton_GetModifiedAttribute(clickButton, "type", helpButton);
          if (
            mouseType and not allowedTypeAttributes[mouseType]
            or harmType and not allowedTypeAttributes[harmType]
            or helpType and not allowedTypeAttributes[helpType]
          ) then
            return;
          end
        else
          -- For non-clicks, the default mouse button is LeftButton
          mouseButton = "LeftButton";
        end

        -- make the bind button if it doesn't already exist
        bindButtonName = "SnowfallKeyPress_Button_" .. key;
        bindButton = _G[bindButtonName];
        if (not bindButton) then
          bindButton = CreateFrame("Button", "SnowfallKeyPress_Button_" .. key, nil, "SecureActionButtonTemplate");
          bindButton:RegisterForClicks("AnyDown");
          SecureHandlerSetFrameRef(bindButton, "VehicleMenuBar", VehicleMenuBar);
          SecureHandlerSetFrameRef(bindButton, "BonusActionBarFrame", BonusActionBarFrame);
          SecureHandlerSetFrameRef(bindButton, "MultiCastSummonSpellButton", MultiCastSummonSpellButton);
          SecureHandlerExecute(
            bindButton,
            [[
              VehicleMenuBar = self:GetFrameRef("VehicleMenuBar");
              BonusActionBarFrame = self:GetFrameRef("BonusActionBarFrame");
              MultiCastSummonSpellButton = self:GetFrameRef("MultiCastSummonSpellButton");
            ]]
          );
        end

        -- apply specified attributes
        for _, attribute in ipairs(template.attributes) do
          attributeName = attribute[1];
          attributeValue = string.gsub(command, template.command, attribute[2], 1);

          if (attributeName == "clickbutton") then
            -- For "clickbutton" attributes, convert the button name into a button reference
            bindButton:SetAttribute(attributeName, _G[attributeValue]);
          elseif (attributeName == "actionbutton") then
            -- For our custom "actionbutton" attribute, we'll make the decision which button (vehicle/bonus/action) to click similar to how Blizzard does it in ActionButton.lua:ActionButtonUp()
            SecureHandlerUnwrapScript(bindButton, "OnClick");
            SecureHandlerWrapScript(
              bindButton, "OnClick", bindButton,
              [[
                local clickMacro = "/click ActionButton]] .. attributeValue .. [[";
                if (VehicleMenuBar:IsProtected() and VehicleMenuBar:IsShown() and ]] .. tostring(tonumber(attributeValue) <= VEHICLE_MAX_ACTIONBUTTONS) .. [[) then
                  clickMacro = "/click VehicleMenuBarActionButton]] .. attributeValue .. [[";
                elseif (BonusActionBarFrame:IsProtected() and BonusActionBarFrame:IsShown()) then
                  clickMacro = "/click BonusActionButton]] .. attributeValue .. [[";
                end
                self:SetAttribute("macrotext", clickMacro);
              ]]
            );
          elseif (attributeName == "multicastsummon") then
            -- For our custom "multicastsummon" attribute, before the click, we'll set the button ID based upon the binding
            SecureHandlerUnwrapScript(bindButton, "OnClick");
            SecureHandlerWrapScript(
              bindButton, "OnClick", bindButton,
              [[
                lastID = MultiCastSummonSpellButton:GetID();
                MultiCastSummonSpellButton:SetID(]] .. attributeValue .. [[);
              ]],
              [[
                MultiCastSummonSpellButton:SetID(lastID);
              ]]
            );
            bindButton:SetAttribute("clickbutton", MultiCastSummonSpellButton);
          else
            bindButton:SetAttribute(attributeName, attributeValue);
          end
        end

        -- create a priority override
        hook = false;
        SetOverrideBindingClick(overrideFrame, true, key, bindButtonName, mouseButton);
        hook = true;
      end

      -- stop since we found a matching template
      return;
    end
  end
end



--------------------------------------------------------------------------------
-- UPDATE_BINDINGS
-- Find all keys we can. Accelerate them.

local function updateBindings()
  if (InCombatLockdown()) then
    return;
  end

  -- Remove all of our overrides so we can see other overrides
  hook = false;
  ClearOverrideBindings(overrideFrame);
  hook = true;

  -- Add all keys with bindings that appear in Options->KeyBindings
  for i = 1, GetNumBindings() do
    addGetBindingKeys(GetBinding(i));
  end

  -- Add all macros with bindings
  local numAccountMacros, numCharacterMacros = GetNumMacros();
  local numMacros = numAccountMacros + numCharacterMacros;
  local macroName;
  local macroCount = 0;
  for i = 1, math.huge do
    if (macroCount == numMacros) then
      break;
    end
    macroName = GetMacroInfo(i);
    if (macroName) then
      addGetBindingKeys(nil, GetBindingKey("MACRO " .. macroName));
      macroCount = macroCount + 1;
    end
  end

  -- If spell/item binding support was added, we'd add code to find their keys here

  -- Accelerate every key we know about
  for key in pairs(bindingKeys) do
    accelerateKey(key);
  end
end

overrideFrame:SetScript("OnEvent", updateBindings);
overrideFrame:RegisterEvent("UPDATE_BINDINGS");
overrideFrame:RegisterEvent("UPDATE_MACROS");



--------------------------------------------------------------------------------
-- SetOverrideBinding*
-- Make sure this key is in our table of binding keys. Remove our override. See what the key is bound to, now. Apply a new override.

local function setOverrideBindingHook(_, _, key)
  if (not hook or InCombatLockdown()) then
    return;
  end

  bindingKeys[key] = true;

  hook = false;
  SetOverrideBinding(overrideFrame, false, key, nil);
  hook = true;

  accelerateKey(key);
end
hooksecurefunc("SetOverrideBinding", setOverrideBindingHook);
hooksecurefunc("SetOverrideBindingSpell", setOverrideBindingHook);
hooksecurefunc("SetOverrideBindingClick", setOverrideBindingHook);
hooksecurefunc("SetOverrideBindingItem", setOverrideBindingHook);
hooksecurefunc("SetOverrideBindingMacro", setOverrideBindingHook);



--------------------------------------------------------------------------------
-- ClearOverrideBindings
-- Remove all our overrides. Re-apply overrides for all key bindings (to potentially new commands).

local function clearOverrideBindingsHook()
  if (not hook or InCombatLockdown()) then
    return;
  end

  hook = false;
  ClearOverrideBindings(overrideFrame);
  hook = true;

  for key in pairs(bindingKeys) do
    accelerateKey(key);
  end
end
hooksecurefunc("ClearOverrideBindings", clearOverrideBindingsHook);
