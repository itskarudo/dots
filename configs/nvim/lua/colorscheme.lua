require("kanagawa").setup({
  undercurl = true,
  commentStyle = { italic = true },
  keywordStyle = { italic = true },
  theme = "dragon",
  overrides = function(colors)
    local theme = colors.theme
    local palette = colors.palette
    local skibidi_yellow = "#C0A36E"

    return {

      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = skibidi_yellow },
      BlinkCmpMenuBorder = { fg = "", bg = "" },

      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },

      IblIndent = { fg = "#1F1D1D" },
      IblScope = { fg = "#424040" },

      CursorLineNr = { fg = "#adada4", bg = "NONE" },
      LineNr = { fg = "#424040", bg = "NONE" },
      WinSeparator = { fg = "#282727", bg = "NONE" },
      NeoTreeNormal = { bg = "#100E0E", fg = "#adada4" },
      NeoTreeNormalNC = { bg = "#100E0E", fg = "#adada4" },
      NeoTreeCursorLine = { bg = "#181616" },
      NeoTreeWinSeparator = { bg = "#100E0E", fg = "#100E0E" },
      NeoTreeIndentMarker = { fg = "#222121" },
      NeoTreeGitModified = { fg = skibidi_yellow },

      BufferOffset = { bg = "#100E0E" },
      BufferCurrent = { bg = "#181616", fg = "#adada4" },
      BufferCurrentBtn = { bg = "#181616", fg = palette.dragonRed },
      BufferCurrentModBtn = { bg = "#181616", fg = "#8a9a7b" },
      BufferCurrentSign = { bg = "#181616", fg = "#181616" },
      BufferCurrentMod = { bg = "#181616" },
      BufferInactive = { bg = "#1F1D1D", fg = "#5e5c5c" },
      BufferInactiveSign = { bg = "#1F1D1D", fg = "#1F1D1D" },
      BufferInactiveMod = { bg = "#1F1D1D" },
      BufferVisible = { bg = "#1F1D1D", fg = "#5e5c5c" },
      BufferVisibleSign = { bg = "#1F1D1D", fg = "#1F1D1D" },
      BufferTabpageFill = { bg = "#1F1D1D" },

      TelescopeTitle = { fg = "#1F1D1D", bg = palette.dragonRed, bold = true },
      TelescopeResultsTitle = { fg = "#100E0E", bg = "#100E0E" },
      TelescopePromptNormal = { bg = "#1F1D1D" },
      TelescopePromptBorder = { fg = "#1F1D1D", bg = "#1F1D1D" },
      TelescopePromptPrefix = { fg = palette.dragonRed },
      TelescopeResultsNormal = { fg = "#adada4", bg = "#100E0E" },
      TelescopeSelection = { fg = "#adada4", bg = "#1F1D1D" },
      TelescopeResultsBorder = { fg = "#100E0E", bg = "#100E0E" },
      TelescopePreviewNormal = { bg = "#100E0E" },
      TelescopePreviewBorder = { bg = "#100E0E", fg = "#100E0E" },

      ErrorMsg = { fg = skibidi_yellow },
      WarningMsg = { fg = "#adada4" },
    }
  end,
  colors = {
    palette = {
      samuraiRed = "#c4746e",
      roninYellow = "#C0A36E",
    },
    theme = {
      dragon = {
        ui = {
          bg_gutter = "none",
          float = {
            bg = "none",
            bg_border = "none",
          },
        },
      },
    },
  },
})

vim.cmd("colorscheme kanagawa-dragon")
