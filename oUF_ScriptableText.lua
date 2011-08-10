local parent, ns = ...
local oUF = oUF
local WidgetText = assert(LibStub("LibScriptableWidgetText-1.0"), "oUF_ScriptableText requires LibScriptableWidgetText-1.0")

oUF.ALIGN_LEFT, oUF.ALIGN_CENTER, oUF.ALIGN_RIGHT, oUF.ALIGN_MARQUEE, oUF.ALIGN_AUTOMATIC, oUF.ALIGN_PINGPONG = 1, 2, 3, 4, 5, 6
oUF.SCROLL_RIGHT, oUF.SCROLL_LEFT = 1, 2
local floor = math.floor
local objects = {}
local keys = {}
local uid = function(unit)
	local key = parent .. unit .. floor(random() * 1000000)
	if keys[key] then 
		uid(unit)
		return parent .. unit .. random()
	end
	keys[key] = true
	return key
end

local Update = function(self)
	local fs = self.fontstring
	if fs and fs:GetObjectType() == "FontString" then
		fs:SetText(self.buffer)
	end
end

local MyUpdate = function(self, event, unit)
	if unit ~= self.unit or not self.ScriptableText then return end
	for k, text in ipairs(self.ScriptableText) do
		text:Start(unit)
	end
end

local Enable = function(self, unit)
	if self.unit ~= unit or not self.ScriptableText then return end
	local i = 1
	while i <= #self.ScriptableText do
		local text = self.ScriptableText[i]
		if text and text:GetObjectType() == "FontString" then
			assert(self.core, "You must provide a LibCore object.")
			local count = 0
			local name = uid(unit)
			local errorLevel = 2
			local widget = WidgetText:New(self.core, name, text, 0, 0, 0, errorLevel, Update, text)
			widget.fontstring = text
			text.widget = widget
			widget:Start(unit)
			self.ScriptableText[i] = widget
		end
		i = i + 1
	end
	return true
end

local Disable = function(self)
	if not self.ScriptableText then return end
	local i = 1
	for k, text in ipairs(self.ScriptableText) do
		text:Stop()
	end
	return true
end

oUF:AddElement('ScriptableText', MyUpdate, Enable, Disable)
