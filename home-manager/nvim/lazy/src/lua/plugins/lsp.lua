return {
  "neovim/nvim-lspconfig",
  opts = {
    -- LSP Server Settings
    ---@type lspconfig.options
    servers = {
      ansiblels = {},
      bashls = {},
      jsonls = {
        mason = false,
      },
      lua_ls = {
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      pylsp = {},
      rnix = {},
    },
  }
}
