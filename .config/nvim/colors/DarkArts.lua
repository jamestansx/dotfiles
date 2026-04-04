vim.cmd.highlight("clear")
vim.g.colors_name = "DarkArts"

vim.o.background = "dark"
if vim.g.syntax_on == 1 then
    vim.cmd.syntax("reset")
end

local hi = vim.api.nvim_set_hl

local C = {
    bg_float   = "#0b0d0d",
    bg_bar     = "#1c1e1e",
    bg         = "#111113",
    -- #0e1113

    fg         = "#bebebe",
    fg_bar     = "#c8c093",

    vis        = "#1d2b40",

    comment    = "#7c7d78",
    -- comment = "#b0b0b0",

    blue       = "#96a6c8",
    green      = "#95cb82",
    milk0      = "#d0a146",
    milk       = "#d9b268",

}

hi(0, "Normal",      { bg = C.bg, fg = C.fg })
hi(0, "NormalFloat", { bg = C.bg_float, blend = 10 })
hi(0, "Title",       { bold = true })
hi(0, "StatusLine", { bg = C.bg_bar, fg = C.fg_bar })
hi(0, "Visual", { bg = C.vis })
hi(0, "TabLine", { link = "StatusLine" })
hi(0, "TabLineSel", { link = "Visual" })
hi(0, "MatchParen", { fg = C.milk0, bold = true })
hi(0, "Directory", { fg = C.blue })

hi(0, "Pmenu",        { bg = C.bg_bar })
hi(0, "PmenuSel",     { bg = C.vis })
-- hi(0, "PmenuThumb",   { bg = C.grey0 })


hi(0, "Comment", { fg = C.comment })
hi(0, "String", { fg = C.green })
hi(0, "Statement", {})
hi(0, "Constant", {})
hi(0, "Keyword", { fg = C.milk })
hi(0, "Number", {})
hi(0, "Function", {})
hi(0, "Delimiter", {})
hi(0, "Variable", {})
hi(0, "Identifier", {})
hi(0, "@variable", {})
hi(0, "Special", {})
hi(0, "Type", {})
hi(0, "PreProc", {})

-- (setq ef-dream-palette-overrides
--       '((bg-main "#131015")
--         (bg-hl-line "#232224")
--         (fg-mode-line "#f2ddcf")
--         (bg-mode-line "#472b00")
--         (yellow-cooler "#ff9f0a")
--
--
-- (defconst ef-dream-palette-partial
-- '((cursor "#f3c09a")
--   (bg-main "#232025")
--   (bg-dim "#322f34")
--   (bg-alt "#3b393e")
--   (fg-main "#efd5c5")
--   (fg-dim "#8f8886")
--   (fg-alt "#b0a0cf")
--   (bg-active "#5b595e")
--   (bg-inactive "#3a373c")
--   (border "#635850")
--
--   (red "#ff6f6f")
--   (red-warmer "#ff7a5f")
--   (red-cooler "#e47980")
--   (red-faint "#f3a0a0")
--   (green "#51b04f")
--   (green-warmer "#7fce5f")
--   (green-cooler "#3fc489")
--   (green-faint "#a9c99f")
--   (yellow "#c0b24f")
--   (yellow-warmer "#d09950")
--   (yellow-cooler "#deb07a")
--   (yellow-faint "#caa89f")
--   (blue "#57b0ff")
--   (blue-warmer "#80aadf")
--   (blue-cooler "#12b4ff")
--   (blue-faint "#a0a0cf")
--   (magenta "#ffaacf")
--   (magenta-warmer "#f498c0")
--   (magenta-cooler "#d0b0ff")
--   (magenta-faint "#e3b0c0")
--   (cyan "#6fb3c0")
--   (cyan-warmer "#8fcfd0")
--   (cyan-cooler "#65c5a8")
--   (cyan-faint "#99bfcf")
--
--   (bg-red-intense "#a02f50")
--   (bg-green-intense "#30682f")
--   (bg-yellow-intense "#8f665f")
--   (bg-blue-intense "#4f509f")
--   (bg-magenta-intense "#885997")
--   (bg-cyan-intense "#0280b9")
--
--   (bg-red-subtle "#6f202a")
--   (bg-green-subtle "#2a532f")
--   (bg-yellow-subtle "#62432a")
--   (bg-blue-subtle "#3a3e73")
--   (bg-magenta-subtle "#66345a")
--   (bg-cyan-subtle "#334d69")
--
--   (bg-added "#304a4f")
--   (bg-added-faint "#16383f")
--   (bg-added-refine "#2f6767")
--   (fg-added "#a0d0f0")
--
--   (bg-changed "#51512f")
--   (bg-changed-faint "#40332f")
--   (bg-changed-refine "#64651f")
--   (fg-changed "#dada90")
--
--   (bg-removed "#5a3142")
--   (bg-removed-faint "#4a2034")
--   (bg-removed-refine "#782a4a")
--   (fg-removed "#f0bfcf")
--
--   (bg-mode-line-active "#675072")
--   (fg-mode-line-active "#fedeff")
--   (bg-completion "#503240")
--   (bg-popup "#2e2a31")
--   (bg-hover "#957856")
--   (bg-hover-secondary "#665f7a")
--   (bg-hl-line "#412f4f")
--   (bg-paren-match "#885566")
--   (bg-err "#501a2d") ; check with err
--   (bg-warning "#4e3930") ; check with warning
--   (bg-info "#0f3f4f") ; check with info
--   (bg-region "#544a50")))
