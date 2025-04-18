-- Start treesitter asynchronously
vim.schedule(function()
    if vim.treesitter.language.add("norg") then
        vim.treesitter.start()
    end
end)

vim.opt_local.conceallevel = 2
vim.opt_local.concealcursor = "nvc"
