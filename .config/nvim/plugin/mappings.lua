-- TODO: \v in searches for very magic
-- :h :DiffOrig

local map = vim.keymap.set

do -- https://github.com/mhinz/vim-galore#saner-command-line-history
    -- wildmenumode() ? <key> : <fallback>
    local nav_hist = function(key, fallback)
        return function()
            return vim.fn.wildmenumode() == 1 and key or fallback
        end
    end

    map("c", "<c-p>", nav_hist("<c-p>", "<up>"), { expr = true })
    map("c", "<c-n>", nav_hist("<c-n>", "<down>"), { expr = true })
end

-- center search result
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "*", "*zzzv")
map("n", "#", "#zzzv")

-- split (un-join) line
map("n", "gj", "i<c-j><esc>k$")

-- search within visual selection
map("x", "/", "<esc>/\\%V")
map("x", "?", "<esc>?\\%V")

-- TODO: join line remove spaces
map("n", "J", "mzJ`z")
map("n", "gJ", "mzgJ`z")
map("x", "<", "<gv")
map("x", ">", ">gv")

-- home row
map("", "H", "^")
map("", "L", "$")

do -- smart jk (wrap)
    -- v:count || mode(1)[0:1] == 'no' ? <key> : g<key>
    local mov = function(key)
        local gkey = "g" .. key
        return function()
            local count = vim.v.count > 0
            local mode = vim.fn.mode(1):sub(1,2) == "no"
            return (count or mode) and key or (vim.o.wrap and gkey or key)
        end
    end

    map({ "n", "x" }, "j", mov("j"), { expr = true })
    map({ "n", "x" }, "k", mov("k"), { expr = true })
end

-- select last inserted text
map("n", "gV", "`[v`]")

-- yank/paste/delete
map("x", "Y", '"+y')
map("x", "y", "zy")
map("n", "p", "zp")
map("n", "P", "zP")
map("x", "x", '"_d')

do -- block edit
    -- mode() =~ #'[vV]' ? '<c-v>^o^I' : 'I'
    -- mode() =~ #'[vV]' ? '<c-v>0o$A' : 'A'
    local block = function(key, bot, top)
        local bkey = ("<c-v>%so%s%s"):format(bot, top, key)
        return function()
            local mode = vim.fn.mode(1):sub(0,1):lower() == "v"
            return mode and bkey or key
        end
    end

    map("x", "I", block("I", "^", "^"), { expr = true })
    map("x", "A", block("A", "0", "$"), { expr = true })
end
