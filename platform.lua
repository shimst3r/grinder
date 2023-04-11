function new_platform(x, y, w)
    local platform = { x = x, y = y, w = w, anim_count = 0 }

    function platform:collides_with(chick)
        if chick.x + 1.5 > platform.x + 8 * (platform.w + 2) then
            return false
        elseif chick.x + 5.5 < platform.x then
            return false
        elseif chick.y > platform.y + 3 then
            return false
        elseif chick.y + 7 < platform.y then
            return false
        end
        return true
    end

    function platform:draw()
        spr(007, platform.x, platform.y)
        for i = 1, platform.w do
            spr(008, platform.x + i * 8, platform.y)
        end
        spr(009, platform.x + 8 * (platform.w + 1), platform.y)
    end

    function platform:update()
        if platform.anim_count % anim_freq == 0 then
            platform.y = platform.y + 1
        end
        platform.anim_count = platform.anim_count + 1
    end

    return platform
end
