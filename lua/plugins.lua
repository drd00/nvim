-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    "rebelot/kanagawa.nvim",
    {
        "saghen/blink.cmp",
        -- optional: provides snippes for the snippet source
        dependencies = { "rafamadriz/friendly-snippets" },

        -- Use a release tag to download pre-built binaries
        version = "*",

        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to VSCode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                -- Each keymap may be a list of commands and/or functions
                preset = "enter",
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                -- Scroll documentation
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                -- Show/hide signature
                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = "mono",
            },

            sources = {
                -- `lsp`, `buffer`, `snippets`, `path` and `omni` are built-in
                -- so you don't need to define them in `sources.providers`
                default = { "lsp", "path", "snippets", "buffer" },

                -- Sources are configured via the sources.providers table
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" },
            completion = {
                -- The keyword should only match against the text before
                keyword = { range = "prefix" },
                menu = {
                    -- Use treesitter to highlight the label text for the given list of sources
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                -- Show completions after typing a trigger character, defined by the source
                trigger = { show_on_trigger_character = true },
                documentation = {
                    -- Show documentation automatically
                    auto_show = true,
                },
            },

            -- Signature help when tying
            signature = { enabled = true },
        },

        opts_extend = { "sources.default" },
    },
    -- LSP manager
    { "mason-org/mason.nvim", opts = {} },
    -- Autopair support
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    {
        'nvim-telescope/telescope.nvim', version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            local actions = require('telescope.actions')

            require('telescope').setup({
                defaults = {
                    mappings = {
                        i = {   -- Insert mode mappings
                            ["<C-d>"] = actions.delete_buffer,
                        },
                        n = {   -- Normal mode mappings
                            ["<C-d>"] = actions.delete_buffer,
                            ["dd"] = actions.delete_buffer, -- Vim-like
                        },
                    },
                    extensions = {
                        fzf = {
                            fuzzy = true,    -- false will only do exact matching
                            override_generic_sorter = true, -- override the generic sorter
                            override_file_sorter = true,    -- override the file sorter
                            case_mode = "smart_case",   -- or "ignore_case" or "respect_case" - default is smart_case
                        }
                    }
                },
            })
            require('telescope').load_extension('fzf')

            -- Telewscope Keymaps
            vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
            vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
            vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
            vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)
        end
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            -- Harpoon keybinds
            vim.keymap.set('n', '<leader>a', function()
                harpoon:list():add()
            end)
            vim.keymap.set('n', '<C-e>', function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)
            vim.keymap.set('n', '<leader>1', function()
                harpoon:list():select(1)
            end)
            vim.keymap.set('n', '<leader>2', function()
                harpoon:list():select(2)
            end)
            vim.keymap.set('n', '<leader>3', function()
                harpoon:list():select(3)
            end)
            vim.keymap.set('n', '<leader>4', function()
                harpoon:list():select(4)
            end)
        end,
    },
    {
        "tpope/vim-fugitive",
        config = function()
          -- Optional configuration can go here
          vim.keymap.set('n', '<leader>gs', ':Git status<CR>', { noremap = true, silent = true })
        end
    }
})
