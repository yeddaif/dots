local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {"yaml","html","bash","go","javascript","python","css","php","typescript","lua","c"},
  sync_install = false,
  ignore_install = { "" }, 
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, 
    disable = { "" },
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
    autotag = {
    enable = true,
    filetypes = { "html" , "xml","php" },
  }
}
