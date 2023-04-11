jump_speed = -8

function new_chick(x, y)
    local chick = { x = x, y = y, v = 0, d = "r", anim_count = 0, jumps = 2 }

    function chick:draw()
        if chick.d == "l" then
            if chick.anim_count < 5 then
                spr(001, chick.x, chick.y, 1, 1, true)
            elseif chick.anim_count >= 5 and chick.anim_count < 10 then
                spr(002, chick.x, chick.y, 1, 1, true)
            elseif chick.anim_count >= 10 and chick.anim_count < 15 then
                spr(001, chick.x, chick.y, 1, 1, true)
            elseif chick.anim_count >= 15 and chick.anim_count < 20 then
                spr(003, chick.x, chick.y, 1, 1, true)
            end
        elseif chick.d == "jl" then
            spr(004, chick.x, chick.y, 1, 1, true)
        elseif chick.d == "r" then
            if chick.anim_count < 5 then
                spr(001, chick.x, chick.y)
            elseif chick.anim_count >= 5 and chick.anim_count < 10 then
                spr(002, chick.x, chick.y)
            elseif chick.anim_count >= 10 and chick.anim_count < 15 then
                spr(001, chick.x, chick.y)
            elseif chick.anim_count >= 15 and chick.anim_count < 20 then
                spr(003, chick.x, chick.y)
            end
        elseif chick.d == "jr" then
            spr(004, chick.x, chick.y)
        end
    end

    function chick:fall(gravitation)
        chick.v = min(flr(chick.v + gravitation), -jump_speed)
        chick.y = chick.y + chick.v
        if chick.v > 0 then
            if chick.d == "jl" then
                chick.d = "l"
            elseif chick.d == "jr" then
                chick.d = "r"
            end
        end
    end

    function chick:jump()
        chick.jumps = chick.jumps - 1
        chick.v = jump_speed
        chick.y = chick.y - 1
        if chick.d == "l" then
            chick.d = "jl"
        elseif chick.d == "r" then
            chick.d = "jr"
        end
    end

    function chick:update()
        chick.anim_count = (chick.anim_count + 1) % 20
    end

    return chick
end
