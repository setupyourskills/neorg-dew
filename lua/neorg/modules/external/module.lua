local neorg = require("neorg.core")
local modules = neorg.modules

local module = modules.create("external.my-module")

module.setup = function()
	return {}
end

module.public = {}

module.private = {}

module.config.public = {}

module.load = function()
	module.required["core.neorgcmd"].add_commands_from_table({})
end

module.on_event = function(event)

end

module.events.subscribed = {
	["core.neorgcmd"] = {},
}

return module
