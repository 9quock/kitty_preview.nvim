local M = {}


local config = {
  keymap = '<leader>P',
  prefix = 'silent !kitty @ --to=$KITTY_LISTEN_ON launch --type=window ',
  mappings = {
    image = {'.bmp', '.jpg', '.jpeg', '.png'},
    video = {'.mp4', '.gif', '.mp3'},
  },
  previewers = {
    image = 'kitty icat --hold "%path%"',
    video = 'mpv --vo=kitty --loop "%path%"',
  }
}


-- checkFileExtension is a horrible name btw, but i can't come up with anything better
local function checkFileExtension(fileExtensionList, path)
  for _, extension in ipairs(fileExtensionList) do
    if(path:sub(-#extension) == extension) then return true end
  end
  return false
end

function M.UpplyConfig(userConfig)
  if(vim.fn.maparg('n', config.keymap) ~= "") then vim.keymap.del('n', config.keymap) end
  config = vim.tbl_deep_extend('force', config, userConfig or {})
  vim.keymap.set('n', config.keymap, function() require('kitty_preview').NvimTreePreview() end, { desc = 'Preview image under cursor' })
end

function M.Preview(absolutePath)
  for k, v in pairs(config.mappings) do
    if(checkFileExtension(v, absolutePath)) then
      vim.api.nvim_command(config.prefix .. config.previewers[k]:gsub('%%path%%', absolutePath))
      return
    end
  end
  print('No preview for file ' .. absolutePath)
end

function M.NvimTreePreview()
  local kitty_preview = require('kitty_preview')
  local nvimtree = require('nvim-tree.api')
  local path = nvimtree.tree.get_node_under_cursor().absolute_path
  kitty_preview.Preview(path)
end

function M.setup(userConfig)
  require('kitty_preview').UpplyConfig(userConfig)
end

return M
