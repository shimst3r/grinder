function new_grinder()
    local grinder = {}
    for col = 1, 15, 2 do
        grinder[col] = { x = 8 * col, s = 005 }
        grinder[col + 1] = { x = 8 * (col + 1), s = 006 }
    end

    function grinder:collides_with(player)
        if player.y < 8 * 15 then
            return false
        end
        return true
    end

    function grinder:draw()
        for tile in all(grinder) do
            spr(tile.s, tile.x, 8 * 15 + 1)
        end
    end

    function grinder:update()
        for tile in all(grinder) do
            tile.x = tile.x - 2
            if tile.x < 0 then
                add(grinder, { x = 8 * #grinder, s = tile.s })
                del(grinder, tile)
            end
        end
    end

    return grinder
end
