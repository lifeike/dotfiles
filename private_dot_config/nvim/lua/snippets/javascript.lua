local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Console log
  s("cl", {
    t("console.log("), i(1), t(");")
  }),
  
  -- Function
  s("fn", {
    t("function "), i(1, "name"), t("("), i(2), t(") {"),
    t({"", "  "}), i(3),
    t({"", "}"})
  }),
  
  -- Arrow function
  s("af", {
    t("const "), i(1, "name"), t(" = ("), i(2), t(") => {"),
    t({"", "  "}), i(3),
    t({"", "}"})
  }),
  
  -- Try catch
  s("try", {
    t({"try {", "  "}), i(1),
    t({"", "} catch (error) {", "  "}), i(2, "console.error(error);"),
    t({"", "}"})
  }),
}