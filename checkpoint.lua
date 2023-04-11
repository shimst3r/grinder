function new_checkpoint(y, val)
    local cp = { y = y, val = val }

    function cp:collides_with(player)
        return false
    end

    function cp:draw()
        rect(8 - 1, cp.y - 1, 127 - 8 + 1, cp.y + 7, 7)
        print(cp.val, 10, cp.y + 1, 7)
    end

    function cp:update()
    end

    return cp
end
