function showFPS()
    love.graphics.setFont(fps_font)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 50,50)
end

function wonGame(player)
    --[[
    if player.score == 2 then
        ball:reset()
        phineas.score = 0
        ferb.score = 0
        game_state = 'STOP'
    end ]]--
end

-- To be called within the love.update() function
function automatedFerb(dt, ferb_offset)
    -- outer loop ensures that Ferb doesn't go above/below the field
    -- inner loop: ferb will always move in direction of ball, but make sure he doesn't go too far from him and that distance is determined by the ferb_offset value    

    -- Always collides till 110. After that collision rate decreases drastically  
    
    if ball.dy < 0 then
        ferb.y = math.max(0, math.min(ball.y - ferb_offset, ferb.y + dt * PLAYER_SPEED))
    else
        ferb.y = math.min(WINDOW_HEIGHT-150, math.max(ball.y + ferb_offset, ferb.y + dt * -1 * PLAYER_SPEED))
    end

end