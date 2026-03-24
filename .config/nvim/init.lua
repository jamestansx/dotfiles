pcall(vim.loader.enable, true)

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

-- TODO: move to vim.pack
require("mini.deps").setup()

-- Not so important TODOs:
-- - multicursor/mini.align (multicursor is in the roadmap)
-- - dadbod (database plugin I really need)
-- - search n replace (wanna try grug-far)
-- - firenvim (for browser editing)
-- - dap.nvim (Do I do debugging in neovim or external UI?)
-- - harpoon (so far I don't find this plugin that useful)
