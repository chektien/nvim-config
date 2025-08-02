-- Generic Neovim options

local opt = vim.opt

opt.number = true -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers
opt.tabstop = 4 -- Number of spaces a tab counts for
opt.shiftwidth = 4 -- Number of spaces used for autoindent
opt.expandtab = true -- Convert tabs to spaces
opt.hidden = true -- Allow switching buffers without saving
opt.encoding = "utf-8" -- Set default encoding
opt.termguicolors = true -- Enable true color support
opt.clipboard:append("unnamedplus") -- Use system clipboard
opt.undofile = true -- Enable persistent undo
opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup before overwriting
opt.updatetime = 250 -- Faster update time for plugins like GitGutter
opt.shortmess:append("c") -- Don't show completion messages
opt.diffopt:append("vertical") -- Show diffs vertically
opt.splitbelow = true -- Horizontal splits go below
opt.splitright = true -- Vertical splits go to the right
opt.foldmethod = "marker" -- Use markers for folding ({{{ }}}
opt.foldenable = false -- Disable folding by default
opt.background = "dark" -- Set background for colorschemes
opt.scrolloff = 10 -- Keep 5 lines visible when scrolling vertically
opt.sidescrolloff = 8 -- Keep 8 columns visible when scrolling horizontally
opt.mouse = "a" -- Enable mouse support in all modes
opt.cursorline = true -- Highlight the current line
opt.ignorecase = true -- Case-insensitive search...
opt.smartcase = true -- ...unless search contains uppercase
opt.showmode = false -- Don't show mode in the command line
opt.breakindent = true -- Maintain indentation when wrapping lines
opt.signcolumn = "yes" -- Always show the sign column
opt.confirm = true -- when :q etc., show dialog instead of error
opt.list = true -- Show whitespace characters
opt.listchars = {
  tab = "» ", -- Show tabs as arrows
  trail = "·", -- Show trailing spaces as dots
  nbsp = "␣", -- Show non-breaking spaces as a special character
}
