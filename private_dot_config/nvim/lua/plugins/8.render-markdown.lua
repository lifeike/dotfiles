return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    -- avoid double init if buffer reloads
    if vim.b.did_my_render_markdown then
      return
    end
    vim.b.did_my_render_markdown = true

    -- LSP
    vim.lsp.enable "marksman"

    require("render-markdown").setup {
      callout = {
        abstract = {
          raw = "[!ABSTRACT]",
          rendered = "󰯂 Abstract",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        summary = {
          raw = "[!SUMMARY]",
          rendered = "󰯂 Summary",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },
        tldr = {
          raw = "[!TLDR]",
          rendered = "󰦩 Tldr",
          highlight = "RenderMarkdownInfo",
          category = "obsidian",
        },

        failure = {
          raw = "[!FAILURE]",
          rendered = " Failure",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        fail = {
          raw = "[!FAIL]",
          rendered = " Fail",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        missing = {
          raw = "[!MISSING]",
          rendered = " Missing",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },

        attention = {
          raw = "[!ATTENTION]",
          rendered = " Attention",
          highlight = "RenderMarkdownWarn",
          category = "obsidian",
        },
        warning = {
          raw = "[!WARNING]",
          rendered = " Warning",
          highlight = "RenderMarkdownWarn",
          category = "github",
        },

        danger = {
          raw = "[!DANGER]",
          rendered = " Danger",
          highlight = "RenderMarkdownError",
          category = "obsidian",
        },
        error = { raw = "[!ERROR]", rendered = " Error", highlight = "RenderMarkdownError", category = "obsidian" },
        bug = { raw = "[!BUG]", rendered = " Bug", highlight = "RenderMarkdownError", category = "obsidian" },

        quote = { raw = "[!QUOTE]", rendered = " Quote", highlight = "RenderMarkdownQuote", category = "obsidian" },
        cite = { raw = "[!CITE]", rendered = " Cite", highlight = "RenderMarkdownQuote", category = "obsidian" },

        todo = { raw = "[!TODO]", rendered = " Todo", highlight = "RenderMarkdownInfo", category = "obsidian" },
        wip = { raw = "[!WIP]", rendered = "󰦖 WIP", highlight = "RenderMarkdownHint", category = "obsidian" },
        done = { raw = "[!DONE]", rendered = " Done", highlight = "RenderMarkdownSuccess", category = "obsidian" },
      },

      sign = { enabled = false },

      code = {
        width = "block",
        min_width = 80,
        border = "thin",
        left_pad = 1,
        right_pad = 1,
        position = "right",
        language_icon = true,
        language_name = true,
        highlight_inline = "RenderMarkdownCodeInfo",
      },

      heading = {
        icons = { " 󰼏 ", " 󰎨 ", " 󰼑 ", " 󰎲 ", " 󰼓 ", " 󰎴 " },
        border = true,
        render_modes = true,
      },

      checkbox = {
        unchecked = {
          icon = "󰄱",
          highlight = "RenderMarkdownCodeFallback",
          scope_highlight = "RenderMarkdownCodeFallback",
        },
        checked = { icon = "󰄵", highlight = "RenderMarkdownUnchecked", scope_highlight = "RenderMarkdownUnchecked" },

        custom = {
          question = {
            raw = "[?]",
            rendered = "",
            highlight = "RenderMarkdownError",
            scope_highlight = "RenderMarkdownError",
          },
          todo = {
            raw = "[>]",
            rendered = "󰦖",
            highlight = "RenderMarkdownInfo",
            scope_highlight = "RenderMarkdownInfo",
          },
          canceled = {
            raw = "[-]",
            rendered = "",
            highlight = "RenderMarkdownCodeFallback",
            scope_highlight = "@text.strike",
          },
          important = {
            raw = "[!]",
            rendered = "",
            highlight = "RenderMarkdownWarn",
            scope_highlight = "RenderMarkdownWarn",
          },
          favorite = {
            raw = "[~]",
            rendered = "",
            highlight = "RenderMarkdownMath",
            scope_highlight = "RenderMarkdownMath",
          },
        },
      },

      pipe_table = {
        alignment_indicator = "─",
        border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" },
      },

      link = {
        wiki = { icon = " ", highlight = "RenderMarkdownWikiLink", scope_highlight = "RenderMarkdownWikiLink" },
        image = " ",
        hyperlink = " ",
        custom = {
          github = { pattern = "github", icon = " " },
          gitlab = { pattern = "gitlab", icon = "󰮠 " },
          youtube = { pattern = "youtube", icon = " " },
          cern = { pattern = "cern.ch", icon = " " },
        },
      },

      anti_conceal = {
        ignore = {
          head_border = true,
          head_background = true,
        },
      },

      win_options = { concealcursor = { rendered = "vc" } },

      completions = {
        blink = { enabled = true },
        lsp = { enabled = true },
      },
    }

    -- buffer-local options
    vim.o.wrap = true
    vim.opt.conceallevel = 2

    -- gx: smart markdown link opener
    vim.keymap.set("n", "gx", function()
      local line = vim.fn.getline "."
      local col = vim.fn.col "."
      local pos = 1

      while pos <= #line do
        local ob, cb = line:find("%[", pos), nil
        if not ob then
          break
        end
        cb = line:find("%]", ob + 1)
        local op = cb and line:find("%(", cb + 1)
        local cp = op and line:find("%)", op + 1)
        if not (cb and op and cp) then
          break
        end

        if (col >= ob and col <= cb) or (col >= op and col <= cp) then
          vim.ui.open(line:sub(op + 1, cp - 1))
          return
        end
        pos = cp + 1
      end

      vim.cmd "normal! gx"
    end, { buffer = true, desc = "Markdown URL opener" })
  end,
}
