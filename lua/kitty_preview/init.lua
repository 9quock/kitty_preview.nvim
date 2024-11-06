local M = {}

local function GetFileExtension(url)
    return url:match("^.+(%..+)$")
end

function M.IsImage(url)
    local extension = GetFileExtension(url)

    if extension == '.bmp' then
        return true
    elseif extension == '.jpg' or extension == '.jpeg' then
        return true
    elseif extension == '.png' then
        return true
    elseif extension == '.gif' then
        return true
    end

    return false
end

function M.PreviewImage(absolutePath)
    if M.IsImage(absolutePath) then
        vim.api.nvim_command('silent !kitty @ --to=$KITTY_LISTEN_ON launch --type=window kitty icat --hold "' .. absolutePath .. '"')
    else
        print("No preview for file " .. absolutePath)
    end
end

function M.PreviewImageNvimTree()
  local kitty_preview = require("kitty_preview")
  local nvimtree = require("nvim-tree.api")
  local path = nvimtree.tree.get_node_under_cursor().absolute_path
  kitty_preview.PreviewImage(path)
end

function M.setup()
  vim.keymap.set("n", "<leader>P", function() require("kitty_preview").PreviewImageNvimTree() end, { desc = "Preview image under cursor" })
end

return M
