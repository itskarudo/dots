require("colorscheme")
require("options")
require("diagnostics").setup()
require("mappings")
require("plugins")

local mod_dir_to_spec = require("lzextras").mod_dir_to_spec
require("lze").load({ import = mod_dir_to_spec("lazy-plugins") })
