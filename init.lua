require("core.plugins")
require("core.options")
require("core.keymaps")

local config_path = vim.fn.stdpath("config")
local current_config_path = config_path .. "/lua/config/machine_specific.lua"
if not vim.loop.fs_stat(current_config_path) then
  local current_config_file = io.open(current_config_path, "wb")
  local default_config_path = config_path .. "/default_config/_machine_specific_default.lua"
  local default_config_file = io.open(default_config_path, "rb")
  if default_config_file and current_config_file then
    local content = default_config_file:read("*all")
    current_config_file:write(content)
    io.close(default_config_file)
    io.close(current_config_file)
  end
end
require("config.machine_specific")
