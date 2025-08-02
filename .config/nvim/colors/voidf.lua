vim.opt.background = "dark"
if vim.g.colors_name ~= nil then vim.cmd("hi clear") end
if vim.g.syntax_on == 1     then vim.cmd("syntax reset") end

vim.g.colors_name = "voidf"

-- (let ((gruber-darker-fg        "#e4e4ef")
-- (gruber-darker-fg+1      "#f4f4ff")
-- (gruber-darker-fg+2      "#f5f5f5")
-- (gruber-darker-white     "#ffffff")
-- (gruber-darker-black     "#000000")
-- (gruber-darker-bg-1      "#101010")
-- (gruber-darker-bg        "#181818")
-- (gruber-darker-bg+1      "#282828")
-- (gruber-darker-bg+2      "#453d41")
-- (gruber-darker-bg+3      "#484848")
-- (gruber-darker-bg+4      "#52494e")
-- (gruber-darker-red-1     "#c73c3f")
-- (gruber-darker-red       "#f43841")
-- (gruber-darker-red+1     "#ff4f58")
-- (gruber-darker-green     "#73c936")
-- (gruber-darker-yellow    "#ffdd33")
-- (gruber-darker-brown     "#cc8c3c")
-- (gruber-darker-quartz    "#95a99f")
-- (gruber-darker-niagara-2 "#303540")
-- (gruber-darker-niagara-1 "#565f73")
-- (gruber-darker-niagara   "#96a6c8")
-- (gruber-darker-wisteria  "#9e95c7")
-- )

local __color__ = {
    bg0     = "#0d0c0c",
    bg      = "#171717",
    fg      = "#cacad3",
    fg1     = "#c8c093",
    visual  = "#223249",

    red     = "#f43838",
    yellow  = "#f4df30",
    aqua    = "#6a9589", -- hint
    teal    = "#678897", -- info
    blue    = "#96a6c8",
    grey    = "#7a857a",
    green   = "#98cc6c",
    orange  = "#ff9e3b",

}


local C = {
    bg0    = "#0d0c0c",
    bg     = "#171717",
    bg1    = "#141414",
    bg2    = "#1d1c19",
    bg3    = "#282727",

    fg2    = "#d8d8d8",
    fg3    = "#c8c8c8",
    fg     = "#c5c9c5",
    fg1    = "#cdd6f4",
    fg5    = "#e8e8d3",
    fg6    = "#d3d3de",
    fg7    = "#cacad3",
    fg8    = "#c8c093",
    grey   = "#808080",
    grey2  = "#a6a69c",
    grey3  = "#9e9e9c",
    grey4 = "#6a6e76",
    comment = "#7A857A",
    visual = "#223249",
    red    = "#f43838",
    error = "#f43838",
    orange = "#ff9e3b",
    yellow = "#e9da24",
    warning = "#f4df30",
    green  = "#98cc6c",
    ok     = "#85dd3c",
    blue   = "#96a6c8",
    hint = "#6a9589",
    info = "#678897",
}

-- Highlight groups
local hi = vim.api.nvim_set_hl


hi(0, "Normal",      { bg = __color__.bg,  fg = __color__.fg })
hi(0, "NormalFloat", { bg = __color__.bg0, blend = 10 })
hi(0, "StatusLine",  { bg = __color__.bg0, fg = __color__.fg1 })
hi(0, "Visual",      { bg = __color__.visual })

-- hi(0, "Comment", { fg = __color__.grey })
hi(0, "Comment",   { fg = C.grey4 })
hi(0, "Directory", { fg = __color__.blue })
hi(0, "String",    { fg = __color__.green })

-- diagnostics
-- hi(0, "DiagnosticOk",             { fg = __color__.ok })
hi(0, "DiagnosticError",          { fg = __color__.red })
hi(0, "DiagnosticInfo",           { fg = __color__.teal })
hi(0, "DiagnosticHint",           { fg = __color__.aqua })
hi(0, "DiagnosticWarn",           { fg = __color__.yellow })
-- hi(0, "DiagnosticUnderlineOk",    { sp = __color__.ok,     undercurl = true })
hi(0, "DiagnosticUnderlineError", { sp = __color__.red,    undercurl = true })
hi(0, "DiagnosticUnderlineInfo",  { sp = __color__.teal,   undercurl = true })
hi(0, "DiagnosticUnderlineHint",  { sp = __color__.aqua,   undercurl = true })
hi(0, "DiagnosticUnderlineWarn",  { sp = __color__.yellow, undercurl = true })

------------------------------------------------------------

hi(0, "Identifier", { fg = C.blue })
hi(0, "Type", { link = "Normal" })

hi(0, "PreProc", { fg = C.grey2 })
hi(0, "Function", {})
hi(0, "Statement", { fg = C.orange })
hi(0, "DiffAdd", { bg = "#394f30", fg = C.fg7 })
hi(0, "DiffChange", {})
hi(0, "DiffText", { bg = "#4f4630", fg = C.fg7 })

hi(0, "CurSearch", { bg = C.bg, fg = "#fce094", reverse = true })

-- hi(0, "@variable", { fg = C.grey2 })
hi(0, "@variable", { link = "Normal" })


-- hl(0, "Normal", { fg = c.fg, bg = c.bg })
-- hl(0, "NormalFloat", { fg = c.fg, bg = c.bg_darker })
-- hl(0, "FloatBorder", { fg = c.fg, bg = c.bg })
-- hl(0, "NormalNC", { fg = c.fg, bg = c.bg }) -- Normal non current
-- hl(0, "NormalSB", { fg = c.fg, bg = c.bg_darker }) -- Normal text in side bar
-- hl(0, "Pmenu", { fg = c.fg, bg = c.bg_darker })
-- hl(0, "SignColumn", { fg = "NONE", bg = c.bg })
-- hl(0, "CursorLineNr", { fg = c.yellow, bg = "NONE", bold = true })
-- hl(0, "Statement", { fg = c.yellow, bg = "NONE", bold = true })
-- hl(0, "TelescopeSelection", { fg = c.fg, bg = c.gray, italic = true })
-- hl(0, "CursorLine", { fg = "NONE", bg = c.gray, italic = true })
-- hl(0, "StatusLine", { fg = c.fg, bg = c.gray, italic = true })
--
-- -- special words
-- hl(0, "Comment", { fg = c.brown, bg = "NONE", italic = true })
-- hl(0, "Special", { fg = c.fg, bg = "NONE", bold = true })
-- hl(0, "@variable", { fg = c.fg, bg = "NONE", italic = true })
-- hl(0, "Constant", { fg = c.fg, bg = "NONE", italic = true })
-- hl(0, "Function", { fg = c.fg, bg = "NONE", italic = true })
-- hl(0, "String", { fg = c.green, bg = "NONE", italic = true })
-- hl(0, "Identifier", { fg = c.fg, bg = "NONE", italic = true })
-- hl(0, "Title", { fg = c.yellow, bg = "NONE", bold = true })
-- hl(0, "Type", { fg = c.fg, bg = "NONE", bold = true })
--
-- -- diagnostics
-- hl(0, "DiagnosticError", { fg = c.red, bg = "NONE", bold = true })
-- hl(0, "DiagnosticWarn", { fg = c.yellow, bg = "NONE", bold = true })
-- hl(0, "DiagnosticHint", { fg = c.cyan, bg = "NONE", bold = true })


-- Terminal colors
vim.g.terminal_color_0 = ""
vim.g.terminal_color_1 = ""
vim.g.terminal_color_2 = ""
vim.g.terminal_color_3 = ""
vim.g.terminal_color_4 = ""
vim.g.terminal_color_5 = ""
vim.g.terminal_color_6 = ""
vim.g.terminal_color_9 = ""
vim.g.terminal_color_10 = ""
vim.g.terminal_color_11 = ""
vim.g.terminal_color_12 = ""
vim.g.terminal_color_13 = ""
vim.g.terminal_color_14 = ""
vim.g.terminal_color_15 = ""
