anim_freq = 1
gravitation = 1

function init_game()
    local game = {}
    game.chick = new_chick(56, 54)
    game.distance = 0
    game.distance_count = 0
    game.grinder = new_grinder()
    game.platforms = {
        new_platform(8, 79 + 24, 3),
        new_platform(48, 79, 3),
        new_platform(88, 79 - 24, 2),
        new_platform(56, 79 - 48, 1),
        new_platform(40, 79 - 72, 1),
    }
    game.state = "start"
    game.walls = new_walls()

    function game:draw()
        cls(0)
        palt(0, true)
        if game.state == "start" then
            print("escape the grinder", 28, 40, 7)
            spr(001, 56, 54)
            print("press any key", 36, 70, 7)
        elseif game.state == "running" then
            for p in all(game.platforms) do
                p:draw()
            end
            game.chick:draw()
        elseif game.state == "restart" then
            print("you have reached " .. 25 * game.distance .. " cm", 18, 40, 8)
            spr(016, 56 - 8, 52)
            spr(017, 56, 52)
            spr(018, 56 + 8, 52)
            spr(033, 56, 52 + 8)
            print("press any key", 36, 70, 7)
        end
        palt(0, false)
        game.grinder:draw()
        game.walls:draw()
    end

    function game:update()
        if game.state == "start" then
            if (btn() > 0) then
                game.state = "running"
            end
        elseif game.state == "restart" then
            if (btn() > 0) then
                game = init_game()
                game.state = "running"
            end
        elseif game.state == "running" then
            game.chick:fall(gravitation)

            if game.grinder:collides_with(game.chick) then
                game.state = "restart"
            end

            if game.chick.y < 0 then
                game.chick.y = 0
                game.chick.v = 0
            end

            local can_jump = false
            for p in all(game.platforms) do
                if p:collides_with(game.chick) then
                    if game.chick.v > 0 then
                        can_jump = true
                        game.chick.jumps = 2
                        game.chick.y = p.y - 8
                    else
                        game.chick.y = p.y + 4
                    end
                    game.chick.v = 0
                    break
                end
            end

            if game.walls:collides_with(game.chick) then
                can_jump = true
            end

            if can_jump and game.chick.jumps > 0 and (btn(4) or btn(5)) then
                game.chick:jump()
            elseif btn(0) then
                if game.chick.d == "r" then
                    game.chick.d = "l"
                else
                    if not game.walls:collides_with_left(game.chick) then
                        game.chick.x = game.chick.x - 2
                    end
                end
            elseif btn(1) then
                if game.chick.d == "l" then
                    game.chick.d = "r"
                else
                    if not game.walls:collides_with_right(game.chick) then
                        game.chick.x = game.chick.x + 2
                    end
                end
            end
            for p in all(game.platforms) do
                p:update()
                if p.y > 121 then
                    del(game.platforms, p)
                end
            end
            if game.platforms[#game.platforms].y == 8 then
                local old_p = game.platforms[#game.platforms]
                local sgn = rnd({ -1, 1 })
                if old_p.x == 8 then
                    sgn = 1
                elseif old_p.x + 8 * (old_p.w + 2) >= 120 then
                    sgn = -1
                end
                local w = ceil(rnd(2))
                local x = 0
                local offset = 8 + ceil(rnd(8))
                if sgn == -1 then
                    x = max(old_p.x - (offset + (old_p.w + 2) * 8), 8)
                else
                    x = min(120 - offset, old_p.x + 8 * (old_p.w + 2) + offset)
                end
                add(game.platforms, new_platform(x, -24, w))
            end
            game.chick:update()
            game.grinder:update()
            game.walls:update()

            game.distance_count = (game.distance_count + 1) % 60
            if game.distance_count == 0 then
                game.distance = game.distance + 1
            end
        end
    end

    return game
end
