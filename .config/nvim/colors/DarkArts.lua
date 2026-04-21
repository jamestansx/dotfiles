vim.cmd.highlight("clear")
vim.g.colors_name = "DarkArts"

vim.o.background = "dark"
if vim.g.syntax_on == 1 then
    vim.cmd.syntax("reset")
end

local hi = vim.api.nvim_set_hl

local C = {
    bg_float = "#0b0d0d",
    bg_bar   = "#1c1e1e",
    bg       = "#111113",

    fg_float = "#cacad3",
    fg_bar   = "#c8c093",
    fg       = "#bdbdc1",

    vis      = "#243143",
    sel      = "#1d2b40",
    vis      = "#1d2b40",
    comment  = "#919191",
    error    = "#f43838",
    warn     = "#f4df30",
    -- ok       = "#679788",
    ok       = "#57db5b",

    red      = "#dd777b",
    blue     = "#96a6c8",
    green    = "#95cb82",
    milk0    = "#d0a146",
    milk     = "#d9b268",
    greyx    = "#232325",
    grey0    = "#5a5a5a",
    grey     = "#7c7c78",
    orange0  = "#e5a72a",
    orange   = "#fcd283",
}

-- :help highlight-default
hi(0, "Normal",          { bg = C.bg, fg = C.fg })
hi(0, "NormalFloat",     { bg = C.bg_float, fg = C.fg_float, blend = 13 })
hi(0, "ColorColumn",     { bg = C.greyx })
hi(0, "CursorColumn",    { bg = C.greyx })
hi(0, "CursorLine",      { bg = C.greyx })
hi(0, "Directory",       { fg = C.blue })
hi(0, "OkMsg",           { fg = C.ok })

hi(0, "Title",           { bold = true })
hi(0, "StatusLine",      { bg = C.bg_bar, fg = C.fg_bar })
hi(0, "Visual",          { bg = C.vis })
hi(0, "TabLine",         { link = "StatusLine" })
hi(0, "TabLineSel",      { link = "Visual" })
hi(0, "MatchParen",      { fg = C.milk0, bold = true })
hi(0, "WarningMsg",      { fg = C.warn })
hi(0, "ErrorMsg",        { fg = C.error })
hi(0, "LineNr",          { fg = C.grey0 })

hi(0, "CurSearch",       { fg = C.orange, reverse = true, bold = true })
hi(0, "Search",          { fg = C.orange0, bold = true })

hi(0, "NonText",         { fg = C.grey })

hi(0, "Pmenu",           { bg = C.bg_bar })
hi(0, "PmenuSel",        { bg = C.sel })
hi(0, "PmenuThumb",      { bg = C.grey0 })

hi(0, "QuickFixLine",    { bg = C.sel })

-- :help group-name
hi(0, "Comment",         { fg = C.comment })
hi(0, "String",          { fg = C.green })
hi(0, "Statement",       { fg = C.milk0 })
hi(0, "Constant",        { bold = true })
hi(0, "Keyword",         { fg = C.milk0 })
hi(0, "Number",          {})
hi(0, "Function",        {})
hi(0, "Delimiter",       {})
hi(0, "Variable",        {})
hi(0, "Identifier",      {})
hi(0, "@variable",       {})
hi(0, "Special",         { fg = C.red })
hi(0, "Type",            { fg = C.blue })
hi(0, "PreProc",         {})

hi(0, "@type.builtin.c", { link = "Type" })

-- :help diagnostic-highlights

-- :help treesitter-highlight-groups

-- M.colors = {
-- 	fg = "#e4e4ef",
-- 	fg_1 = "#f4f4ff",
-- 	fg_2 = "#f5f5f5",
-- 	white = "#ffffff",
-- 	black = "#000000",
-- 	bg_m1 = "#101010",
-- 	bg = "#181818",
-- 	bg_1 = "#282828",
-- 	bg_2 = "#453d41",
-- 	bg_3 = "#484848",
-- 	bg_4 = "#52494e",
-- 	red_1 = "#c73c3f",
-- 	red = "#f43841",
-- 	red_1 = "#ff4f58",
-- 	green = "#73c936",
-- 	yellow = "#ffdd33",
-- 	brown = "#cc8c3c",
-- 	quartz = "#95a99f",
-- 	niagara_2 = "#303540",
-- 	niagara_1 = "#565f73",
-- 	niagara = "#96a6c8",
-- 	wisteria = "#9e95c7",
-- }


-- #ff9f0a
-- #f3c09a
