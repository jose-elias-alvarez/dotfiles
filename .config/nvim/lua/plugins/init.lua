local u = require("utils")

local plugin_config = function(name)
    if u.config_file_exists("plugins/" .. name) then
        require("plugins." .. name)
    end
end

vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
    -- basic
    use {"wbthomason/packer.nvim", opt = true}
    use "tpope/vim-commentary"
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "tpope/vim-unimpaired"
    use "tpope/vim-eunuch"

    -- additional functionality
    use {"justinmk/vim-sneak", config = plugin_config("sneak")}
    use {"windwp/nvim-autopairs", config = plugin_config("autopairs")}
    use {"svermeulen/vim-subversive", config = plugin_config("subversive")}
    use {"svermeulen/vim-cutlass", config = plugin_config("cutlass")}
    use {"hrsh7th/vim-vsnip", config = plugin_config("vsnip")}
    use {"hrsh7th/nvim-compe", config = plugin_config("compe")}

    -- integrations
    use {
        "junegunn/fzf.vim",
        requires = {"junegunn/fzf"},
        run = function() vim.fn["fzf#install"]() end,
        config = plugin_config("fzf")
    }
    use {"christoomey/vim-tmux-navigator"}

    -- text objects
    use "wellle/targets.vim"
    use {"kana/vim-textobj-entire", requires = {"kana/vim-textobj-user"}}
    use {
        "beloglazov/vim-textobj-punctuation",
        requires = {"kana/vim-textobj-user"}
    }
    use {
        "Julian/vim-textobj-variable-segment",
        requires = {"kana/vim-textobj-user"}
    }
    use {
        "inside/vim-textobj-jsxattr",
        requires = {"kana/vim-textobj-user"},
        ft = {"javascriptreact", "typescriptreact"}
    }

    -- development
    use "neovim/nvim-lspconfig"
    use "nvim-lua/plenary.nvim"
    use {"mfussenegger/nvim-dap", config = plugin_config("dap")}
    use "~/git/nvim-lsp-ts-utils"
    use {
        "lewis6991/gitsigns.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = plugin_config("gitsigns")
    }
    use "sheerun/vim-polyglot"
    use {"vim-test/vim-test", config = plugin_config("vim-test")}
    use {"tpope/vim-fugitive", cmd = {"Git"}}

    -- visual
    use {
        "jose-elias-alvarez/buftabline.nvim",
        config = plugin_config("buftabline")
    }
    use "sainnhe/sonokai"
    use "challenger-deep-theme/vim"
    use "ghifarit53/tokyonight-vim"

    -- other
    use {
        "iamcco/markdown-preview.nvim",
        ft = {"md", "mkdn", "markdown"},
        config = {"vim.cmd[[doautocmd BufEnter]]"},
        run = "cd app && yarn install",
        cmd = "MarkdownPreview"
    }
end)
