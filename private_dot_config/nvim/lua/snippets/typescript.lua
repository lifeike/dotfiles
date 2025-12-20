local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Interface
  s("int", {
    t("interface "), i(1, "Name"), t(" {"),
    t({"", "  "}), i(2),
    t({"", "}"})
  }),
  
  -- Type
  s("type", {
    t("type "), i(1, "Name"), t(" = "), i(2), t(";")
  }),
  
  -- Function with types
  s("tfn", {
    t("function "), i(1, "name"), t("("), i(2), t("): "), i(3, "void"), t(" {"),
    t({"", "  "}), i(4),
    t({"", "}"})
  }),
  
  -- Arrow function with types
  s("taf", {
    t("const "), i(1, "name"), t(" = ("), i(2), t("): "), i(3, "void"), t(" => {"),
    t({"", "  "}), i(4),
    t({"", "}"})
  }),
}