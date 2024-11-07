# kitty_preview.nvim
Preview media directly from Neovim

## :zap: Requirements
- [Kitty](https://sw.kovidgoyal.net/kitty/)
- [Neovim](https://neovim.io/)
- [Nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)

## :package: Installation
### Install via your preferred package manager.  
Example with [lazy](https://github.com/folke/lazy.nvim):
```lua
{
    '9quock/kitty_preview.nvim',
    event = 'VeryLazy',
    opts = {
        -- config
    },
}
```
### Set up kitty
Add this your to kitty.conf
```
allow_remote_control yes
listen_on unix:@mykitty
```

## :gear: Configuration
Here is the default config:
```lua
{
    keymap = '<leader>P',  -- Keymap for opening preview
    prefix = 'silent !kitty @ --to=$KITTY_LISTEN_ON launch --type=window ',  -- Prepended to previewer commands
    mappings = {  -- Map file extentions to previewers
        image = {'bmp', 'jpg', 'jpeg', 'png'},
        video = {'mp4', 'gif', 'mp3'},
    },
    previewers = {  -- Commands for opening previewers
        image = 'kitty icat --hold "%path%"',
        video = 'mpv --vo=kitty --loop "%path%"',
    }
}
```

