local parent, ns = ...
local oUF = oUF
local WidgetText = assert(LibStub("LibScriptableWidgetText-1.0"))

oUF.ALIGN_LEFT, oUF.ALIGN_CENTER, oUF.ALIGN_RIGHT, oUF.ALIGN_MARQUEE, oUF.ALIGN_AUTOMATIC, oUF.ALIGN_PINGPONG = 1, 2, 3, 4, 5, 6
oUF.SCROLL_RIGHT, oUF.SCROLL_LEFT = 1, 2

local Update = function(self, fs)
	if fs and fs:GetObjectType() == "FontString" then
		fs:SetText(self.buffer)
	end
end

local Enable = function(self, unit)
	local text = self.ScriptableText
	if text and text:GetObjectType() == "FontString" then
		assert(self.core)
		local col, row, layer = 0, 0, 0
		local errorLevel = 2
		local name = text.name or "ScriptableText"
		local value = text.value or ""
		local update = text.update or 0
		local repeating = text.repeating or false
		local speed = text.speed or 0
		local direction = text.direction or 1
		local align = text.align or 1
		local cols = text.cols or 40
		local prefix = text.prefix or ""
		local postfix = text.postfix or ""
		local widget = text.widget or WidgetText:New(self.core, name, 
			{value=value}, row, col, layer, errorLevel, Update, text)
		widget.config.value = value
		widget.config.update = update
		widget.config.repeating = repeating
		widget.config.speed = speed
		widget.config.direction = direction
		widget.config.align = align
		widget.config.cols = cols
		widget.config.prefix = prefix
		widget.config.postfix = postfix
		widget:Init()
		widget.environment.unit = unit
		text.widget = widget
		text.widget:Start()
		text.widget.fontstring = text
	end
	return true
end

local Disable = function(self)
	self.widget:Stop()
	return true
end

oUF:AddElement('ScriptableText', nil, Enable, Disable)
