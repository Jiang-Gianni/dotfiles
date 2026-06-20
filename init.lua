local start_time = vim.uv.hrtime()

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local ms = (vim.uv.hrtime() - start_time) / 1e6
    vim.schedule(function()
      vim.notify(string.format("Startup time: %.2f ms", ms))
    end)
  end,
})

vim.loader.enable()
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
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    callback = function() vim.hl.on_yank() end,
})

_G.git_branch = function()
  local branch = vim.fn.systemlist("git branch --show-current 2>/dev/null")[1]
  if not branch or branch == "" then
    return ""
  end
  return "~ "..branch
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
vim.keymap.set("n", "<leader>nn", ":vertical resize +10<CR>")
vim.keymap.set("n", "<leader>ne", ":vertical resize -10<CR>")
vim.keymap.set("n", "<leader>ni", ":vs<CR>")
vim.keymap.set("n", "<leader>no", ":only<CR>")

vim.keymap.set("n", "<leader>as", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set('n', '<leader>=', function()
  local expr = vim.fn.getline('.')
  local ok, result = pcall(vim.fn.eval, expr)
  if ok then
    vim.fn.setline('.', tostring(result))
  else
    vim.notify("Invalid expression: " .. expr, vim.log.levels.ERROR)
  end
end)

vim.pack.add({
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/romus204/tree-sitter-manager.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://codeberg.org/andyg/leap.nvim",
  "https://github.com/nvim-mini/mini.surround",
})

-- vim.cmd.packadd('cfilter')
vim.cmd.packadd('nvim.difftool')
-- vim.cmd.packadd('nvim.tohtml')

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

require('mini.surround').setup({
    mappings = {
        add = 'ys',
        delete = 'ds',
        find = '',
        find_left = '',
        highlight = '',
        replace = 'cs',
        suffix_last = 'l',
        suffix_next = 'n',
    },
    search_method = 'cover_or_nearest',
}) 

vim.keymap.del('x', 'ys')
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

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
        preview = {
            wrap = true,
            vertical = "up:50%",
            horizontal = "right:50%",
            layout = "vertical",
            winopts = {
                cursorcolumn = true,
            }
        },
    },
    fzf_opts = {
        ["--layout"] = "default",
    },
    fzf_colors = {
        true,
      ["pointer"]     = { "fg", "FzfPointer" },
    },
    previewers = {
        git_diff = {
            cmd_deleted     = "git diff -w --word-diff=color HEAD --",
            cmd_modified    = "git diff -w --word-diff=color HEAD",
            cmd_untracked   = "git diff -w --word-diff=color --no-index /dev/null",
        }
    },
    git = {
        diff = {
            preview = "git diff -w --word-diff=color {ref} {file}",
        },
        commits = {
            cmd = [[git --no-pager log --oneline --no-patch --color=always --pretty=format:'%C(yellow)%h%Creset %s %C(blue)%an%Creset %C(green)%ar%Creset' ]],
            preview = "git --no-pager show -w --word-diff=color {1}",
            actions = {
                ["+"]  = { fn = actions.git_yank_commit, exec_silent = true },
            },
        },
        bcommits = {
            cmd = [[git --no-pager log --oneline --no-patch --color=always --pretty=format:'%C(yellow)%h%Creset %s %C(blue)%an%Creset %C(green)%ar%Creset' {file} ]],
            preview = "git --no-pager show -w --word-diff=color {1} -- {file}",
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

vim.keymap.set("n", "<leader>fw", function() fzf_lua.grep_cword() end)
vim.keymap.set("n", "<leader>fr", function() fzf_lua.live_grep() end)
vim.keymap.set("n", "<leader>fq", function() fzf_lua.quickfix_stack() end)
vim.keymap.set("n", "<leader>ff", function() fzf_lua.files() end)
vim.keymap.set("n", "<leader>fn", function() fzf_lua.resume() end)
vim.keymap.set("n", "<leader>fl", function() fzf_lua.blines() end)
vim.keymap.set("n", "<leader>fg", function() fzf_lua.git_status() end)
vim.keymap.set("n", "<leader>fb", function() fzf_lua.buffers() end)
vim.keymap.set("n", "<leader>fp", function() fzf_lua.keymaps() end)
vim.keymap.set("n", "<leader>fm", function() fzf_lua.manpages() end)
vim.keymap.set("n", "<leader>fh", function() fzf_lua.helptags() end)
vim.keymap.set("n", "<leader>fi", function() fzf_lua.commands() end)
vim.keymap.set("n", "<leader>fu", function() fzf_lua.undotree() end)

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
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-anywhere)')
vim.keymap.set({'n'}, 'l', function ()
  require('leap.remote').action()
end)
vim.keymap.set({'o'}, 'r', function()
  require('leap.treesitter').select {}
end)
local leap = require("leap")
leap.opts.safe_labels = {}
leap.opts.labels = "setnriaofuplwyqgvmcdxhzbjk1234567890SETNRIAOFUPLWYQGVMCDXHZBJK"
leap.opts.max_phase_one_targets = 0
leap.opts.special_keys.next_group = "<space>"


-- LSP+TreeSitter
require("tree-sitter-manager").setup()
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup("TreeSitterStart", { clear = true }),
    callback = function() pcall(vim.treesitter.start) end,
})

local format_ft = {
  go = true,
  typescript = true,
  dart = true,
  templ = true,
}

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup("LspAttach", { clear = true }),
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
    group = vim.api.nvim_create_augroup("LspGolang", { clear = true }),
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
vim.lsp.enable({'gopls', 'dartls', 'ts_ls', 'templ'})
vim.lsp.config['gopls'] = {
    name = "gopls",
    cmd = { "gopls" },
    filetypes = {"go", "gomod"},
    root_dir = vim.fs.root(0, { "go.mod", ".git" }),

    settings = {
        gopls = {
            analyses = { unusedparams = true,},
            staticcheck = true,
            gofumpt = true,
        },
    },
}
vim.lsp.config['dartls'] = {
    name = "dartls",
    cmd = { 'dart', 'language-server', '--protocol=lsp' },
    filetypes = { 'dart' },
    root_markers = { 'pubspec.yaml' },
    init_options = {
        onlyAnalyzeProjectsWithOpenFiles = true,
        suggestFromUnimportedLibraries = true,
        closingLabels = true,
        outline = true,
        flutterOutline = true,
    },
    settings = {
        dart = {
            completeFunctionCalls = true,
            showTodos = true,
        },
    },
}
vim.lsp.config['ts_ls'] = {
    name = "ts_ls",
    init_options = { hostInfo = 'neovim' },
    cmd = function(dispatchers, config)
        return vim.lsp.rpc.start({'typescript-language-server', '--stdio' }, dispatchers)
    end,
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
    },
    root_dir = function(bufnr, on_dir)
        local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock', '.git' }
        local project_root = vim.fs.root(bufnr, root_markers)
        on_dir(project_root or vim.fn.getcwd())
    end, 
}
vim.lsp.config['templ'] = {
    cmd = { 'templ', 'lsp' },
    filetypes = { 'templ' },
    root_markers = { 'go.work', 'go.mod', '.git' },
}

vim.diagnostic.config({
    virtual_text = true,
    underline = false,
})

vim.keymap.set("i", "qq", "<C-x><C-o>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', ':copen<CR>')
vim.keymap.set("n", "gd", function() fzf_lua.lsp_definitions() end)

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("QuickFixNav", { clear = true }),
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
    group = vim.api.nvim_create_augroup("RestoreLastMark", { clear = true }),
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.cmd("normal! zz")
        end
    end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("HelpPage", { clear = true }),
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
	group = vim.api.nvim_create_augroup("NoAutoComment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- show cursorline only in active window enable
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("ActiveCursorLine", { clear = true }),
	callback = function()
		vim.opt_local.cursorline = true
		vim.opt_local.cursorcolumn = true
	end,
})

-- show cursorline only in active window disable
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = "ActiveCursorLine",
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
		if vim.fn.mode() ~= "i" then
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local supports_highlight = false
			for _, client in ipairs(clients) do
				if client.server_capabilities.documentHighlightProvider then
					supports_highlight = true
					break
				end
			end
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
    group = vim.api.nvim_create_augroup("Snippets", { clear = true }),
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

-- https://github.com/niqodea/lasso.nvim/blob/main/lua/lasso/init.lua
local traker_hash = vim.fn.sha256(vim.fn.getcwd())
local marks_tracker_path = vim.fn.expand('~/.config/nvim/marks/'..traker_hash)
local marks_dir = vim.fn.fnamemodify(marks_tracker_path, ":h")
if vim.fn.isdirectory(marks_dir) == 0 then
    vim.fn.mkdir(marks_dir, "p")
end

local function get_marks_tracker_bufnr()
    local existing_marks_tracker_bufnr = vim.fn.bufnr(marks_tracker_path)
    if existing_marks_tracker_bufnr ~= -1 then
        return existing_marks_tracker_bufnr
    end

    local new_marks_tracker_bufnr = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(new_marks_tracker_bufnr, marks_tracker_path)
    vim.api.nvim_buf_call(new_marks_tracker_bufnr, vim.cmd.edit)

    return new_marks_tracker_bufnr
end

function open_marked_file(n)
    local marks_tracker_bufnr = get_marks_tracker_bufnr()

    local n_ = n - 1  -- zero-based numbering
    local lines = vim.api.nvim_buf_get_lines(marks_tracker_bufnr, n_, n_ + 1, false)

    if #lines == 0 then
        return
    end

    local file_path = lines[1]
    vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
end

local terminal_bufnrs = {}

function open_terminal(n)
    local bufnr = terminal_bufnrs[n]

    if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_win_set_buf(0, bufnr)
        return
    end

    vim.cmd('terminal')
    terminal_bufnrs[n] = vim.api.nvim_get_current_buf()
end

vim.keymap.set("n", "<leader>tl", function()
    local marks_tracker_bufnr = get_marks_tracker_bufnr()
    vim.api.nvim_win_set_buf(0, marks_tracker_bufnr)

end)

vim.keymap.set("n", "<leader>tt", function() 
    if vim.api.nvim_buf_get_option(0, 'buftype') ~= '' then
        error('The current buffer is not associated with a regular file')
    end

    local marks_tracker_bufnr = get_marks_tracker_bufnr()

    local buffer_name = vim.fn.expand('%')
    local file_path = vim.fn.fnamemodify(buffer_name, ':~:.')

    local lines = vim.api.nvim_buf_get_lines(marks_tracker_bufnr, 0, -1, false)
    for _, line in ipairs(lines) do
        if line == file_path then return end
    end

    local content = table.concat(lines, '\n')
    if content == '' then
        -- File is empty, set first line
        vim.api.nvim_buf_set_lines(marks_tracker_bufnr, 0, 1, false, {file_path})
    else
        -- Append to the file
        vim.api.nvim_buf_set_lines(marks_tracker_bufnr, -1, -1, false, {file_path})
    end
    vim.api.nvim_buf_call(marks_tracker_bufnr, function()
        vim.cmd("write")
    end)
end)

vim.keymap.set("n", "<leader>tn", function() open_marked_file(1) end)
vim.keymap.set("t", "<leader>tN", function() open_marked_file(1) end)
vim.keymap.set("n", "<leader>te", function() open_marked_file(2) end)
vim.keymap.set("t", "<leader>tE", function() open_marked_file(2) end)
vim.keymap.set("n", "<leader>ti", function() open_marked_file(3) end)
vim.keymap.set("t", "<leader>tI", function() open_marked_file(3) end)
vim.keymap.set("n", "<leader>to", function() open_marked_file(4) end)
vim.keymap.set("t", "<leader>tO", function() open_marked_file(4) end)

vim.keymap.set("n", "<leader>tm", function() open_terminal(1) end)
vim.keymap.set("n", "<leader>td", function() open_terminal(2) end)
vim.keymap.set("n", "<leader>th", function() open_terminal(3) end)
vim.keymap.set("n", "<leader>tb", function() open_terminal(4) end)

local argv = vim.fn.argv()
if #argv == 1 and string.sub(argv[1],1,3)=="oil" then
    open_marked_file(1)
end

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
})

-- SQL
local sql_current_connection = ""
local sql_connections_file = vim.fn.expand('~/.config/nvim/sql')

local function get_sql_connections_file_bufnr()
    local existing_bufnr = vim.fn.bufnr(sql_connections_file)
    if existing_bufnr ~= -1 then
        return existing_bufnr
    end

    local new_bufnr = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_buf_set_name(new_bufnr, sql_connections_file)
    vim.api.nvim_buf_call(new_bufnr, vim.cmd.edit)

    return new_bufnr
end

vim.keymap.set("n", "<leader>sl", function()
    vim.api.nvim_win_set_buf(0, get_sql_connections_file_bufnr())
end)

vim.api.nvim_create_user_command("FzfSQL", function(opts)
 local lines = {}
 for line in io.lines(sql_connections_file) do
     table.insert(lines, line)
  end
  fzf_lua.fzf_exec(lines, {
      prompt = "SQL", 
      fzf_opts = {
          ["--header"] = "Current connection: " .. sql_current_connection,
          ["--preview"] = [[
          sh -c '
          conn="$1"
          case "$conn"
          in postgres://*|postgresql://*)
              psql -d "$conn" -X -q -c "\dt+"
          ;;
          *)
              sqlite3 "$conn" ".schema"
          ;;
          esac
          ' sh {}
          ]]      },
      actions = {
          ["default"] = function(selected)
              sql_current_connection = selected[1]
          end,
      },
  })
end, { nargs = 0 })

vim.keymap.set("n", "<leader>sn", ":FzfSQL<CR>")

local function run_current_paragraph()
    local start = vim.fn.search("^$", "bnW") + 1
    local finish = vim.fn.search("^$", "nW") - 1

    if finish < start then
        finish = vim.fn.line("$")
    end

    local query = table.concat(
        vim.api.nvim_buf_get_lines(0, start - 1, finish, false),
        "\n"
    )

    local result = ""
    if string.sub(sql_current_connection,1,10)=="postgresql" then
    -- https://www.postgresql.org/docs/current/app-psql.html
    result = vim.fn.system(
        {
            "psql",
            "-d",
            sql_current_connection,
            "-X",
            "-q",
            -- "-E",
        },
        "\\timing on \n"..query
    )
    else
        -- https://sqlite.org/cli.html
     result = vim.fn.system(
            {
                "sqlite3",
                "-box",
                "-cmd",
                ".timer on",
                sql_current_connection,
            },
            query
        )
    end

    local output = vim.split(
        vim.trim(result),
        "\n",
        { plain = true }
    )

    vim.api.nvim_buf_set_lines(
        0,
        finish,  -- insert after paragraph
        finish,
        false,
        vim.list_extend(
            { ""},
            output
        )
    )
end

vim.keymap.set("n", "<leader>se", run_current_paragraph)

