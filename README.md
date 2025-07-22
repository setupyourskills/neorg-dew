# Neorg Dew

🌿 **Neorg Dew** is a collection of minimal, purpose-driven extensions for [Neorg](https://github.com/nvim-neorg/neorg), designed around a personal and efficient workflow.

Each submodule depends on the core **neorg-dew** module, which provides essential base libraries and utilities.  
This design keeps individual modules lightweight and focused, avoiding unnecessary code duplication.

You can use just one module, combine several, or build your own system around them.

## Installation

### Prerequisites

- A functional installation of [Neorg](https://github.com/nvim-neorg/neorg) is required for this module to work.

### Using Lazy.nvim

```lua
{
  "setupyourskills/neorg-dew",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
}
```

## Configuration

```lua
["external.neorg-dew"] = {}
```

## Available submodules

🚧 **This project is under active and continuous development.**  
Currently, a few modules are available and under development:

| Module            | Description                                                                           |
|-------------------|---------------------------------------------------------------------------------------|
| [Dew CatnGo](https://github.com/setupyourskills/dew-catngo)        | Quick and simple note picker focused on category-based selection                      |
| [Dew Crumb](https://github.com/setupyourskills/dew-crumb)         | Displays breadcrumbs from headings and the Title                                      |
| [Dew Decor Link](https://github.com/setupyourskills/dew-decorlink)    | Inserts custom icons before Neorg link labels using a Telescope-powered picker        |
| [Dew Highlights](https://github.com/setupyourskills/dew-highlights)    | Customizes Tree-sitter highlight groups in `.norg` files                                |
| [Dew Random Quote](https://github.com/setupyourskills/dew-randomquote)  | Inserts a randomly fetched quote into the current buffer                              |
| [Dew Smart Link](https://github.com/setupyourskills/dew-smartlink)    | Automatically inserts a formatted link using the clipboard URL and fetched page title |

## Public API

### `get_title(from_file)`

This module exposes a helper function `get_title`, which extracts the `title` metadata from a @document.meta block in a Neorg file.
It can read either directly from the current buffer or from the file on disk, depending on the provided boolean flag.

#### Parameters

- `from_file` (`boolean`):

    - If `true`, the function reads the file content from disk 

    - If `false` it reads the title directly from the current buffer.

##### Returns

- `string` | `nil`:

    - The value of the `title` within de metadatas.

    - Returns `nil` if the title is not found or if the file cannot be read.

#### Example usage
```lua

local get_title = require("neorg.core.modules").get_module("external.neorg-dew").get_title()

-- From buffer (unsaved content supported)
local my_current_buffer_title = get_title()

-- From saved file on disk (useful to extract the title from another file)
local my_new_file_title = get_title(true)
```

### `level_up(line, levels)`

This module exposes a helper function `level_up` is used to increase the heading level of a Neorg line by a specified number of levels.

#### Parameters

- `line` (`string`): The function checks if the line of text begins with stars (*) after optional indentation, and increments the number of stars accordingly.

- `levels` (`integer`, optional):

    - The number of levels to increment.

    - Defaults to 1 if omitted.

#### Returns

`string`: The same line, with the heading level incremented by one (if eligible).

#### Example usage

```lua
local level_up = require("neorg.core.modules").get_module("external.neorg-dew").level_up

local line = "  *** My heading"
local new_line = level_up(line, 2)

print(new_line)

-- Output: "  ***** My heading
```

### `read_file(path)`

This module exposes a helper function `read_file`, which opens a file from the filesystem and returns its content as a list of lines.

#### Parameters

`path` (`string`): The absolute or relative path to the file you want to read.

##### Returns

- `string[]` | `nil`:

    - A table of strings, where each item corresponds to a line in the file.

    - Returns `nil` if the file does not exist or cannot be opened.

#### Example usage

```lua
local lines = require("neorg.core.modules").get_module("external.neorg-dew").read_file("/home/user/notes/my_note.norg")

if lines then
  for _, line in ipairs(lines) do
    print(line)
  end
end
```

### `telescope_picker(prompt, items, opts, map_callback)`

This module exposes a public helper function `telescope_picker`, which acts as a generic and reusable Telescope interface for Neorg-related selections.

#### Parameters

- `prompt` (`string`): The title shown at the top of the Telescope picker.

- `items` (`table`): A list of raw entries that you want to display in the picker.

- `opts` (`table`): A table of functions used to extract values from each entry:

    - `entry_value(entry)` → the value to return when selected.

    - `entry_display(entry)` → the string shown in the Telescope UI.

    - `entry_ordinal(entry)` → the field used for fuzzy matching and sorting.

- `map_callback(map, action_state, actions)` (`function`): A function to attach custom Telescope mappings.

    - `map` → the Telescope mapping function,

    - `action_state` → the current Telescope state object,

    - `actions` → available Telescope actions.

#### Example usage

```lua
require("neorg.core.modules").get_module("external.neorg-dew").telescope_picker(
    "Select a file",
    { "file1.norg", "file2.norg" },
    {
      entry_value = function(e) return e end,
      entry_display = function(e) return e end,
      entry_ordinal = function(e) return e end,
    },
    function(map, action_state, actions)
      map("i", "<CR>", function(bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(bufnr)
        vim.cmd("edit " .. selection.value)
      end)
      return true
    end
  )
```

### `wrap_text(text, limit, prefix)`

This module exposes a public helper function `wrap_text`, which formats a long string into a list of wrapped lines with an optional prefix.

#### Parameters

- `text` (`string`): The input string you want to wrap (e.g. a long quote or paragraph).

- `limit` (`integer`): The maximum number of characters per line before wrapping.

- `prefix` (`string`, optional): A string prepended to the beginning of each wrapped line (e.g. ">> " or "- "). If omitted, no prefix is added.

##### Returns

(`table<string>`): A list of strings, each representing a line of wrapped text (with prefix if provided).

#### Example usage

```lua
local wrapped = require("neorg.core.modules").get_module("external.neorg-dew").wrap_text("The quick brown fox jumps over the lazy dog", 10, ">> ")
-- Result:
-- {
--   ">> The quick",
--   ">> brown fox",
--   ">> jumps over",
--   ">> the lazy",
--   ">> dog"
-- }
```

## Collaboration and Compatibility

This project embraces collaboration and may build on external modules created by other Neorg members, which will be tested regularly to ensure they remain **functional** and **compatible** with the latest versions of Neorg and Neovim.  

## Why **dew**?

Like morning dew, it’s **subtle**, **natural**, and brief, yet vital and effective for any workflow.
