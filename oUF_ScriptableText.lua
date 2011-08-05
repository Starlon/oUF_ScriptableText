local parent, ns = ...
local oUF = oUF
local LibCore = assert(LibStub("LibScriptableLCDCoreLite-1.0"))
local WidgetText = assert(LibStub("LibScriptableWidgetText-1.0"))
local core = LibCore:New({}, "oUF_ScriptableText")

local Update = function(self)
	local fontstring = self.widget.fontstring
	fontstring:SetText(self.widget.buffer or "")
end

local Enable = function(self, unit)
	self.widget = self.widget or WidgetText:New(core, self.name, {value=self.value, update=self.update, repeating=self.repeating, speed=self.speed, direction=self.direction, align=self.align, cols=self.cols, prefix=self.prefix, postfix=self.postfix}, row, col, layer, errorLevel, Update, self)
	self.widget.fontstring = self.fontstring
	self.widget.environment.unit = unit
	self.widget:Start()
	return true
end

local Disable = function(self)
	self.widget:Stop()
	return true
end

oUF:AddElement('ScriptableText', nil, Enable, Disable)
