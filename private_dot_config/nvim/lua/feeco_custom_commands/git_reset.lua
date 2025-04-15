-- lua/user/deep_clean.lua
local M = {}

function M.setup()
  vim.api.nvim_create_user_command("FeecoGitReset", function()
    vim.fn.system("git reset --hard")
    vim.fn.system("git clean -fd")
    vim.cmd("e!") -- reload buffer
    vim.notify("✅ Deep clean complete", vim.log.levels.INFO)
  end, {
    desc = "Reset git changes and reload buffer",
  })
end

return M

