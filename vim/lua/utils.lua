local utils = {}

-- System User
utils.USER = vim.fn.expand("$USER")

-- Prepend relative path with home/$USER/
utils.get_path_with_home = function(path)
    return "/home/" .. utils.USER .. "/" .. path
end

return utils
