require("htetmyat")

-- setting up jdtls for java file type.
local jdtls_lsp = vim.api.nvim_create_augroup("JdtlsGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		require('jdtls_config.jdtls_setup').setup()
	end,
	group = jdtls_lsp,
	pattern = "java",
})


-- templ auto regenerate command for templ lsp of golang
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.templ",
	callback = function()
		local output = vim.fn.system("templ generate " .. vim.fn.shellescape(vim.fn.expand('%:p')))
		if vim.v.shell_error ~= 0 then
			vim.notify("Templ generation failed: " .. output, vim.log.levels.ERROR)
		end
	end,
	group = vim.api.nvim_create_augroup("TemplGenerate", { clear = true })
})
