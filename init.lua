vim.g.mapleader = " "

vim.opt.compatible = false
vim.cmd.syntax("on")
vim.cmd.filetype("plugin indent on")

vim.opt.termguicolors = true

vim.opt.swapfile = false
vim.opt.confirm = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.signcolumn = "yes"

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.smoothscroll = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 5

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.wildmenu = true

vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.clipboard = "unnamedplus"

vim.o.autocomplete = true
vim.o.pumheight = 5
vim.o.pumborder = 'rounded'
vim.opt.completeopt = {
  "menu",
  "menuone",
  "noselect",
  "preview",
}

vim.opt.grepprg = "rg --vimgrep --smart-case --follow"

vim.opt.path:append("**")
vim.opt.iskeyword:append("-")

vim.opt.updatetime = 100

vim.g.netrw_banner = 0
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3

vim.opt.foldlevel = 999
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank() end,
})

_G.git_branch = function()
  local branch = vim.fn.systemlist("git branch --show-current")[1]
  if not branch or branch == "" then
    return ""
  end
  return " " .. branch
end

function _G.StatusFilename()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then return "[No Name]" end
  return vim.fn.fnamemodify(name, ":t")
end

vim.opt.statusline = table.concat({
  "%#StatusLine#",
  "%#PmenuSel#%{v:lua.StatusFilename()}",
  "%m",
  "%#StatusLine#",
  " %{v:lua.git_branch()} ",
  "[%{get(b:,'gitsigns_status','')}]",
  "%=",
  "%{mode()} ",
  "%y ",
  "%{&fileencoding?&fileencoding:&encoding} ",
  "%#StatusLine#",
  "(%l,%c) %{line('$')} %P",
})

vim.keymap.set("i", "ww", "<Esc>:w<CR>")
vim.keymap.set("n", "ww", ":w<CR>")
vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<leader>P", '"+p')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>r", "<C-r>")
vim.keymap.set("n", "<leader>z", "<C-z>")
vim.keymap.set("n", "<leader>i", "<C-i>")
vim.keymap.set("n", "<leader>o", "<C-o>")
vim.keymap.set("n", "<leader>q", "<cmd>bd!<CR>")
vim.keymap.set("n", "<leader>x", "vip:!sh<CR>")
vim.keymap.set("n", "<leader>b", "<cmd>e %:h<CR>")
vim.keymap.set("n", "<leader>h", function() vim.fn.setreg("+", vim.fn.expand("%")) end)
vim.keymap.set("n", "<leader>nw", "<C-w>k")
vim.keymap.set("n", "<leader>nW", "<C-w>K")
vim.keymap.set("n", "<leader>nr", "<C-w>j")
vim.keymap.set("n", "<leader>nR", "<C-w>J")
vim.keymap.set("n", "<leader>ns", "<C-w>l")
vim.keymap.set("n", "<leader>nS", "<C-w>L")
vim.keymap.set("n", "<leader>na", "<C-w>h")
vim.keymap.set("n", "<leader>nA", "<C-w>H")
vim.keymap.set("n", "<leader>nn", "<C-w>w")
vim.keymap.set("n", "<leader>nt", "<C-w>W")
vim.keymap.set("n", "<leader>as", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/junegunn/fzf",
  "https://github.com/junegunn/fzf.vim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/romus204/tree-sitter-manager.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://codeberg.org/andyg/leap.nvim",
  "https://github.com/tpope/vim-commentary",
  "https://github.com/mbbill/undotree",
})

vim.cmd.packadd('cfilter')
-- vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

require("tokyonight").setup()
vim.cmd.colorscheme("tokyonight-night")

-- UndoTree
local undodir = vim.fn.expand("~/.undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p", 448) -- 0700 in decimal
end
vim.opt.undodir = undodir
vim.opt.undofile = true
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_WindowLayout = 2
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>")

-- FZF
vim.keymap.set("n", "<leader>fr", "<cmd>Rg!<CR>")
vim.keymap.set("n", "<leader>fR", "<cmd>RG!<CR>")
vim.keymap.set("n", "<leader>ff", "<cmd>Files!<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>GFiles!?<CR>")
vim.keymap.set("n", "<leader>fG", "<cmd>BCommits!<CR>")
vim.keymap.set("n", "<leader>fl", "<cmd>Lines!<CR>")
vim.keymap.set("n", "<leader>fc", "<cmd>Commits!<CR>")
vim.keymap.set("n", "<leader>fC", "<cmd>Changes!<CR>")
vim.keymap.set("n", "<leader>fm", "<cmd>Marks!<CR>")
vim.keymap.set("n", "<leader>fj", "<cmd>Jumps!<CR>")
vim.keymap.set("n", "<leader>fw", "<cmd>Windows!<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>History!<CR>")
vim.keymap.set("n", "<leader>fH", "<cmd>History:!<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Buffers!<CR>")
vim.keymap.set("n", "<leader>fp", "<cmd>Maps!<CR>")
vim.keymap.set("n", "<leader>fe", "<cmd>Commands!<CR>")
vim.keymap.set("n", "<leader>ft", "<cmd>Helptags!<CR>")

-- Git
local function open_github_pr()
  local remote =
    vim.trim(vim.fn.system("git remote get-url origin"))

  local branch =
    vim.trim(vim.fn.system("git branch --show-current"))

  local url =
    remote
      :gsub("^git@github.com:", "https://github.com/")
      :gsub("%.git$", "")

  local pr_url = url .. "/pull/new/" .. branch

  if vim.fn.has("macunix") == 1 then
    vim.fn.system("open " .. vim.fn.shellescape(pr_url))
  elseif vim.fn.has("unix") == 1 then
    vim.fn.system(
      "xdg-open "
        .. vim.fn.shellescape(pr_url)
        .. " >/dev/null 2>&1 &"
    )
  elseif vim.fn.has("win32") == 1 then
    vim.fn.system(
      'start "" ' .. vim.fn.shellescape(pr_url)
    )
  end

  print(pr_url)
end

local git_commit =
  vim.api.nvim_create_augroup(
    "git_commit",
    { clear = true }
  )

vim.api.nvim_create_autocmd(
  "FileType",
  {
    group = git_commit,
    pattern = "gitcommit",
    command = "startinsert",
  }
)

require('gitsigns').setup{
 signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  blame_formatter = nil, -- Use default
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

vim.keymap.set("n", "<leader>ge", "<cmd>Gitsigns nav_hunk next<CR>")
vim.keymap.set("n", "<leader>gs", "<cmd>Gitsigns nav_hunk prev<CR>")
vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk_inline<CR>")
vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>")
vim.keymap.set("n", "<leader>gq", "<cmd>Gitsigns setqflist all<CR>")
vim.keymap.set("n", "<leader>gx", "<cmd>Gitsigns toggle_deleted<CR>")
vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame<CR>")

vim.keymap.set("n", "<leader>gc", "<cmd>!git commit<CR>")
vim.keymap.set("n", "<leader>gC", "<cmd>!git commit --amend --no-edit<CR>")
vim.keymap.set("n", "<leader>ga", "<cmd>!git add .<CR>")
vim.keymap.set("n", "<leader>gp", "<cmd>!git push -u origin HEAD<CR>")
vim.keymap.set("n", "<leader>gf", "<cmd>!git push -u origin HEAD --force<CR>")

vim.keymap.set("n", "<leader>go", open_github_pr)
vim.keymap.set({'o', 'x'}, 'ih', '<Cmd>Gitsigns select_hunk<CR>')

-- Marks
vim.keymap.set('n', '<leader>tN', 'mN')
vim.keymap.set('n', '<leader>tn', '`N')
vim.keymap.set('n', '<leader>tE', 'mE')
vim.keymap.set('n', '<leader>te', '`E')
vim.keymap.set('n', '<leader>tI', 'mI')
vim.keymap.set('n', '<leader>ti', '`I')
vim.keymap.set('n', '<leader>tO', 'mO')
vim.keymap.set('n', '<leader>to', '`O')

-- Leap
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set('n',               'S', '<Plug>(leap-from-window)')
local leap = require("leap")
leap.opts.safe_labels = {}
leap.opts.labels = "setnriaofuplwyqjbmghdzxc"
leap.opts.max_phase_one_targets = 0
leap.opts.special_keys.next_group = "<space>"


-- LSP+TreeSitter
require("tree-sitter-manager").setup()
vim.api.nvim_create_autocmd('FileType', {
    callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.o.signcolumn = 'yes:1'
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            vim.o.complete = 'o,.,w,b,u'
            vim.o.completeopt = 'menu,menuone,popup,noinsert'
            vim.lsp.completion.enable(true, client.id, args.buf)
        end

      vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
    end
})

-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
vim.lsp.enable({'gopls'})
vim.lsp.enable({'dartls'})

vim.keymap.set('n', 'grd', vim.diagnostic.setqflist)
vim.keymap.set('n', '<leader>e', function()
    vim.cmd("normal! mo")
    vim.cmd("copen")
end)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }

    vim.keymap.set("n", "e", function()
  local ok = pcall(vim.cmd, "cnext")
  if not ok then
    vim.cmd("cfirst")
  end
  vim.cmd("copen")
    end, opts)

    vim.keymap.set("n", "s", function()
      local ok = pcall(vim.cmd, "cprev")
  if not ok then
    vim.cmd("clast")
  end
  vim.cmd("copen")
    end, opts)

    vim.keymap.set("n", "t", function()
      vim.cmd("cclose")
    end, opts)

    vim.keymap.set("n", "<CR>", function()
      vim.cmd("cclose")
    end, opts)

  end,
})

