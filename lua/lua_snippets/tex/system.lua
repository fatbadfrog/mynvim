local helper = require 'custom.personal.lua-helper-funcs'
local get_visual = helper.get_visual
local tex = {}
local line_begin = require('luasnip.extras.expand_conditions').line_begin
tex.in_tikz = function()
  local is_inside = vim.fn['vimtex#env#is_inside'] 'tikzpicture'
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
tex.in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
return {
  -- REFERENCE
  s(
    { trig = 'rff', snippetType = 'autosnippet', wordTrig = false },
    fmta([[\ref{<>}]], {
      d(1, get_visual),
    })
  ),
  -- DOCUMENTCLASS
  s(
    { trig = 'dcc', snippetType = 'autosnippet' },
    fmta(
      [[
        \documentclass[<>]{<>}
        ]],
      {
        i(1, 'a4paper'),
        i(2, 'article'),
      }
    ),
    { condition = line_begin }
  ),
  -- USE A LATEX PACKAGE
  s(
    { trig = 'pack', snippetType = 'autosnippet' },
    fmta(
      [[
        \usepackage{<>}
        ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),
  -- INPUT a LaTeX file
  s(
    { trig = 'inn', snippetType = 'autosnippet' },
    fmta(
      [[
      \input{<>}
      ]],
      {
        i(1),
      }
    ),
    { condition = line_begin }
  ),
  -- LABEL
  s(
    { trig = 'lbl', snippetType = 'autosnippet' },
    fmta(
      [[
      \label{<>}
      ]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- HPHANTOM
  -- s(
  --   { trig = "hpp", snippetType = "autosnippet" },
  --   fmta(
  --     [[
  --     \hphantom{<>}
  --     ]],
  --     {
  --       d(1, get_visual),
  --     }
  --   )
  -- ),
  -- s(
  --   { trig = "TODOO", snippetType = "autosnippet" },
  --   fmta([[\TODO{<>}]], {
  --     d(1, get_visual),
  --   })
  -- ),
  s(
    { trig = 'nc' },
    fmta([[\newcommand{<>}{<>}]], {
      i(1),
      i(2),
    }),
    { condition = line_begin }
  ),
  -- s(
  --   { trig = "sii", snippetType = "autosnippet" },
  --   fmta([[\si{<>}]], {
  --     i(1),
  --   })
  -- ),
  -- s(
  --   { trig = "qtt" },
  --   fmta([[\qty{<>}{<>}]], {
  --     i(1),
  --     i(2),
  --   })
  -- ),
  -- URL
  s(
    { trig = 'url' },
    fmta([[\url{<>}]], {
      d(1, get_visual),
    })
  ),
  -- href command with URL in visual selection
  s(
    { trig = 'LU', snippetType = 'autosnippet' },
    fmta([[\href{<>}{<>}]], {
      d(1, get_visual),
      i(2),
    })
  ),
  -- href command with text in visual selection
  s(
    { trig = 'LL', snippetType = 'autosnippet' },
    fmta([[\href{<>}{<>}]], {
      i(1),
      d(2, get_visual),
    })
  ),
  -- HSPACE
  s(
    { trig = 'hsp', snippetType = 'autosnippet' },
    fmta([[\hspace{<>}]], {
      d(1, get_visual),
    })
  ),
  -- VSPACE
  s(
    { trig = 'vsp', snippetType = 'autosnippet' },
    fmta([[\vspace{<>}]], {
      d(1, get_visual),
    })
  ),
  -- SECTION
  s(
    { trig = 'hs1', snippetType = 'autosnippet' },
    fmta([[\section{<>}]], {
      d(1, get_visual),
    })
  ),
  -- SUBSECTION
  s(
    { trig = 'hs2', snippetType = 'autosnippet' },
    fmta([[\subsection{<>}]], {
      d(1, get_visual),
    })
  ),
  -- SUBSUBSECTION
  s(
    { trig = 'hs3', snippetType = 'autosnippet' },
    fmta([[\subsubsection{<>}]], {
      d(1, get_visual),
    })
  ),
  s({ trig = 'qua' }, {
    t '\\quad ',
  }),
  s({ trig = 'qQ', snippetType = 'autosnippet' }, {
    t '\\qquad ',
  }),
  s({ trig = 'npa', snippetType = 'autosnippet' }, {
    t { '\\newpage', '' },
  }, { condition = line_begin }),
  s({ trig = 'which', snippetType = 'autosnippet' }, {
    t '\\text{ for which } ',
  }, { condition = tex.in_mathzone }),
  s({ trig = 'all', snippetType = 'autosnippet' }, {
    t '\\text{ for all } ',
  }, { condition = tex.in_mathzone }),
  s({ trig = 'and', snippetType = 'autosnippet' }, {
    t '\\quad \\text{and} \\quad',
  }, { condition = tex.in_mathzone }),
  s({ trig = 'forall', snippetType = 'autosnippet' }, {
    t '\\text{ for all } ',
  }, { condition = tex.in_mathzone }),
  -- s({ trig = "toc", snippetType = "autosnippet" }, {
  --   t("\\tableofcontents"),
  -- }, { condition = line_begin }),
  s({ trig = 'inff', snippetType = 'autosnippet' }, {
    t '\\infty',
  }),
  s({ trig = 'ii', snippetType = 'autosnippet' }, {
    t '\\item ',
  }, { condition = line_begin }),
  s({ trig = '--', snippetType = 'autosnippet' }, { t '% --------------------------------------------- %' }, { condition = line_begin }),
  -- HLINE WITH EXTRA VERTICAL SPACE
  s({ trig = 'hl' }, { t '\\hline {\\rule{0pt}{2.5ex}} \\hspace{-7pt}' }, { condition = line_begin }),
}
