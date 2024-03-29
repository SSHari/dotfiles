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
                vim.notify("Failed to get " .. key .. " in module " .. table.module,
                           vim.log.levels.WARN)
            end

            return table
        end
    }
}

---@alias modname string
---@param opts modname | {[1]: modname, silent?: boolean}
--
-- Requires a module in protected mode and returns
-- a ProxyModule if the module can't be found. The
-- ProxyModule allows access to arbitrary fields to avoid errors.
utils.prequire = function(opts)
    local module = nil
    local silent = nil

    if type(opts) == "string" then
        module = opts
        silent = false
    elseif type(opts) == "table" then
        module = opts[1]
        silent = opts.silent or false
    else
        error(
            "Argument to utils.prequire should be a string or a table where the first property is a string and an optional silent property is a boolean")
    end

    vim.validate({module = {module, "string"}, silent = {silent, "boolean"}})

    local success, loaded_module = pcall(require, module)
    if success then return loaded_module end

    if not silent then vim.notify("Failed to load module " .. module, vim.log.levels.WARN) end

    return setmetatable({module = module, silent = silent}, ProxyModule.mt)
end

---@alias keymap_builder fun(mode: string|table, lhs: string, rhs: string|function, opts: table): nil
---@param options { config: function, build_keymaps: fun(builder: keymap_builder): nil }
---@return { config: function, packer_keymaps: Array<any> }
--
-- A function that returns a config for a packer managed plugin
-- keymap_builder takes the same arguments as vim.keymap.set
utils.build_module_wrapper = function(options)
    local packer_keymaps = {}
    local vim_keymaps = {}

    -- Store the keymaps for later
    options.build_keymaps(function(mode, lhs, rhs, opts)
        table.insert(packer_keymaps, {mode, lhs})
        table.insert(vim_keymaps, {mode, lhs, rhs, opts})
    end)

    return {
        config = function()
            if options.config then options.config() end

            -- Set keymaps from before
            for _, keymap in ipairs(vim_keymaps) do vim.keymap.set(unpack(keymap)) end
        end,
        packer_keymaps = packer_keymaps
    }
end

-- Check if an item is in a list
utils.list_includes = function(list, value_to_find)
    for _, value in ipairs(list) do if value == value_to_find then return true end end
    return false;
end

return utils
