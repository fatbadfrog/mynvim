local helpers = require 'custom.personal.lua-helper-funcs'
local get_date = helpers.get_ISO_8601_date
local get_visual = helpers.get_visual

-- A logical OR of `line_begin` and the regTrig '[^%a]trig'
function line_begin_or_non_letter(line_to_cursor, matched_trigger)
  local line_begin = line_to_cursor:sub(1, -(#matched_trigger + 1)):match '^%s*$'
  local non_letter = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match '[ :`=%{%(%["]'
  return line_begin or non_letter
end

return {
  s({ trig = '(', wordTrig = false, snippetType = 'autosnippet' }, { t '(', d(1, get_visual), t ')' }),
  s({ trig = '[', wordTrig = false, snippetType = 'autosnippet' }, { t '[', d(1, get_visual), t ']' }),
  s({ trig = '{', wordTrig = false, snippetType = 'autosnippet' }, { t '{', d(1, get_visual), t '}' }),

  s(
    { trig = '"', wordTrig = false, snippetType = 'autosnippet', priority = 2000 },
    fmta('"<>"', { d(1, get_visual) }),
    { condition = line_begin_or_non_letter }
  ),
  s(
    { trig = "'", wordTrig = false, snippetType = 'autosnippet', priority = 2000 },
    fmta("'<>'", { d(1, get_visual) }),
    { condition = line_begin_or_non_letter }
  ),
  s({ trig = 'www', wordTrig = false, snippetType = 'autosnippet' }, { t 'loaded!' }),
}
