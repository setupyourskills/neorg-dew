local neorg = require "neorg.core"
local modules = neorg.modules

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local module = modules.create "external.neorg-dew"

module.public = {
  get_title = function(from_file)
    local lines = {}

    if from_file then
      local filepath = vim.api.nvim_buf_get_name(0)
      local f = io.open(filepath, "r")
      if not f then
        return nil
      end
      for line in f:lines() do
        table.insert(lines, line)
      end
      f:close()
    else
      lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    end

    local in_meta = false

    for _, line in ipairs(lines) do
      if line:match "^@document%.meta" then
        in_meta = true
      elseif line:match "^@end" and in_meta then
        break
      elseif in_meta then
        local matched = line:match "^title:%s*(.+)"
        if matched then
          return matched
        end
      end
    end
  end,

  wrap_text = function(text, limit, prefix)
    local result = {}
    local current_line = ""

    for word in text:gmatch "%S+" do
      if #current_line + #word + 1 > limit then
        table.insert(result, current_line)
        current_line = word
      else
        current_line = current_line == "" and word or current_line .. " " .. word
      end
    end

    if #current_line > 0 then
      table.insert(result, current_line)
    end

    if prefix then
      for i = 1, #result do
        result[i] = prefix .. result[i]
      end
    end

    return result
  end,

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
