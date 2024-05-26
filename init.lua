require("htetmyat")

-- autocommands for jdtls
local jdtls_lsp = vim.api.nvim_create_augroup("JdtlsGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    require('jdtls_config.jdtls_setup').setup()
  end,
  group = jdtls_lsp,
  pattern = "java",
})
