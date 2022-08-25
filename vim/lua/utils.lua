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

-- Prepend relative path with /<prefix>/$USER/
utils.get_path_with_home = function(path)
    return utils.get_by_os("/home/", "/Users/") .. utils.USER .. "/" .. path
end

-- Execute the current lua file
utils.write_and_source = function()
    vim.api.nvim_command("w")
    vim.api.nvim_command("source %")
end

return utils
