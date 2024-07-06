local home = os.getenv("HOME")

return {
  setup = function(lspconfig, lsp)
    lspconfig.volar.setup({
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
      init_options = {
        typescript = {
          tsdk = home .. "/.nvm/versions/node/v20.11.1/lib/node_modules/typescript/lib"
          -- Alternative location if installed as root:
          -- tsdk = '/usr/local/lib/node_modules/typescript/lib'
        },
      },
    })
  end
}
