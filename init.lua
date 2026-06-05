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
vim.opt.showbreak = "↪ "
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

vim.opt.diffopt = {
  "internal",
  "filler",
  "closeoff",
  "hiddenoff",
  "algorithm:histogram",
  "indent-heuristic",
  "iwhite",
  "iwhiteeol",
  "linematch:60",
  "inline:char",
  "followwrap",
}

vim.opt.grepprg = "rg --vimgrep --smart-case --follow"

vim.opt.path:append("**")
vim.opt.iskeyword:append("-")

vim.opt.updatetime = 100

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
  return branch
end

function _G.StatusFilename()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then return "[No Name]" end
  return vim.fn.fnamemodify(name, ":t")
end

function _G.first_error_location()
  local diags = vim.diagnostic.get(0, {
    severity = vim.diagnostic.severity.ERROR,
  })
  if #diags == 0 then
    return ""
  end
  local d = diags[1]
  -- line is 0-based, so add 1
  return "E"..string.format(":%d", d.lnum + 1)
end

vim.opt.statusline = table.concat({
  " %{mode()} ",
"%#DiagnosticError#%{v:lua.first_error_location()}%*",
  "%#StatusLine#",
    "%=",
  "%#PmenuSel#%f",
  "%m",
  "%#StatusLine#",
  " %{v:lua.git_branch()} ",
  "[%{get(b:,'gitsigns_status','')}]",
  "%=",
  "%y ",
  "%{&fileencoding?&fileencoding:&encoding} ",
  "%#StatusLine#",
  "(%l,%c) %{line('$')} %P",
})

vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "<PageUp>", "<PageUp>zz")
vim.keymap.set("n", "<PageDown>", "<PageDown>zz")
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
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/junegunn/fzf",
  "https://github.com/junegunn/fzf.vim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/romus204/tree-sitter-manager.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://codeberg.org/andyg/leap.nvim",
  "https://github.com/tpope/vim-commentary",
  "https://github.com/mbbill/undotree",
  "https://github.com/nvim-lua/plenary.nvim",
  {src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2"},
})

vim.cmd.packadd('cfilter')
-- vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('nvim.difftool')

require("tokyonight").setup()
vim.cmd.colorscheme("tokyonight-night")

require("oil").setup({
    view_options = {
        show_hidden = true,
    }
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

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
-- default Rg does not support flags -t / -g (I think)
vim.api.nvim_create_user_command("Rgg", function(opts)
  vim.fn["fzf#vim#grep"](
    "rg --line-number --column --color=always --smart-case " .. opts.args,
    1,
    vim.fn["fzf#vim#with_preview"]({
      options = {"--info=inline" },
      window = { width = 1, height = 1 }
    }),
    0
  )
  end,
  {nargs = "*",}
)

vim.api.nvim_create_user_command("Directories", function(opts)
  vim.fn["fzf#vim#grep"](
    'find . -type d ! -path "./.git/*" ! -path "*node_modules*" ' .. opts.args,
    1,
    vim.fn["fzf#vim#with_preview"]({
        sink = function(selected)
            if selected and selected ~= "" then
                -- normalize path (remove leading ./)
                local dir = selected:gsub("^%./", "")
                vim.cmd("Oil " .. vim.fn.fnameescape(dir))
            end
        end,
      options = {"--info=inline" },
      window = { width = 1, height = 1 }
    }),
    0
  )
  end,
  {nargs = "*",}
)

vim.keymap.set("n", "<leader>fw", ":Rgg  <C-r><C-w> ", { silent = false })
vim.keymap.set("n", "<leader>fr", "<cmd>Rg!<CR>")
vim.keymap.set("n", "<leader>fR", "<cmd>RG!<CR>")
vim.keymap.set("n", "<leader>fd", "<cmd>Directories<CR>")
vim.keymap.set("n", "<leader>ff", "<cmd>Files!<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>GFiles!?<CR>")
vim.keymap.set("n", "<leader>fC", "<cmd>Changes!<CR>")
vim.keymap.set("n", "<leader>fm", "<cmd>Marks!<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>History!<CR>")
vim.keymap.set("n", "<leader>fH", "<cmd>History:!<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Buffers!<CR>")
vim.keymap.set("n", "<leader>fp", "<cmd>Maps!<CR>")
vim.keymap.set("n", "<leader>fe", "<cmd>Commands!<CR>")
vim.keymap.set("n", "<leader>ft", "<cmd>Helptags!<CR>")

-- Git
vim.api.nvim_create_user_command("GitJumpDiff", function(opts)
  vim.fn["fzf#vim#grep"](
    "git jump --stdout diff $(git merge-base HEAD main)" .. opts.args,
    1,
    vim.fn["fzf#vim#with_preview"]({
      options = {"--info=inline" },
      window = { width = 1, height = 1 }
    }),
    0
  )
  end,
  {nargs = "*",}
)

local GIT_LOG = "git --no-pager log --oneline --no-patch --color=always --pretty=format:'%C(yellow)%h%Creset %s %C(blue)%an%Creset %C(green)%ar%Creset' "

function fzf_git_show(git_log_extra)
    vim.fn["fzf#vim#grep"](
        GIT_LOG..git_log_extra,
        1,
        vim.fn["fzf#wrap"]({
            sink = function (selected)
                vim.cmd("tabnew")
                local hash = string.match(selected, "^[^ ]+")
                vim.cmd("read !git --no-pager show --unified=5 --stat " .. hash)
                vim.cmd("normal! ggdd")
                vim.bo.filetype = "git"
                vim.bo.buftype = "nofile"
                vim.bo.bufhidden = "wipe"
                vim.bo.swapfile = false
                vim.bo.modified = false
            end,
            options = {
                "--info=inline",
                '--preview=echo {1} | cut -d" " -f1 | xargs git --no-pager show -w --word-diff --color=always',
                "--prompt=GitShow>",
            },
            window = { width = 1, height = 1 }
        }),
        0
    )
end

-- https://nrk.neocities.org/articles/vim-gitlog
vim.api.nvim_create_user_command("GitCommits", function(opts) fzf_git_show('') end, {nargs = "*"})
vim.api.nvim_create_user_command("GitFileCommits", function(opts) fzf_git_show(vim.fn.expand("%")) end, {nargs = "*"})

-- ":GitLineCommits N,M" to git log on current file from (current line - N) to (current line + M)
vim.api.nvim_create_user_command("GitLineCommits", function(opts)
    local file = vim.fn.expand("%")
    local line = vim.fn.line(".")
    local up = tonumber(opts.fargs[1]) or 0
    local down = tonumber(opts.fargs[2]) or 0
    local start_line = math.max(1, line - up)
    local end_line = line + down
    fzf_git_show(" -L "..start_line..","..end_line..":"..file)
end, {nargs = "*",})


vim.api.nvim_create_user_command("GitSwitch", function(opts)
  local branch =
    vim.trim(vim.fn.system("git branch --show-current"))
    vim.fn["fzf#vim#grep"](
        [[git branch | grep --invert-match '\*' | cut -c 3- ]],
        1,
        vim.fn["fzf#wrap"]({
            sink = function (selected)
                vim.cmd("!git switch "..selected)
            end,
            options = {
                "--info=inline",
                '--preview=git log --date=iso --color=always {}',
                "--header=* "..branch,
                "--prompt=GitSwitch>",
            },
            window = { width = 1, height = 1 }
        }),
        0
    )
end, {nargs = "*",})

vim.api.nvim_create_user_command("GitBranchDelete", function(opts)
  local branch =
    vim.trim(vim.fn.system("git branch --show-current"))
    vim.fn["fzf#vim#grep"](
        [[git branch | grep --invert-match '\*' | cut -c 3- ]],
        1,
        vim.fn["fzf#wrap"]({
            sink = function (selected)
                vim.cmd("!git branch -D "..selected)
            end,
            options = {
                "--info=inline",
                '--preview=git log --date=iso --color=always {}',
                "--header=* "..branch,
                "--prompt=GitBranchDelete>",
            },
            window = { width = 1, height = 1 }
        }),
        0
    )
end, {nargs = "*",})

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

require('gitsigns').setup{}

vim.keymap.set("n", "<leader>gs", ":GitSwitch<CR>")
vim.keymap.set("n", "<leader>gS", ":!git switch -c ")
vim.keymap.set("n", "<leader>gD", ":GitBranchDelete<CR>")
vim.keymap.set("n", "<leader>gr", ":!git rebase main")
vim.keymap.set("n", "<leader>gR", ":!git restore --source=main %<CR>")
vim.keymap.set("n", "<leader>gu", ":!git pull")
vim.keymap.set("n", "<leader>gc", ":!git commit -m \"\"<Left>")
vim.keymap.set("n", "<leader>gC", "<cmd>!git commit --amend --no-edit<CR>")
vim.keymap.set("n", "<leader>ga", "<cmd>!git add .<CR>")
vim.keymap.set("n", "<leader>gp", "<cmd>!git push -u origin HEAD<CR>")
vim.keymap.set("n", "<leader>gP", "<cmd>!git push -u origin HEAD --force<CR>")

vim.keymap.set("n", "<leader>gj", ":GitJumpDiff<CR>", { silent = false })
vim.keymap.set("n", "<leader>gl", "<cmd>GitCommits<CR>")
vim.keymap.set("n", "<leader>gf", "<cmd>GitFileCommits<CR>")
vim.keymap.set("n", "<leader>gb", "<cmd>GitLineCommits<CR>")

vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk_inline<CR>")
vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis main<CR>")
vim.keymap.set("n", "<leader>gx", "<cmd>Gitsigns toggle_deleted<CR>")

vim.keymap.set("n", "<leader>go", open_github_pr)
vim.keymap.set({'o', 'x'}, 'ih', '<Cmd>Gitsigns select_hunk<CR>')

-- Harpon
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>tt", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>tl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>tn", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>te", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>ti", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>to", function() harpoon:list():select(4) end)

-- Leap
vim.api.nvim_set_hl(0, "LeapLabel", {fg = "#7fffd4", bold = true})
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set('n',               'S', '<Plug>(leap-from-window)')
vim.keymap.set({'n'}, 'l', function ()
  require('leap.remote').action()
end)
vim.keymap.set({'o'}, 'r', function()
  require('leap.treesitter').select {}
end)
local leap = require("leap")
leap.opts.safe_labels = {}
leap.opts.labels = "setnriaofuplwyqgvmcdxhzbjk"
leap.opts.max_phase_one_targets = 0
leap.opts.special_keys.next_group = "<space>"


-- LSP+TreeSitter
require("tree-sitter-manager").setup()
vim.api.nvim_create_autocmd('FileType', {
    callback = function() pcall(vim.treesitter.start) end,
})

local format_ft = {
  go = true,
  typescript = true,
}

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.o.signcolumn = 'yes:1'
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            vim.o.complete = 'o'
            vim.o.completeopt = 'menu,menuone,noselect'
            vim.lsp.completion.enable(true, client.id, args.buf)
        end

        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    if format_ft[vim.bo.filetype] then
                        vim.lsp.buf.format({ async = false })
                    end
                end,
            })
        end
    end
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)

    for _, res in pairs(result or {}) do
      for _, action in pairs(res.result or {}) do
        if action.edit then
          vim.lsp.util.apply_workspace_edit(action.edit, "utf-16")
        elseif action.command then
          vim.lsp.buf.execute_command(action.command)
        end
      end
    end

  end,
})

-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
vim.lsp.enable({'gopls', 'dartls', 'ts_ls'})

vim.keymap.set("i", "qq", "<C-x><C-o>", { noremap = true, silent = true })
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

-- https://gist.github.com/smnatale/692ac4f256d5f19fbcbb78fe32c87604
-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.txt", -- help files are treated as text buffers
  callback = function(args)
    if vim.bo[args.buf].filetype == "help" then
      vim.cmd("wincmd L")
    end
  end,
})
-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMoved", {
	group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
	desc = "Highlight references under cursor",
	callback = function()
		-- Only run if the cursor is not in insert mode
		if vim.fn.mode() ~= "i" then
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local supports_highlight = false
			for _, client in ipairs(clients) do
				if client.server_capabilities.documentHighlightProvider then
					supports_highlight = true
					break -- Found a supporting client, no need to check others
				end
			end

			-- 3. Proceed only if an LSP is active AND supports the feature
			if supports_highlight then
				vim.lsp.buf.clear_references()
				vim.lsp.buf.document_highlight()
			end
		end
	end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("InsertEnter", {
	group = "LspReferenceHighlight",
	desc = "Clear highlights when entering insert mode",
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})

-- SNIPPETS in insert mode
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
      
      vim.keymap.set("i", "frnn", function()
          local snippet = [[if err != nil {
              return fmt.Errorf(": %w", err)
          }]]
          vim.api.nvim_put(vim.split(snippet, "\n"), "c", true, true)
          vim.cmd('normal! k0f"la') -- position to ..Errorf("<CURSOR>: %w, err)
      end, {buffer = true})

  end,
})
