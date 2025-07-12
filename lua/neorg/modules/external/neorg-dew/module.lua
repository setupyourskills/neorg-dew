local neorg = require "neorg.core"
local modules = neorg.modules

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local module = modules.create "external.neorg-dew"

module.public = {
  telescope_picker = function(prompt, items, opts, map_callback)
    pickers
      .new({}, {
        prompt_title = prompt,
        finder = finders.new_table {
          results = items,
          entry_maker = function(entry)
            return {
              value = opts.entry_value(entry),
              display = opts.entry_display(entry),
              ordinal = opts.entry_ordinal(entry),
            }
          end,
        },
        sorter = conf.generic_sorter {},
        attach_mappings = function(_, map)
          return map_callback(map, action_state, actions)
        end,
      })
      :find()
  end,
}

return module
