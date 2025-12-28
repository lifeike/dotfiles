
local servers = {
  html = {},
  awk_ls = {},
  bashls = {},
  ty = {},
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end
