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

-- Protected Require
local ProxyModule = {
    mt = {
        __call = function(table) return table end,
        __index = function(table, key)
            if not table.silent then
                vim.notify("Failed to get " .. key .. " in module " .. table.module)
            end

            return table
        end
    }
}

-- opts = { module = string, silent<optional> = boolean }
utils.prequire = function(opts)
    local module = opts.module
    local silent = opts.silent or false

    vim.validate({module = {module, "string"}, silent = {silent, "boolean"}})

    local success, loaded_module = pcall(require, module)
    if success then return loaded_module end

    if not silent then vim.notify("Failed to load module " .. module) end

    return setmetatable({module = module, silent = silent}, ProxyModule.mt)
end

return utils
