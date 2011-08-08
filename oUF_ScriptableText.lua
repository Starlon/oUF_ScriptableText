local parent, ns = ...
local oUF = oUF
local WidgetText = assert(LibStub("LibScriptableWidgetText-1.0"), "oUF_ScriptableText requires LibScriptableWidgetText-1.0")

oUF.ALIGN_LEFT, oUF.ALIGN_CENTER, oUF.ALIGN_RIGHT, oUF.ALIGN_MARQUEE, oUF.ALIGN_AUTOMATIC, oUF.ALIGN_PINGPONG = 1, 2, 3, 4, 5, 6
oUF.SCROLL_RIGHT, oUF.SCROLL_LEFT = 1, 2

local Update = function(self)
	local fs = self.fontstring
	if fs and fs:GetObjectType() == "FontString" then
		fs:SetText(self.buffer)
	end
end

local MyUpdate = function(self, event, unit)
	if unit ~= self.unit or not self.ScriptableText then return end
	Update(self.ScriptableText.widget)
end

local Enable = function(self, unit)
	if self.unit ~= unit then return end
	local text = self.ScriptableText
	if text and text:GetObjectType() == "FontString" then
		assert(self.core, "You must provide a LibCore object.")
		local col, row, layer = 0, 0, 0
		local errorLevel = 2
		local name = text.name or ("ScriptableText" .. random() * random() * time())

		text.unitOverride = unit

		local widget = text.widget or WidgetText:New(self.core, name, 
			text, row, col, layer, errorLevel, Update, text)

		text.widget = widget
		text.widget.fontstring = text
		text.widget:Start()
	end
	return true
end

local Disable = function(self)
	if not self.ScriptableText then return end
	self.ScriptableText.widget:Stop()
	return true
end

oUF:AddElement('ScriptableText', MyUpdate, Enable, Disable)
