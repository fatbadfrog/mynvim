local helpers = require 'custom.personal.lua-helper-funcs'
local get_visual = helpers.get_visual

-- Math context detection
local tex = {}
tex.in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex.in_text = function()
  return not tex.in_mathzone()
end

local line_begin = require('luasnip.extras.expand_conditions').line_begin

-- Return snippet tables
return {
  -- TYPEWRITER i.e. \texttt
  s(
    { trig = '([^%a])ttt', regTrig = true, wordTrig = false, snippetType = 'autosnippet', priority = 2000 },
    fmta('<>\\texttt{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_text }
  ),
  -- ITALIC i.e. \textit
  s(
    { trig = '([^%a])tit', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\textit{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- BOLD i.e. \textbf
  s(
    { trig = 'tbf', snippetType = 'autosnippet' },
    fmta('\\textbf{<>}', {
      d(1, get_visual),
    })
  ),
  -- MATH ROMAN i.e. \mathrm
  s(
    { trig = '([^%a])mrm', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\mathrm{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- MATH CALIGRAPHY i.e. \mathcal
  s(
    { trig = '([^%a])mca', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\mathcal{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- MATH BOLDFACE i.e. \mathbf
  s(
    { trig = '([^%a])mbf', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\mathbf{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- MATH BLACKBOARD i.e. \mathbb
  s(
    { trig = '([^%a])mbb', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\mathbb{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- REGULAR TEXT i.e. \text (in math environments)
  s(
    { trig = '([^%a])tee', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\text{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- Return snippet tab
  s({ trig = ';a', snippetType = 'autosnippet' }, {
    t '\\alpha',
  }),
  s({ trig = ';b', snippetType = 'autosnippet' }, {
    t '\\beta',
  }),
  s({ trig = ';g', snippetType = 'autosnippet' }, {
    t '\\gamma',
  }),
  s({ trig = ';G', snippetType = 'autosnippet' }, {
    t '\\Gamma',
  }),
  s({ trig = ';d', snippetType = 'autosnippet' }, {
    t '\\delta',
  }),
  s({ trig = ';D', snippetType = 'autosnippet' }, {
    t '\\Delta',
  }),
  s({ trig = ';e', snippetType = 'autosnippet' }, {
    t '\\epsilon',
  }),
  s({ trig = ';ve', snippetType = 'autosnippet' }, {
    t '\\varepsilon',
  }),
  s({ trig = ';z', snippetType = 'autosnippet' }, {
    t '\\zeta',
  }),
  s({ trig = ';h', snippetType = 'autosnippet' }, {
    t '\\eta',
  }),
  s({ trig = ';o', snippetType = 'autosnippet' }, {
    t '\\theta',
  }),
  s({ trig = ';vo', snippetType = 'autosnippet' }, {
    t '\\vartheta',
  }),
  s({ trig = ';O', snippetType = 'autosnippet' }, {
    t '\\Theta',
  }),
  s({ trig = ';k', snippetType = 'autosnippet' }, {
    t '\\kappa',
  }),
  s({ trig = ';l', snippetType = 'autosnippet' }, {
    t '\\lambda',
  }),
  s({ trig = ';L', snippetType = 'autosnippet' }, {
    t '\\Lambda',
  }),
  s({ trig = ';m', snippetType = 'autosnippet' }, {
    t '\\mu',
  }),
  s({ trig = ';n', snippetType = 'autosnippet' }, {
    t '\\nu',
  }),
  s({ trig = ';x', snippetType = 'autosnippet' }, {
    t '\\xi',
  }),
  s({ trig = ';X', snippetType = 'autosnippet' }, {
    t '\\Xi',
  }),
  s({ trig = ';i', snippetType = 'autosnippet' }, {
    t '\\pi',
  }),
  s({ trig = ';I', snippetType = 'autosnippet' }, {
    t '\\Pi',
  }),
  s({ trig = ';r', snippetType = 'autosnippet' }, {
    t '\\rho',
  }),
  s({ trig = ';s', snippetType = 'autosnippet' }, {
    t '\\sigma',
  }),
  s({ trig = ';S', snippetType = 'autosnippet' }, {
    t '\\Sigma',
  }),
  s({ trig = ';t', snippetType = 'autosnippet' }, {
    t '\\tau',
  }),
  s({ trig = ';f', snippetType = 'autosnippet' }, {
    t '\\phi',
  }),
  s({ trig = ';vf', snippetType = 'autosnippet' }, {
    t '\\varphi',
  }),
  s({ trig = ';F', snippetType = 'autosnippet' }, {
    t '\\Phi',
  }),
  s({ trig = ';c', snippetType = 'autosnippet' }, {
    t '\\chi',
  }),
  s({ trig = ';p', snippetType = 'autosnippet' }, {
    t '\\psi',
  }),
  s({ trig = ';P', snippetType = 'autosnippet' }, {
    t '\\Psi',
  }),
  s({ trig = ';w', snippetType = 'autosnippet' }, {
    t '\\omega',
  }),
  s({ trig = ';W', snippetType = 'autosnippet' }, {
    t '\\Omega',
  }),
}
