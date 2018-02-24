function CCP_TextureCoord(textureIndex, coords)
	local x1, x2, y1, y2;
	if (coords) then
		for i=1,4 do
			if (coords[i]) then
				if (coords[i] < 0 or coords[i] > 1) then return; end
			end
		end		
	end	
	local texture = getglobal("CCP_Texture_"..textureIndex.."_Texture");
	texture:SetTexCoord(coords[1], coords[2], coords[3],coords[4]);
end

function CCP_TextureFile(textureIndex, file)
	local texture = getglobal("CCP_Texture_"..textureIndex.."_Texture");
	texture:SetTexture(file);
end

function CCP_Alpha(textureIndex, alpha)
	local texture = getglobal("CCP_Texture_"..textureIndex.."_Texture");
	texture:SetAlpha(alpha);
end

--attachto and attachpoint: "TOPLEFT" or "CENTER"....
--attachframe: "UIParent"
function CCP_Attach(textureIndex, attachpoint, attachframe, attachto, xoffset, yoffset)
	if (attachframe == "") then return; end
	local texture = getglobal("CCP_Texture_"..textureIndex);
	texture:ClearAllPoints();
	texture:SetPoint(attachpoint, attachframe, attachto, xoffset, yoffset);
end

function CCP_Height(textureIndex, height)
	if (height <= 0) then return; end
	local texture = getglobal("CCP_Texture_"..textureIndex);
	texture:SetHeight(height);
end

function CCP_Width(textureIndex, width)
	if (width <= 0) then return; end
	local texture = getglobal("CCP_Texture_"..textureIndex);
	texture:SetWidth(width);
end

function CCP_Color(textureIndex, r, g, b)
	local texture = getglobal("CCP_Texture_"..textureIndex.."_Texture");
	texture:SetVertexColor(r, g, b);	
end

function CCP_Scale(textureIndex, scale)
	local texture = getglobal("CCP_Texture_"..textureIndex);
	texture:SetScale(scale);	
end

function CCP_Show(textureIndex)
	local texture = getglobal("CCP_Texture_"..textureIndex);
	texture:Show();
end

function CCP_Hide(textureIndex)
	if DENNIE_CCP_INOPTION == true then return;end
	local texture = getglobal("CCP_Texture_"..textureIndex);
	texture:Hide();
end

function CCP_DisableMouse(textureIndex)
	local texture = getglobal("CCP_Texture_"..textureIndex);
	texture:EnableMouse(false);
end

function CCP_EnableMouse(textureIndex)
	local texture = getglobal("CCP_Texture_"..textureIndex);
	texture:EnableMouse(true);
end
	
function CCP_StartFlashing(textureIndex)
	local texture = getglobal("CCP_Texture_"..textureIndex);
	if texture.flashing == true then return;end
	texture.flashing = true;
	texture.flashdct = 1;	
	texture.flashspd = .5;
	texture.flashtime = GetTime();
	texture.bakAlpha = texture:GetAlpha();
end

function CCP_StopFlashing(textureIndex)
	local texture = getglobal("CCP_Texture_"..textureIndex);
	texture.flashing = false;
	if texture.bakAlpha ~= nil then		
		texture:SetAlpha(texture.bakAlpha);
	end
end
