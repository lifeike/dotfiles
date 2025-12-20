local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Function
  s("def", {
    t("def "), i(1, "function_name"), t("("), i(2), t("):"),
    t({"", "    "}), i(3, "pass")
  }),
  
  -- Class
  s("class", {
    t("class "), i(1, "ClassName"), t(":"),
    t({"", "    def __init__(self"}), i(2), t({"):", "        "}), i(3, "pass")
  }),
  
  -- If main
  s("main", {
    t({"if __name__ == '__main__':", "    "}), i(1)
  }),
  
  -- Try except
  s("try", {
    t({"try:", "    "}), i(1),
    t({"", "except "}), i(2, "Exception"), t({" as e:", "    "}), i(3, "print(e)")
  }),
}