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
		self.widget = self.widget or WidgetText:New(core, self.name or "ScriptableText", {value=self.value, update=100, repeating=self.repeating, speed=self.speed, direction=self.direction, align=self.align, cols=self.cols, prefix=self.prefix, postfix=self.postfix}, row, col, layer, errorLevel, Update, text)
		self.widget.environment.unit = unit
		self.widget:Start()
		text.__owner = self
		text.__widget = self.widget
		self.widget.fontstring = text
	end
	return true
end

local Disable = function(self)
	self.widget:Stop()
	return true
end

oUF:AddElement('ScriptableText', nil, Enable, Disable)
