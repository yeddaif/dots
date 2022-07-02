local lspconfig = require "lspconfig"
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
   }
}

------[General LSp]------------
local servers = {'gopls','pyright',"clangd","bashls","sumneko_lua","html","cssls","tsserver" }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
------[Lua LSp]------------
lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' ,'use'},
      },
    },
  },
}

------[Php Lsp]------------
lspconfig.intelephense.setup{
  capabilities = capabilities,
  settings = {
    intelephense = {
      telemetry = {
        enabled = false,
      },
      completion = {
        fullyQualifyGlobalConstantsAndFunctions = true
      },
      phpdoc = {
        returnVoid = false,
      }
    },
  },
  root_dir = lspconfig.util.root_pattern('./*.php');
}

------[Javascript Lsp]------------
lspconfig.tsserver.setup{
    root_dir = lspconfig.util.root_pattern('*.js');
}

------[Go Lsp]------------
lspconfig.tsserver.setup{
    root_dir = lspconfig.util.root_pattern('*.go',"go.mod");
}

------[Bash Lsp]------------
lspconfig.bashls.setup{
  settings = {
    filetypes = { "sh","zsh","bash" }
      }
}

------[Emmet Lsp]------------
lspconfig.emmet_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less','php' },
})

------[Sql Lsp]------------
lspconfig.sqls.setup{
  cmd = {"/home/linus/.local/bin/sqls", "-config", "~/.config/nvim/mysqlconf.yml"};
}
