return {
  'L3MON4D3/LuaSnip',
  lazy = false,
  -- follow latest release.
  version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = 'make install_jsregexp',
  config = function()
    vim.cmd [[
      " Expand
      imap <silent><expr> <Tab> luasnip#expandable() ? '<Plug>luasnip-expand-snippet' : '<Tab>'

      " " Jump forward
      imap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'
      smap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'
      "
      " " Jump backward
      " imap <silent><expr> kj luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-j>'
      " smap <silent><expr> kj luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-j>'
      "
      " " Cycle forward through choice nodes with Control-F
      " imap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
      " smap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
    ]]

    -- --------------------------------------------- "
    local ls = require 'luasnip'
    s = ls.snippet
    sn = ls.snippet_node
    isn = ls.indent_snippet_node
    t = ls.text_node
    i = ls.insert_node
    f = ls.function_node
    c = ls.choice_node
    d = ls.dynamic_node
    r = ls.restore_node
    events = require 'luasnip.util.events'
    ai = require 'luasnip.nodes.absolute_indexer'
    fmt = require('luasnip.extras.fmt').fmt
    fmta = require('luasnip.extras.fmt').fmta
    m = require('luasnip.extras').m
    lambda = require('luasnip.extras').l
    postfix = require('luasnip.extras.postfix').postfix
    rep = require('luasnip.extras').rep

    -- require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})

    require('luasnip.loaders.from_lua').load { paths = { '~/.config/nvim/lua/lua_snippets/' } }
    vim.keymap.set(
      '',
      '<Leader>U',
      '<Cmd>lua require("luasnip.loaders.from_lua").lazy_load({paths = {"~/.config/nvim/lua/lua_snippets/"}})<CR><Cmd>echo "Snippets refreshed!"<CR>'
    )
  end,
}
