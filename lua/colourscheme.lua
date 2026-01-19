-- define colourscheme here
local colourscheme = 'kanagawa'

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colourscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end
