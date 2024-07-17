local helper = require 'custom.personal.lua-helper-funcs'
local get_visual = helper.get_visual

local tex = {}
tex.in_mathzone = function()
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex.in_textzone = function()
  return not tex.in_mathzone()
end

return {
  s(
    { trig = "([%w%)%]%}])'", regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>^{<>}', { f(function(_, snip)
      return snip.captures[1]
    end), d(1, get_visual) }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = '([%w%)%]%}]);', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>_{<>}', { f(function(_, snip)
      return snip.captures[1]
    end), d(1, get_visual) }),
    { condition = tex.in_mathzone }
  ),
  -- Superscript and Subscript
  s(
    { trig = '([%w%)%]%}])__', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>^{<>}_{<>}', { f(function(_, snip)
      return snip.captures[1]
    end), i(1), i(2) }),
    { condition = tex.in_mathzone }
  ),
  -- snippet for pattern like z0->z_0
  s(
    { trig = '([%w%)%]%}])(%d)', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }),
    { condition = tex.in_mathzone }
  ),
  -- Eular Superscript e^{}
  s(
    { trig = "([^%a])e'", regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>e^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- i,j,k subscript
  s(
    { trig = '([%a%)%]%}])II', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t 'i',
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = '([%a%)%]%}])JJ', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t 'j',
    }),
    { condition = tex.in_mathzone }
  ),
  s(
    { trig = '([%a%)%]%}])KK', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t 'k',
    }),
    { condition = tex.in_mathzone }
  ),

  -- plugs Superscript
  s(
    { trig = '([%a%)%]%}])%+%+', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t '+',
    }),
    { condition = tex.in_mathzone }
  ),
  -- complementary Superscript
  s(
    { trig = '([%a%)%]%}])CC', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t '\\complement',
    }),
    { condition = tex.in_mathzone }
  ),
  -- CONJUGATE (STAR) SUPERSCRIPT SHORTCUT
  s(
    { trig = '([%a%)%]%}])%*%*', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      t '*',
    }),
    { condition = tex.in_mathzone }
  ),
  -- vector and matrix
  -- \mat is an user-defined macro
  -- you should define it like
  -- \newcommand{\mat}[1]{\begin{matrix}#1\end{matrix}}
  s(
    { trig = '([^%a])ve', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>\\vec{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- Default unit vector
  s(
    { trig = '([^%a])ue', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>\\unitvector_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- UNIT VECTOR WITH HAT, i.e. \uvec{}
  s(
    { trig = '([^%a])uv', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>\\uvec{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- MATRIX, i.e. \vec
  s(
    { trig = '([^%a])mat', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>\\mat{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- Common operators
  -- FRACTION
  s(
    { trig = '([^%a])fra', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>\\frac{<>}{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- ABSOLUTE VALUE
  s(
    { trig = '([^%a])abs', regTrig = true, wordTrig = false, snippetType = 'autosnippet' },
    fmta('<>\\abs{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- SQUARE ROOT
  s(
    { trig = '([^%\\])sqr', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>\\sqrt{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
  -- BINOMIAL SYMBOL
  s(
    { trig = '([^%\\])bnn', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>\\binom{<>}{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- LOGARITHM WITH BASE SUBSCRIPT
  s(
    { trig = '([^%a%\\])log', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>\\log_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  -- DERIVATIVE with denominator only
  -- s({trig = "([^%a])dV", wordTrig = false, regTrig = true, snippetType="autosnippet"},
  --   fmta(
  --     "<>\\dvOne{<>}",
  --     {
  --       f( function(_, snip) return snip.captures[1] end ),
  --       d(1, get_visual),
  --     }
  --   ),
  --   {condition = tex.in_mathzone}
  -- ),
  -- -- DERIVATIVE with numerator and denominator
  -- s({trig = "([^%a])dvv", wordTrig = false, regTrig = true, snippetType="autosnippet"},
  --   fmta(
  --     "<>\\dv{<>}{<>}",
  --     {
  --       f( function(_, snip) return snip.captures[1] end ),
  --       i(1),
  --       i(2)
  --     }
  --   ),
  --   {condition = tex.in_mathzone}
  -- ),
  -- -- DERIVATIVE with numerator, denominator, and higher-order argument
  -- s({trig = "([^%a])ddv", wordTrig = false, regTrig = true, snippetType="autosnippet"},
  --   fmta(
  --     "<>\\dvN{<>}{<>}{<>}",
  --     {
  --       f( function(_, snip) return snip.captures[1] end ),
  --       i(1),
  --       i(2),
  --       i(3),
  --     }
  --   ),
  --   {condition = tex.in_mathzone}
  -- ),
  -- -- PARTIAL DERIVATIVE with denominator only
  -- s({trig = "([^%a])pV", wordTrig = false, regTrig = true, snippetType="autosnippet"},
  --   fmta(
  --     "<>\\pdvOne{<>}",
  --     {
  --       f( function(_, snip) return snip.captures[1] end ),
  --       d(1, get_visual),
  --     }
  --   ),
  --   {condition = tex.in_mathzone}
  -- ),
  -- -- PARTIAL DERIVATIVE with numerator and denominator
  -- s({trig = "([^%a])pvv", wordTrig = false, regTrig = true, snippetType="autosnippet"},
  --   fmta(
  --     "<>\\pdv{<>}{<>}",
  --     {
  --       f( function(_, snip) return snip.captures[1] end ),
  --       i(1),
  --       i(2)
  --     }
  --   ),
  --   {condition = tex.in_mathzone}
  -- ),
  -- -- PARTIAL DERIVATIVE with numerator, denominator, and higher-order argument
  -- s({trig = "([^%a])ppv", wordTrig = false, regTrig = true, snippetType="autosnippet"},
  --   fmta(
  --     "<>\\pdvN{<>}{<>}{<>}",
  --     {
  --       f( function(_, snip) return snip.captures[1] end ),
  --       i(1),
  --       i(2),
  --       i(3),
  --     }
  --   ),
  --   {condition = tex.in_mathzone}
  -- ),
  -- Sum and Integration
  -- SUM with lower limit
  s(
    { trig = '([^%a])sM', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>\\sum_{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }),
    { condition = tex.in_mathzone }
  ),
  -- SUM with upper and lower limit
  s(
    { trig = '([^%a])smM', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>\\sum_{<>}^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- INTEGRAL with upper and lower limit
  s(
    { trig = '([^%a])intn', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>\\int_{<>}^{<>}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone }
  ),
  -- INTEGRAL from positive to negative infinity
  s(
    { trig = '([^%a])intf', wordTrig = false, regTrig = true, snippetType = 'autosnippet' },
    fmta('<>\\int_{\\infty}^{\\infty}', {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }),
    { condition = tex.in_mathzone }
  ),
  -- More Integration
  -- DIFFERENTIAL, i.e. \diff
  s({ trig = 'df', snippetType = 'autosnippet', priority = 2000 }, {
    t '\\diff',
  }, { condition = tex.in_mathzone }),
  -- BASIC INTEGRAL SYMBOL, i.e. \int
  s({ trig = 'in1', snippetType = 'autosnippet' }, {
    t '\\int',
  }, { condition = tex.in_mathzone }),
  -- DOUBLE INTEGRAL, i.e. \iint
  s({ trig = 'in2', snippetType = 'autosnippet' }, {
    t '\\iint',
  }, { condition = tex.in_mathzone }),
  -- TRIPLE INTEGRAL, i.e. \iiint
  s({ trig = 'in3', snippetType = 'autosnippet' }, {
    t '\\iiint',
  }, { condition = tex.in_mathzone }),
  -- CLOSED SINGLE INTEGRAL, i.e. \oint
  s({ trig = 'oi1', snippetType = 'autosnippet' }, {
    t '\\oint',
  }, { condition = tex.in_mathzone }),
  -- CLOSED DOUBLE INTEGRAL, i.e. \oiint
  s({ trig = 'oi2', snippetType = 'autosnippet' }, {
    t '\\oiint',
  }, { condition = tex.in_mathzone }),

  -- Laplace, Gradient, Curl and Deviergence
  -- GRADIENT OPERATOR, i.e. \grad
  s({ trig = 'GRA', snippetType = 'autosnippet' }, {
    t '\\grad ',
  }, { condition = tex.in_mathzone }),
  -- CURL OPERATOR, i.e. \curl
  s({ trig = 'CURL', snippetType = 'autosnippet' }, {
    t '\\curl ',
  }, { condition = tex.in_mathzone }),
  -- DIVERGENCE OPERATOR, i.e. \divergence
  s({ trig = 'DIV', snippetType = 'autosnippet' }, {
    t '\\div ',
  }, { condition = tex.in_mathzone }),
  -- LAPLACIAN OPERATOR, i.e. \laplacian
  s({ trig = 'LAA', snippetType = 'autosnippet' }, {
    t '\\laplacian ',
  }, { condition = tex.in_mathzone }),

  -- Miscellaneous
  -- PARALLEL SYMBOL, i.e. \parallel
  s({ trig = '||', snippetType = 'autosnippet' }, {
    t '\\parallel',
  }),
  -- CDOTS, i.e. \cdots
  s({ trig = 'cdo', snippetType = 'autosnippet' }, {
    t '\\cdots',
  }),
  -- LDOTS, i.e. \ldots
  s({ trig = 'ldo', snippetType = 'autosnippet' }, {
    t '\\ldots',
  }),
  -- -- EQUIV, i.e. \equiv
  -- s({ trig = "eqq", snippetType = "autosnippet" }, {
  --   t("\\equiv "),
  -- }),
  -- SETMINUS, i.e. \setminus
  -- s({ trig = "stm", snippetType = "autosnippet" }, {
  --   t("\\setminus "),
  -- }),
  -- SUBSET, i.e. \subset
  -- s({ trig = "sbb", snippetType = "autosnippet" }, {
  --   t("\\subset "),
  -- }),
  -- -- APPROX, i.e. \approx
  -- s({ trig = "px", snippetType = "autosnippet" }, {
  --   t("\\approx "),
  -- }, { condition = tex.in_mathzone }),
  -- -- PROPTO, i.e. \propto
  -- s({ trig = "pt", snippetType = "autosnippet" }, {
  --   t("\\propto "),
  -- }, { condition = tex.in_mathzone }),
  -- -- COLON, i.e. \colon
  -- s({ trig = "::", snippetType = "autosnippet" }, {
  --   t("\\colon "),
  -- }),
  -- IMPLIES, i.e. \implies
  s({ trig = '>>', snippetType = 'autosnippet' }, {
    t '\\implies ',
  }),
  -- DOT PRODUCT, i.e. \cdot
  s({ trig = ',.', snippetType = 'autosnippet' }, {
    t '\\cdot ',
  }),
  -- CROSS PRODUCT, i.e. \times
  s({ trig = 'xx', snippetType = 'autosnippet' }, {
    t '\\times ',
  }),
  --\\mathrm turn Roman typestyle for uppercase and lowercase
  --this snippet is for Roman style of subscript text
  s({ trig = 'tmr', wordTrig = false, snippetType = 'autosnippet' }, fmta('_\\mathrm{<>}', { d(1, get_visual) }), { condition = tex.in_mathzone }),
}
