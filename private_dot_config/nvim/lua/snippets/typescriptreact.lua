local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- React functional component
  s("rfc", {
    t({ "'use client'", "", "" }),
    t({ "import React from 'react'", "", "" }),
    t({ "interface Props {", "  " }), i(1, "// props here"),
    t({ "", "}", "", "" }),
    t({ "const " }), i(2, "ComponentName"), t({ ": React.FC<Props> = ({" }), i(3), t({ "}) => {", "" }),
    t({ "  return (", "    <div>" }),
    t({ "      " }), i(4, "content"),
    t({ "", "    </div>", "  )", "}", "", "export default " }), i(2), t({ "" }),
  }),
  
  -- Simple page component
  s("page", {
    t({ "'use client'", "", "" }),
    t({ "import React, { useState, useEffect } from 'react'", "", "" }),
    t({ "export default () => {", "", "  return (" }),
    t({ "    <div>" }),
    t({ "      " }), i(1, "pageName"),
    t({ "", "    </div>", "  )", "}" }),
  }),
  
  -- useState hook
  s("us", {
    t("const ["), i(1, "state"), t(", set"), i(2, "State"), t("] = useState("), i(3), t(");")
  }),
  
  -- useEffect hook
  s("ue", {
    t({ "useEffect(() => {", "  " }), i(1),
    t({ "", "}, [" }), i(2), t({ "]);" })
  }),
}
