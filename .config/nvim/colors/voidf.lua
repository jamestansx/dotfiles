vim.opt.background = "dark"
if vim.g.colors_name ~= nil then vim.cmd("hi clear") end
if vim.g.syntax_on == 1     then vim.cmd("syntax reset") end
vim.g.colors_name = "voidf"

local C = {
    bg0     = "#0d0c0c",
    bg      = "#171717",
    bg1     = "#1d1c19",
    fg      = "#cacad3",
    fg1     = "#c8c093",
    visual  = "#223249",

    red01   = "#6b0606",
    red0    = "#c03030",
    red     = "#f43838",
    red1    = "#e86262",
    yellow  = "#f4df30",
    aqua    = "#6a9589", -- hint
    teal0   = "#08272b",
    teal01  = "#00434d",
    teal    = "#678897", -- info
    blue    = "#96a6c8",
    grey0   = "#252528",
    grey01  = "#2e2e38",
    grey    = "#7a857a",
    grey1   = "#5a5a5a",
    grey2   = "#71767e",
    green0  = "#273621",
    green   = "#98cc6c",
    green1  = "#97dd88",
    orange  = "#c88c38",
    milky   = "#fcd283",
}

local hi = vim.api.nvim_set_hl

-- Basic Editor
hi(0, "ColorColumn",  { bg = C.grey0 })
hi(0, "Conceal",      { fg = C.grey2 })
hi(0, "CursorLine",   { bg = C.grey0 })
hi(0, "Directory",    { fg = C.blue })
hi(0, "DiffAdd",      { bg = C.green0 })
hi(0, "DiffChange",   { bg = C.teal0 })
hi(0, "DiffDelete",   { fg = C.red0 })
hi(0, "DiffText",     { bg = C.teal01 })
hi(0, "ErrorMsg",     { fg = C.red })
hi(0, "LineNr",       { fg = C.grey1 })
hi(0, "MatchParen",   { fg = C.milky, bold = true })
hi(0, "MsgArea",      { fg = C.fg })
hi(0, "Normal",       { bg = C.bg, fg = C.fg })
hi(0, "NormalFloat",  { bg = C.bg0, blend = 7 })
hi(0, "NonText",      { fg = C.grey1 })
hi(0, "FloatTitle",   { bg = C.bg0, blend = 7 })
hi(0, "StatusLine",   { bg = C.bg0, fg = C.fg1 })
hi(0, "Visual",       { bg = C.visual })
hi(0, "CurSearch",    { bg = C.milky, fg = C.bg, bold = true })
hi(0, "Search",       { bg = C.grey01 })
hi(0, "Pmenu",        { bg = C.bg1, fg = C.fg })
hi(0, "PmenuSel",     { bg = C.visual, fg = C.fg })
hi(0, "PmenuThumb",   { bg = C.grey0 })
hi(0, "TabLine",      { bg = C.bg0, fg = C.fg1 })
hi(0, "TabLineSel",   { bg = C.visual, fg = C.fg1 })
hi(0, "Title",        { fg = C.fg1 })
hi(0, "WarningMsg",   { fg = C.yellow })

-- Syntax
hi(0, "Comment",   { fg = C.grey })
hi(0, "Character", { link = "String" })
hi(0, "String",    { fg = C.green })

hi(0, "Ignore",    { fg = C.grey1 })
hi(0, "Error",     { bg = C.red01 })

hi(0, "Todo",      { fg = C.milky })

hi(0, "Added",     { fg = C.green1 })
hi(0, "Changed",   { fg = C.milky })
hi(0, "Removed",   { fg = C.red1 })

-- Diagnostic
-- hi(0, "DiagnosticOk",             { fg = C.ok })
hi(0, "DiagnosticError",          { fg = C.red })
hi(0, "DiagnosticInfo",           { fg = C.teal })
hi(0, "DiagnosticHint",           { fg = C.aqua })
hi(0, "DiagnosticWarn",           { fg = C.yellow })
-- hi(0, "DiagnosticUnderlineOk",    { sp = C.ok,     undercurl = true })
hi(0, "DiagnosticUnderlineError", { sp = C.red,    undercurl = true })
hi(0, "DiagnosticUnderlineInfo",  { sp = C.teal,   undercurl = true })
hi(0, "DiagnosticUnderlineHint",  { sp = C.aqua,   undercurl = true })
hi(0, "DiagnosticUnderlineWarn",  { sp = C.yellow, undercurl = true })

-- Treesitter
-- LSP

------------------------------------------------------------


hi(0, "Constant", {})       -- any constant
hi(0, "Number",   {})       -- a number constant: 234, 0xff
hi(0, "Boolean",  {})       -- a boolean constant: TRUE, false
hi(0, "Float",    {})       -- a floating point constant: 2.3e10

hi(0, "Identifier", {})     -- any variable name
hi(0, "Function",   {})     -- function name (also: methods for classes)

hi(0, "Statement",   {})    -- any statement
hi(0, "Conditional", { fg = C.fg1 })    -- if, then, else, endif, switch, etc.
hi(0, "Repeat",      {})    -- for, do, while, etc.
hi(0, "Label",       {})    -- case, default, etc.
hi(0, "Operator",    {})    -- "sizeof", "+", "*", etc.
hi(0, "Keyword",     { fg = C.fg1 })    -- any other keyword
hi(0, "Exception",   {})    -- try, catch, throw

hi(0, "PreProc",   {})      -- generic Preprocessor
hi(0, "Include",   {})      -- preprocessor #include
hi(0, "Define",    {})      -- preprocessor #define
hi(0, "Macro",     {})      -- same as Define
hi(0, "PreCondit", {})      -- preprocessor #if, #else, #endif, etc.

hi(0, "Type",         {})   -- int, long, char, etc.
hi(0, "StorageClass", {})   -- static, register, volatile, etc.
hi(0, "Structure",    {})   -- struct, union, enum, etc.
hi(0, "Typedef",      {})   -- a typedef

hi(0, "Special",        {}) -- any special symbol
hi(0, "SpecialChar",    {}) -- special character in a constant
hi(0, "Tag",            {}) -- you can use CTRL-] on this
hi(0, "Delimiter",      {}) -- character that needs attention
hi(0, "SpecialComment", {}) -- special things inside a comment
hi(0, "Debug",          {}) -- debugging statements


----

-- hi(0, "Identifier", { fg = C.blue })
-- hi(0, "Constant", { fg = C.blue })
-- hi(0, "Special", { fg = C.red0 })
-- hi(0, "Delimiter", { fg = C.red0 })
-- hi(0, "Keyword", { fg = C.orange })
-- hi(0, "Conditional", { fg = C.orange })
-- hi(0, "Statement", { fg = C.fg })
-- hi(0, "PreProc", { fg = C.grey5 })
-- hi(0, "Function", { fg = C.fg5 })
-- hi(0, "Function", { fg = C.fg })
-- hi(0, "Label", { fg = C.aqua })

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
