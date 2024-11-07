local M = {}


local config = {
  keymap = '<leader>P',
  replace = '%%path%%',
  mappings = {
    icat = {'bmp', 'jpg', 'jpeg', 'png'},
    mpv = {'mp4', 'gif', 'mp3'},
  },
  previewers = {
    icat = 'kitty icat --hold "%path%"',
    mpv = 'mpv --vo=kitty --loop "%path%"',
  }
}


local function GetFileExtension(url)
  return url:match('^.+%.(.+)$')
end

function M.UpplyConfig(userConfig)
  if(vim.fn.maparg('n', config.keymap) ~= "") then vim.keymap.del('n', config.keymap) end
  config = vim.tbl_deep_extend('force', config, userConfig or {})
  vim.keymap.set('n', config.keymap, function() require('kitty_preview').NvimTreePreview() end, { desc = 'Preview image under cursor' })
end

function M.Preview(absolutePath)
  local fileExtension = GetFileExtension(absolutePath)
  for k, v in pairs(config.mappings) do
    if(vim.tbl_contains(v, fileExtension)) then
      vim.api.nvim_command('silent !kitty @ --to=$KITTY_LISTEN_ON launch --type=window ' .. config.previewers[k]:gsub(config.replace, absolutePath))
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
