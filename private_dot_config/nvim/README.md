## 0. `init.lua` is the entry file.
## 1. `lua/` 文件夹

这是存放所有 Lua 配置文件的主目录。

### `chadrc.lua`

这是主要的配置文件，通常用来加载和整合各个配置模块和插件。

---

## 2. `lua/configs/` 文件夹

这个文件夹用于存放各类配置文件，按功能模块划分。

### `conform.lua`

配置代码格式化工具，比如 `prettier`，用于自动格式化代码。

### `lazy.lua`

配置 `lazy.nvim` 插件的行为，包括插件的加载方式、默认设置等。

### `lspconfig.lua`

配置语言服务器（LSP），定义你想要使用的语言服务器和它们的选项。

### `luasnip.lua`

配置 `LuaSnip` 代码片段工具，包括片段定义和触发方式。

### `nvimtree.lua`

配置 `nvim-tree` 插件，用于管理和展示文件树。

---

## 3. `lua/feeco_custom_commands/` 文件夹

这是用来存放自定义命令的文件夹，比如你提到的 `git_reset.lua` 文件，可能是一个自定义的 Git 命令。

---

## 4. `lua/mappings.lua`

存放所有的键位映射配置，方便统一管理和调整。

---

## 5. `lua/options.lua`

定义各种 Neovim 的配置选项，比如界面、性能优化等。

---

## 6. `lua/plugins/` 文件夹

存放各个插件的配置文件，每个文件负责一个插件的配置。

### `aerial.lua`

配置 `aerial` 插件，用于代码大纲视图。

### `init.lua`

该文件夹的主配置文件，用于整合和调用所有插件配置。

### `luasnip.lua`

配置 `LuaSnip` 插件的细节。

### 其他插件配置文件

- `python-tool.lua`  
- `render-markdown.lua`  
- `typescrip-tool.lua`  
- `ty-python.lua`  

这些文件分别配置特定语言或工具的插件，比如 Python 支持、Markdown 渲染等。

---

## 7. `lua/snippets/` 文件夹

存放各种代码片段。

### `html.lua`

为 HTML 提供的代码片段。

### `typescriptreact.lua`

为 TypeScript React 提供的代码片段。

---

## 8. `.stylua.toml`

这是 Stylua 的配置文件，用于定义代码格式化的风格和规则。

---

## 总结

整个结构是为了让 Neovim 的配置更加模块化和清晰。  
每个文件和文件夹都有其明确的职责和用途，使配置过程更加高效、可维护、可扩展。
