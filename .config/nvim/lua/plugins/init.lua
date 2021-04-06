vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
    -- basic
    use {"wbthomason/packer.nvim", opt = true}
    use "tpope/vim-repeat"
    use "tpope/vim-surround"
    use "tpope/vim-unimpaired"
    use {
        "terrortylor/nvim-comment",
        config = function() require("plugins.nvim-comment") end
    }

    -- additional functionality
    use {"phaazon/hop.nvim", config = function() require("plugins.hop") end}
    use {
        "windwp/nvim-autopairs",
        config = function() require("plugins.autopairs") end
    }
    use {
        "svermeulen/vim-subversive",
        config = function() require("plugins.subversive") end
    }
    use {
        "svermeulen/vim-cutlass",
        config = function() require("plugins.cutlass") end
    }
    use {"hrsh7th/vim-vsnip", config = function() require("plugins.vsnip") end}
    use {"hrsh7th/nvim-compe", config = function() require("plugins.compe") end}

    -- integrations
    use {
        "nvim-telescope/telescope.nvim",
        requires = {"nvim-lua/popup.nvim"},
        config = function() require("plugins.telescope") end
    }
    use {"christoomey/vim-tmux-navigator"}
    use {"mcchrish/nnn.vim", config = function() require("plugins.nnn") end}
    use {
        "christoomey/vim-tmux-runner",
        config = function() require("plugins.vtr") end
    }

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
    use "mg979/vim-visual-multi"

    -- development
    use "neovim/nvim-lspconfig"
    use "nvim-lua/plenary.nvim"
    use {
        "mfussenegger/nvim-dap",
        config = function() require("plugins.dap") end
    }
    use "jose-elias-alvarez/nvim-lsp-ts-utils/"
    use {
        "lewis6991/gitsigns.nvim",
        config = function() require("plugins.gitsigns") end
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function() require("plugins.treesitter") end
    }
    use {"windwp/nvim-ts-autotag", requires = "nvim-treesitter/nvim-treesitter"}
    use {
        "nvim-treesitter/playground",
        requires = "nvim-treesitter/nvim-treesitter"
    }
    use "sheerun/vim-polyglot"
    use {
        "vim-test/vim-test",
        config = function() require("plugins.vim-test") end
    }
    use {"tpope/vim-fugitive", cmd = {"Git", "Gvdiffsplit"}}

    -- visual
    use {
        "jose-elias-alvarez/buftabline.nvim",
        config = function() require("plugins.buftabline") end
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
    use "tridactyl/vim-tridactyl"
end)
