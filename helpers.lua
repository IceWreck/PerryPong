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

