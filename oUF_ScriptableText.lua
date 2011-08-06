local parent, ns = ...
local oUF = oUF
local LibCore = assert(LibStub("LibScriptableLCDCoreLite-1.0"))
local WidgetText = assert(LibStub("LibScriptableWidgetText-1.0"))
local core = LibCore:New({}, "oUF_ScriptableText", 1)

local Update = function(self, fs)
	if fs and fs:GetObjectType() == "FontString" then
		fs:SetText(self.buffer)
	end
end

local Enable = function(self, unit)
	local text = self.ScriptableText
	local col, row, layer = 0, 0, 0
	local errorLevel = 2
	if text and text:GetObjectType() == "FontString" then
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
		text.widget = text.widget or WidgetText:New(core, name, 
			{value=value, update=update, repeating=repeating, 
			speed=speed, direction=direction, align=align, cols=cols, 
			prefix=prefix, postfix=postfix}, row, col, layer, errorLevel, Update, text)
		text.widget.environment.unit = unit
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
