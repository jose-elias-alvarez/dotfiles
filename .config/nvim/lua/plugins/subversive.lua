local u = require("utils")

local opts = { noremap = false }

-- s for substitute
u.map("n", "s", "<Plug>(SubversiveSubstitute)", opts)
u.map("x", "s", "<Plug>(SubversiveSubstitute)", opts)
u.map("n", "ss", "<Plug>(SubversiveSubstituteLine)", opts)
u.map("n", "S", "<Plug>(SubversiveSubstituteToEndOfLine)", opts)

-- substitute word in 1st motion over 2nd motion
u.map("n", "<Leader>s", "<Plug>(SubversiveSubstituteRange)", opts)
u.map("x", "<Leader>s", "<Plug>(SubversiveSubstituteRange)", opts)
-- substitute current word over motion
u.map("n", "<Leader>ss", "<Plug>(SubversiveSubstituteWordRange)", opts)
