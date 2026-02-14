-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.nwtrw_liststyle = 3
vim.g.netrw_banner = 0

-- Options
vim.opt.laststatus = 2
vim.opt.mouse = 'a'
vim.opt.showmode = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 10
vim.opt.hidden = true
vim.opt.showcmd = true
vim.opt.showbreak = '↪'
vim.opt.wrap = true
vim.opt.encoding = 'utf-8'
vim.opt.formatoptions = 'tcqrn1'
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.colorcolumn = '80'
vim.opt.signcolumn = 'auto'

vim.opt.smarttab = true
vim.opt.shiftwidth = 4

vim.opt.guicursor=""

vim.cmd("set path+=**")

vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/vimwiki/vimwiki' },
  --{ src = 'https://github.com/ggml-org/llama.vim' }
})

-- Vimwiki configuration -------------------------------------------------------

vim.g.vimwiki_list = {
  {
    path = '~/docs/wiki/',
    path_html = '~/proj/wiki/public/',
    template_path = '~/proj/wiki/templates/',
    template_default = 'page',
    template_ext = '.html',
    template_date_format = '%d-%m-%Y',
    css_name = 'style.css',
  }
}

-- Completion setup -----------------------------------------------------------

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
vim.cmd("set completeopt+=noselect")

-- Key mappings ---------------------------------------------------------------

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "gb", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gB", ":bprev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bl", ":buffers<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>el", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>ai", ":LlamaToggle<CR>", { noremap = true, silent = true }) -- Toggle model completion on/off

local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gtd", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gh", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

-- Language server setup -------------------------------------------------------

-- C
vim.lsp.enable('clangd')

-- Go
vim.lsp.enable('gopls')

-- LLM config -----------------------------------------------------------------

-- disable info-line
vim.cmd("let g:llama_config = { 'show_info': 0 }")

-- Language formatting --------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java,c,sh,ms,python",
  command = "setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go,make",
  command = "setlocal noexpandtab tabstop=8 shiftwidth=8 softtabstop=0",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "html,css,javascript,lua,markdown,yaml,toml",
  command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab",
})

vim.cmd('colorscheme quiet')
