-- python
local whichpy = function ()
    local process = io.popen('which python')
    local result = process:read('*a')
    process:close()
    return result
end
local pydap = require('dap-python')
pydap.setup(
    whichpy()
)
--pydap.setup(
--    '/usr/bin/python' -- note that this may not be correct if using a virtual environment. a smarter way is to $(which python) but I don't know how to execute shell commands in lua
--)
pydap.test_runner = 'pytest'

local nnoremap = function (k,cmd)
    vim.keymap.set('n', k, cmd)
end

nnoremap('<leader>db', vim.cmd.DapToggleBreakpoint)
nnoremap('<leader>dc', vim.cmd.DapContinue)
nnoremap('<leader>dj', vim.cmd.DapStepInto)
nnoremap('<leader>dk', vim.cmd.DapStepOut)
nnoremap('<leader>dl', vim.cmd.DapStepOver)
nnoremap('<leader>di', ':lua require\'dap\'.repl.open() <ENTER>')
