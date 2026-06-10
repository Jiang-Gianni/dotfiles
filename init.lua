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

vim.opt.inccommand = "split"
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

require('vim._core.ui2').enable()

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

vim.keymap.set('t', 'ww', [[<C-\><C-n>]])
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "<PageUp>", "<C-u>zz")
vim.keymap.set("n", "<PageDown>", "<C-d>zz")
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
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/mfussenegger/nvim-dap",
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
vim.cmd.packadd('nvim.tohtml')

require("tokyonight").setup()
vim.cmd.colorscheme("tokyonight-night")

vim.api.nvim_set_hl(0, "Folded", { fg = "#b0b0b0", bg = "NONE", bold=true })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })

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
local fzf_lua = require("fzf-lua")
local actions = fzf_lua.actions
local AQUA =  "#7ffff7"
vim.api.nvim_set_hl(0, "FzfPointer", {fg =AQUA,  bold = true})
vim.api.nvim_set_hl(0, "FzfLuaFzfPointer", {fg =AQUA,  bold = true})
fzf_lua.setup{
    files = {
        no_ignore = true,
        cwd_prompt = false,
    },
    winopts = {
        height = 1,
        width = 1,
        fullscreen = true,
    },
    fzf_opts = {
        ["--layout"] = "default",
    },
    fzf_colors = {
        true,
      ["pointer"]     = { "fg", "FzfPointer" },
    },
    git = {
        commits = {
            cmd = [[git --no-pager log --oneline --no-patch --color=always --pretty=format:'%C(yellow)%h%Creset %s %C(blue)%an%Creset %C(green)%ar%Creset' ]],
            preview = "git --no-pager show -w --word-diff --color=always {1}",
            actions = {
                ["+"]  = { fn = actions.git_yank_commit, exec_silent = true },
            },
        },
        bcommits = {
            cmd = [[git --no-pager log --oneline --no-patch --color=always --pretty=format:'%C(yellow)%h%Creset %s %C(blue)%an%Creset %C(green)%ar%Creset' {file} ]],
            preview = "git --no-pager show -w --word-diff --color=always {1} -- {file}",
            actions = {
                ["+"]  = { fn = actions.git_yank_commit, exec_silent = true },
            },
        },
        branches = {
            cmd = "git branch --color",
            preview = "git log -n 10 --date=iso --color=always --abbrev-commit --stat {1}",
            cmd_add = {"git", "switch", "-c"},
            actions = {
                ["-"]  = { fn = actions.git_branch_del, reload = true },
                ["+"]  = { fn = actions.git_branch_add, field_index = "{q}", reload = true },
            }
        }

    }
}

vim.api.nvim_create_user_command("Colors", function(opts) fzf_lua.colorschemes() end, {nargs = "*",})

vim.keymap.set("n", "<leader>fw", function() fzf_lua.grep_cword() end)
vim.keymap.set("n", "<leader>fr", function() fzf_lua.live_grep() end)
vim.keymap.set("n", "<leader>fq", function() fzf_lua.quickfix_stack() end)
vim.keymap.set("n", "<leader>ff", function() fzf_lua.files() end)
vim.keymap.set("n", "<leader>fl", function() fzf_lua.blines() end)
vim.keymap.set("n", "<leader>fg", function() fzf_lua.git_status() end)
vim.keymap.set("n", "<leader>fh", function() fzf_lua.history() end)
vim.keymap.set("n", "<leader>fb", function() fzf_lua.buffers() end)
vim.keymap.set("n", "<leader>fp", function() fzf_lua.keymaps() end)
vim.keymap.set("n", "<leader>fm", function() fzf_lua.manpages() end)
vim.keymap.set("n", "<leader>fi", function() fzf_lua.commands() end)

vim.keymap.set("n", "<leader>fe", function() fzf_lua.lsp_references() end)
vim.keymap.set("n", "<leader>fa", function() fzf_lua.lsp_code_actions() end)
vim.keymap.set("n", "<leader>fd", function() fzf_lua.lsp_document_diagnostics() end)

-- Git
local function open_url(url)
  if vim.fn.has("macunix") == 1 then
    vim.fn.system("open " .. vim.fn.shellescape(url))
  elseif vim.fn.has("unix") == 1 then
    vim.fn.system(
      "xdg-open "
        .. vim.fn.shellescape(url)
        .. " >/dev/null 2>&1 &"
    )
  elseif vim.fn.has("win32") == 1 then
    vim.fn.system(
      'start "" ' .. vim.fn.shellescape(url)
    )
  end
end

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
  open_url(pr_url)
  print(pr_url)
end

local function github_permalink()
    local file = vim.fn.expand("%")
    local api = vim.api

    local line = api.nvim_win_get_cursor(0)[1]

  local remote =
    vim.trim(vim.fn.system("git remote get-url origin"))
  local branch =
    vim.trim(vim.fn.system("git branch --show-current"))
  local repo_url =
    remote
      :gsub("^git@github.com:", "https://github.com/")
      :gsub("%.git$", "")


  local url = string.format('%s/blob/%s/%s#L%d', repo_url, branch, file, line)
  open_url(url)
  print(url)
end

require('gitsigns').setup({
    current_line_blame_opts = {
        ignore_whitespace = true,
    },
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        vim.keymap.set('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
            else
                gitsigns.nav_hunk('next')
            end
        end, {buffer=bufnr})

        vim.keymap.set('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
            else
                gitsigns.nav_hunk('prev')
            end
        end, {buffer=bufnr})

    end
})

vim.keymap.set("n", "<leader>gl", function() fzf_lua.git_commits() end)
vim.keymap.set("n", "<leader>gg", function() fzf_lua.git_branches() end)
vim.keymap.set("n", "<leader>gb", "<cmd>GitLineCommits<CR>")

vim.keymap.set("n", "<leader>gr", ":!git rebase origin/HEAD --update-refs<CR>")
vim.keymap.set("n", "<leader>gR", ":!git restore --source=origin/HEAD %<CR>")
vim.keymap.set("n", "<leader>gf", ":!git fetch origin main<CR>")
vim.keymap.set("n", "<leader>gc", ":!git commit -m \"\"<Left>")
vim.keymap.set("n", "<leader>gC", ":!git commit --amend --no-edit<CR>")
vim.keymap.set("n", "<leader>ga", ":!git add .<CR>")
vim.keymap.set("n", "<leader>gp", ":!git push -u origin HEAD<CR>")
vim.keymap.set("n", "<leader>gP", ":!git push -u origin HEAD --force-with-lease<CR>")

vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk_inline<CR>")
vim.keymap.set("n", "<leader>gx", ":Gitsigns toggle_deleted<CR>")
vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis origin/HEAD<CR>")
vim.keymap.set("n", "<leader>gb", ":lua require('gitsigns').blame_line({full=true})<CR>")
vim.keymap.set("n", "<leader>gB", ":Gitsigns blame<CR>")

vim.keymap.set("n", "<leader>go", open_github_pr)
vim.keymap.set("n", "<leader>gO", github_permalink)
vim.keymap.set({'o', 'x'}, 'ih', '<Cmd>Gitsigns select_hunk<CR>')

-- Leap
vim.api.nvim_set_hl(0, "LeapLabel", {fg =AQUA, bold = true})
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
  dart = true,
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

        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                if format_ft[vim.bo.filetype] then
                    vim.lsp.buf.format({ async = false })
                end
            end,
        })
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
vim.keymap.set('n', '<leader>e', ':copen<CR>')
vim.keymap.set("n", "gd", function() fzf_lua.lsp_definitions() end)

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

-- show cursorline only in active window enable
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
	callback = function()
		vim.opt_local.cursorline = true
		vim.opt_local.cursorcolumn = true
	end,
})

-- show cursorline only in active window disable
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = "active_cursorline",
	callback = function()
		vim.opt_local.cursorline = false
		vim.opt_local.cursorcolumn = false
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

-- Harpon
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>tt", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>tl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>tn", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>te", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>ti", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>to", function() harpoon:list():select(4) end)
local argv = vim.fn.argv()
if #argv == 1 and string.sub(argv[1],1,3)=="oil" then
    -- attempt to navigate to first buffer (last command of init.lua to apply triggers for syntax treesitter lsp etc...)
    harpoon:list():select(1)
end

