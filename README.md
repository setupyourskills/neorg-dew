# neorg-dew

🌿 **neorg-dew** is a collection of minimal, purpose-driven extensions for [Neorg](https://github.com/nvim-neorg/neorg), designed around a personal and efficient workflow.

Each submodule depends on the core **neorg-dew** module, which provides essential base libraries and utilities.  
This design keeps individual modules lightweight and focused, avoiding unnecessary code duplication.

You can use just one module, combine several, or build your own system around them.

## Installation

### Prerequisites

- A functional installation of [Neorg](https://github.com/nvim-neorg/neorg) is required for this module to work.

### Using Lazy.nvim

```lua
{ "setupyourskills/neorg-dew" }
```

## Configuration

```lua
["external.neorg-dew"] = {}
```

## Available submodules

🚧 **This project is under active and continuous development.**  
Currently, a few modules are available and under development:

| Module        | Description                                                                           |
|---------------|---------------------------------------------------------------------------------------|
| [dew-crumb](https://github.com/setupyourskills/dew-crumb)     | Displays breadcrumbs from headings and the Title                                      |
| [dew-catngo](https://github.com/setupyourskills/dew-catngo)    | Quick and simple note picker focused on category-based selection                      |
| [dew-smartlink](https://github.com/setupyourskills/dew-smartlink) | Automatically inserts a formatted link using the clipboard URL and fetched page title |

## Public API

### `telescope_picker(prompt, items, opts, map_callback)`

This module exposes a public helper function `telescope_picker`, which acts as a generic and reusable Telescope interface for Neorg-related selections.

#### Parameters:

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

## Collaboration and Compatibility

This project embraces collaboration and may build on external modules created by other Neorg members, which will be tested regularly to ensure they remain **functional** and **compatible** with the latest versions of Neorg and Neovim.  

## Why **dew**?

Like morning dew, it’s **subtle**, **natural**, and brief, yet vital and effective for any workflow.
