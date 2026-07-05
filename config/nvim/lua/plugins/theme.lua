return {
    -- 1. 安装 Catppuccin (用于深色)
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },

    -- 2. 安装 Flexoki (用于浅色)
    {
        "kepano/flexoki-neovim",
        name = "flexoki",
        priority = 1000,
    },

    -- 3. 安装并配置 auto-dark-mode.nvim
    {
        "f-person/auto-dark-mode.nvim",
        opts = {
            update_interval = 1000, -- 检查系统主题的时间间隔（毫秒）
            set_dark_mode = function()
            vim.api.nvim_set_option_value("background", "dark", {})
            -- Catppuccin 需要先设置 flavor 再应用
            require("catppuccin").setup({ flavor = "mocha" })
            vim.cmd("colorscheme catppuccin")
            end,
            set_light_mode = function()
            vim.api.nvim_set_option_value("background", "light", {})
            vim.cmd("colorscheme flexoki")
            end,
        },
    },
}
