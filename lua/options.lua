vim.opt.clipboard = 'unnamedplus'	 -- use system clipboard
vim.opt.completeopt = {'menu', 'menuone', 'noselect'} vim.opt.mouse = 'a'	-- allow the mouse to be used in nvim
-- Tab
vim.opt.tabstop = 4	-- number of visual spaces per TAB
vim.opt.softtabstop = 4	-- number of spaces in tab when editing
vim.opt.shiftwidth = 4 	-- insert 4 spaces on a tab
vim.opt.expandtab = true	-- tabs are spaces, mainly because of Python

-- UI config
vim.opt.number = true	-- show absolute number
vim.opt.relativenumber = true	-- add numbers to each line on the left side
vim.opt.cursorline = true	-- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true	-- open new vertical split bottom
vim.opt.splitright = true	-- open new horizontal splits right
vim.opt.showmode = false	-- we are experienced, we don't need the "-- INSERT --" mode hint

-- Searching
vim.opt.incsearch = true	-- search as characters are entered
vim.opt.hlsearch = false	-- do not highlight matches
vim.opt.ignorecase = true	-- ignore case in searches by default
vim.opt.smartcase = true	-- but make it case sensitive if an uppercase is entered

-- Performance
vim.opt.updatetime = 250    -- Faster completion (default 4000ms)
vim.opt.timeoutlen = 300    -- Faster key sequence completion
vim.opt.lazyredraw = false   -- Don't redrew during macros (keep false in modern nvim)

-- Faster scrolling
vim.opt.ttyfast = true

-- Global clipboard - use OSC 52 (allows also over SSH for supported teminal emulators)
vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
        ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
        ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
}

