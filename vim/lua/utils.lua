local utils = {}

-- System OS (Linux or macOS)
utils.OS = vim.env.NEOVIM_OS or "Linux"

-- System User
utils.USER = vim.fn.expand("$USER")

-- Return the relevant value based on the System OS
utils.get_by_os = function(linux, mac)
    if utils.OS == "Linux" then
      return linux
    elseif utils.OS == "macOS" then
      return mac
    else
      error(string.format("The System OS `%s` isn't valid", utils.OS))
    end
end

-- Prepend relative path with home/$USER/
utils.get_path_with_home = function(path)
    local linux_path = "/home/" .. utils.USER .. "/" .. path
    local mac_path = "~/" .. path
    return utils.get_by_os(linux_path, mac_path)
end

return utils
