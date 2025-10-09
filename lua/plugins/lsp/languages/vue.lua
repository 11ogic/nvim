-- Vue
-- Project DevDependencies: npm i -D vue-tsc
local M = {}

M.vue_language_server_path = vim.fn.stdpath("data") ..
    "/mason/packages/vue-language-server/node_modules/@vue/language-server"

M.setup = function(capabilities, on_attach)
  vim.lsp.config("vue_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
      vue = {
        hybridMode = false,
      }
    },
    settings = {
      typescript = {
        inlayHints = {
          enumMemberValues = {
            enabled = true,
          },
          functionLikeReturnTypes = {
            enabled = true,
          },
          propertyDeclarationTypes = {
            enabled = true,
          },
          parameterTypes = {
            enabled = true,
            suppressWhenArgumentMatchesName = true,
          },
          variableTypes = {
            enabled = true,
          },
        },
      },
    },
  })
end

return M
