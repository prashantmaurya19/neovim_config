return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig["dartls"].setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        dart = {
          analysisexcludedfolders = {
            vim.fn.expand("$home/appdata/local/pub/cache"),
            vim.fn.expand("$home/.pub-cache"),
            vim.fn.expand("/opt/homebrew/"),
            vim.fn.expand("$home/flutter_home/flutter/"),
          },
          updateimportsonrename = true,
          completefunctioncalls = true,
          showtodos = true,
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
        handlers = {
          function(server_name) -- default handler (optional)
            lspconfig[server_name].setup({
              capabilities = cmp_nvim_lsp.default_capabilities(),
            })
          end,
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = cmp_nvim_lsp.default_capabilities(),
              settings = {
                lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          end,
          ["emmet_ls"] = function()
            -- local configs = require("lspconfig/configs")
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            lspconfig.emmet_ls.setup({
              capabilities = capabilities,
              filetypes = { "eruby", "html", "javascriptreact", "typescriptreact", "vue" },
              init_options = {
                html = {
                  options = {
                    -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                    ["bem.enabled"] = true,
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
