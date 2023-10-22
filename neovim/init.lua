vim.opt.scrolloff = 8
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.guicursor = ""
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true

-- Plugins setup
vim.cmd [[
  call plug#begin('~/.vim/plugged')
  " Fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " Theme
  Plug 'EdenEast/nightfox.nvim'
  " Highlighted yank
  Plug 'machakann/vim-highlightedyank'
  " Comments
  Plug 'tpope/vim-commentary'
  " Nerdtree
  Plug 'preservim/nerdtree'
  " Indent blocks
  Plug 'michaeljsmith/vim-indent-object'
  " Sneak
  Plug 'justinmk/vim-sneak'
  " Quick Scope
  Plug 'unblevable/quick-scope'
  " Telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " Rainbow
  Plug 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git' 
  " Harpoon
  Plug 'ThePrimeagen/harpoon'
  " Undo
  Plug 'mbbill/undotree'
  " Git
  Plug 'tpope/vim-fugitive'
  "  Uncomment these if you want to manage LSP servers from neovim
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  " LSP Support
  Plug 'neovim/nvim-lspconfig'
  " Autocompletion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
  " Tabline
  Plug 'nvim-lualine/lualine.nvim'
  " Icons
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'ryanoasis/vim-devicons'
  Plug 'bryanmylee/vim-colorscheme-icons'
  " Debugger
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'mfussenegger/nvim-dap-python'
  Plug 'theHamsta/nvim-dap-virtual-text'
  Plug 'mxsdev/nvim-dap-vscode-js', { 'requires': 'mfussenegger/nvim-dap' }
  Plug 'microsoft/vscode-js-debug', { 'do': 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out' }
  " Docs
  Plug 'folke/neodev.nvim'
  " Docstrings
  Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
  " Auto-pairing
  Plug 'windwp/nvim-autopairs'
  call plug#end()
]]

-- Color scheme background compatibility
vim.cmd [[
  au ColorScheme nightfox hi Normal ctermbg=none guibg=none
  colorscheme nightfox
]]

-- Key mappings
vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', '<leader>pv', ':Vex<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><CR>', ':so C:/Users/Andrei/AppData/Local/nvim/init.lua<CR>', { noremap = true, silent = true })

-- For vnoremap commands
vim.api.nvim_set_keymap('v', 'J', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'K', ':m \'<-2<CR>gv=gv', { noremap = true, silent = true })

-- Quick scope
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }

-- Send current selection to null register so that pasting keeps the previous one in buffer
vim.api.nvim_set_keymap('v', '<leader>p', '"_dP', { noremap = true, silent = true })

-- Send yank to system clipboard
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })

-- Send yank to system clipboard, but in normal mode, to allow extras (like selecting a whole paragraph)
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })

-- Copy the whole file
vim.api.nvim_set_keymap('n', '<leader>Y', 'gg"+yG', { noremap = true, silent = true })

-- Uppercase the whole word
vim.api.nvim_set_keymap('n', '<Leader>u', 'viwU', { noremap = true, silent = true })

-- Lowercase the whole word
vim.api.nvim_set_keymap('n', '<Leader>l', 'viwu', { noremap = true, silent = true })

-- Keep cursor in the middle when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Leaver cursor at the beginning after joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- No capital Q
vim.keymap.set("n", "Q", "<nop>")

-- Replace multiple words via menu
vim.keymap.set("n", "<leader>rp", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > " )})
end)

-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "typescript", "javascript"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "python" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true, 
  },
}

-- Auto-pairing
require("nvim-autopairs").setup {}

-- Rainbow
local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    highlight = {
        'RainbowDelimiterYellow',
        'RainbowDelimiterGreen',
        'RainbowDelimiterCyan',
        'RainbowDelimiterViolet',
        'RainbowDelimiterOrange',
        'RainbowDelimiterBlue',
        'RainbowDelimiterRed',
    },
}

-- Set the autocommand for Nightfox color integration
vim.cmd [[
  au ColorSchemePre nightfox highlight link RainbowDelimiterRed NightfoxRed
  au ColorSchemePre nightfox highlight link RainbowDelimiterYellow NightfoxYellow
  au ColorSchemePre nightfox highlight link RainbowDelimiterBlue NightfoxBlue
  au ColorSchemePre nightfox highlight link RainbowDelimiterOrange NightfoxOrange
  au ColorSchemePre nightfox highlight link RainbowDelimiterGreen NightfoxGreen
  au ColorSchemePre nightfox highlight link RainbowDelimiterViolet NightfoxViolet
  au ColorSchemePre nightfox highlight link RainbowDelimiterCyan NightfoxCyan
]]

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

-- Undotree
vim.keymap.set("n", "<leader>ud", vim.cmd.UndotreeToggle)

-- Fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- LSP Setup
local lspconfig = require('lspconfig')

-- Doge
vim.g.doge_enable_mappings = 0
vim.g.doge_doc_standard_python = 'google'
vim.api.nvim_set_keymap('n', '<Leader>g', '<Plug>(doge-generate)', { noremap = true, silent = true })

-- Interactive mode comment todo-jumping 
vim.api.nvim_set_keymap('n', '<TAB>', '<Plug>(doge-comment-jump-forward)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-TAB>', '<Plug>(doge-comment-jump-backward)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<TAB>', '<Plug>(doge-comment-jump-forward)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-TAB>', '<Plug>(doge-comment-jump-backward)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('s', '<TAB>', '<Plug>(doge-comment-jump-forward)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('s', '<S-TAB>', '<Plug>(doge-comment-jump-backward)', { noremap = true, silent = true })

-- Set up pyright for Python
lspconfig.pyright.setup({
    on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true }

        -- Key mappings for LSP functionalities
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

        -- Definitions and declarations
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        
        -- Hover and implementations
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        
        -- Signature help
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        
        -- Workspace folders
        buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        
        -- Type definitions, rename, references, and code actions
        buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        
        -- Diagnostics navigation and float window
        buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        
        -- Formatting
        buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
    end
})

-- Set up tsserver for TS/JS
lspconfig.tsserver.setup({
    on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true }

        -- Key mappings for LSP functionalities
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

        -- Definitions and declarations
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        
        -- Hover and implementations
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        
        -- Signature help
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        
        -- Workspace folders
        buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        
        -- Type definitions, rename, references, and code actions
        buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        
        -- Diagnostics navigation and float window
        buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        
        -- Formatting
        buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
    end
})

-- Autocompletion with nvim-cmp
local cmp = require('cmp')
cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    },
})


-- LUALINE
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'nightfox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}


-- RUNNING TERMINAL PROCESSES
-- Navigate through buffers
vim.api.nvim_set_keymap('n', '<leader>nb', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pb', ':bprevious<CR>', { noremap = true, silent = true })

-- Switch between the current and previous buffer.
vim.api.nvim_set_keymap('n', '<leader><Tab>', ':b#<CR>', { noremap = true, silent = true })

-- Delete all buffers
vim.api.nvim_set_keymap('n', '<leader>bd', ':bdelete<CR>', { noremap = true, silent = true })

-- Delete all other buffers (but not the current one)
vim.api.nvim_set_keymap('n', '<leader>bo', ':%bd|e#|bd#<CR>', { noremap = true, silent = true })

-- Stop the current terminal process
vim.api.nvim_set_keymap('t', '<C-c>', '<C-\\><C-n>:call jobstop(&channel)<CR>', { noremap = true, silent = true })

-- RUNNING PYTHON
-- Run the current file with python
vim.api.nvim_set_keymap('n', '<leader>py', ':belowright split | terminal python %<CR>', { noremap = true, silent = true })

-- Run pytest on the current file
vim.api.nvim_set_keymap('n', '<leader>pt', ':belowright split | terminal pytest %<CR>', { noremap = true, silent = true })

-- Function to get root directory (assumes a git directory indicates the root)
local function get_git_root()
    return vim.fn.systemlist("git rev-parse --show-toplevel")[1]
end

-- Run pylint on the current file
vim.api.nvim_set_keymap('n', '<leader>pl', ':belowright split | terminal pylint --rcfile=' .. get_git_root() .. '/pyproject.toml %<CR>', { noremap = true, silent = true })

-- Run pydocstyle on the current file with the Google convention
vim.api.nvim_set_keymap('n', '<leader>pd', ':belowright split | terminal pydocstyle --convention=google %<CR>', { noremap = true, silent = true })

-- Run black on the current file
vim.api.nvim_set_keymap('n', '<leader>bl', ':!black --config ' .. get_git_root() .. '/pyproject.toml %<CR>', { noremap = true, silent = true })

-- Automatically change the working directory to the directory of the current Python file whenever a new Python file is opened
vim.cmd('autocmd FileType python cd %:p:h')

-- DEBUGGING
-- Start debugging
vim.api.nvim_set_keymap('n', '<leader>d', '<Cmd>lua require"dap".continue()<CR>', { noremap = true, silent = true })

-- Set breakpoint
vim.api.nvim_set_keymap('n', '\\b', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })

-- Step over (next)
vim.api.nvim_set_keymap('n', '<leader>n', '<Cmd>lua require"dap".step_over()<CR>', { noremap = true, silent = true })

-- Step into
vim.api.nvim_set_keymap('n', '<leader>s', '<Cmd>lua require"dap".step_into()<CR>', { noremap = true, silent = true })

-- REPL (read eval print loop)
vim.api.nvim_set_keymap('n', '<leader>r', '<Cmd>lua require"dap".repl.open()<CR>', { noremap = true, silent = true })

-- Stop debugging
vim.api.nvim_set_keymap('n', '<leader>q', '<Cmd>lua require"dap".close()<CR>', { noremap = true, silent = true })

-- Restart debugging
vim.api.nvim_set_keymap('n', '<leader>dr', '<Cmd>lua require"dap".restart()<CR>', { noremap = true, silent = true })

-- Debugpy
require("dapui").setup()
require('dap-python').setup('')
require('dap-python').test_runner = 'pytest'
require("nvim-dap-virtual-text").setup()
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

-- UI
local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


