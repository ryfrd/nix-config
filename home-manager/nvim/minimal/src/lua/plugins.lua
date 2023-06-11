-- ensure packer is installed 
local ensure_packer = function()
    local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	-- icons
	use {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup{}
        end
    }

	-- lualine
	use {
		'nvim-lualine/lualine.nvim',
        event = 'VimEnter',
        config = function()
            require('lualine').setup {
	            options = {
                    icons_enabled = true,

		            component_separators = '',
		            section_separators = ''
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
            }
        end
	}

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',
            'sharkdp/fd',
        },
        config = function()
            require('telescope').setup{
                defaults = {
                    layout_config = {
                        anchor = "N",
                        width = 0.5,
                    },
                    layout_strategy = 'center',
                },
                file_browser = {
                    hijack_netrw = true,
                },
            }
       end
    }

    -- telescope fb
    use {
	    'nvim-telescope/telescope-file-browser.nvim',
	    requires = {
		    "nvim-telescope/telescope.nvim",
		    'nvim-lua/plenary.nvim'
	    }, 
	    config = function()
		    require("telescope").load_extension "file_browser"
	    end
    }

    -- treesitter
    use {
       'nvim-treesitter/nvim-treesitter',
       config = function()
	  require'nvim-treesitter.configs'.setup {
	     ensure_installed = {
	     },
	     sync_install = false,
	     auto_install = true,
	     highlight = { enable = true, },
	  }
       end
    }

    -- base16 schemes
    -- also used to generate scheme
    use 'RRethy/nvim-base16'

    -- comment helper
    use {
	    'numToStr/Comment.nvim',
	    config = function()
		    require('Comment').setup({
                toggler = {
                    line = 'C-c',
                },
            })
	    end
    }
    
   -- autopair 
    use {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {} 
        end
    }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
