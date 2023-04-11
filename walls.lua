function new_walls()
    local walls = {}
    walls.anim_count = 0
    for row = 1, 17, 1 do
        walls[row] = { y = 8 * (row - 2), s = 010 }
    end

    function walls:collides_with(player)
        return walls:collides_with_left(player) or walls:collides_with_right(player)
    end

    function walls:collides_with_left(player)
        if player.x > 8 - 1 then
            return false
        end
        return true
    end

    function walls:collides_with_right(player)
        if player.x < 8 * 14 + 1 then
            return false
        end
        return true
    end

    function walls:draw()
        for tile in all(walls) do
            spr(tile.s, 0, tile.y)
            spr(tile.s, 15 * 8, tile.y, 1, 1, true)
        end
        spr(012, 0, 122)
        spr(012, 120, 122)
    end

    function walls:update()
        if walls.anim_count % anim_freq == 0 then
            for tile in all(walls) do
                tile.y = tile.y + 1
                if tile.y > 121 then
                    add(walls, { y = -9, s = tile.s })
                    del(walls, tile)
                end
            end
        end
        walls.anim_count = walls.anim_count + 1
    end

    return walls
end
