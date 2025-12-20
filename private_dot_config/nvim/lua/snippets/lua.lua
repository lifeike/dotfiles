local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Function
  s("fn", {
    t("function "), i(1, "name"), t("("), i(2), t(")"),
    t({"", "  "}), i(3),
    t({"", "end"})
  }),
  
  -- Local function
  s("lfn", {
    t("local function "), i(1, "name"), t("("), i(2), t(")"),
    t({"", "  "}), i(3),
    t({"", "end"})
  }),
  
  -- Module
  s("mod", {
    t({"local M = {}", "", ""}), i(1),
    t({"", "", "return M"})
  }),
  
  -- Require
  s("req", {
    t("local "), i(1, "name"), t(" = require('"), i(2), t("')")
  }),
}