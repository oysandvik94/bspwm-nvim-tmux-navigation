local util = {}

local bspwm_directions = { ['p'] = 'l', ['h'] = 'west', ['j'] = 'south', ['k'] = 'north', ['l'] = 'east', ['n'] = 't:.+' }

-- change the current pane according to direction
function util.bspwm_change_pane(direction)
    vim.fn.system("bspwm node -f " .. bspwm_directions[direction])
end

return util
