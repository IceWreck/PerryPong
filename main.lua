-- Constant Variables
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
GAME_NAME = "Perry Pong"
FSIZE_XL = 200
FSIZE_SCORE = 100
PLAYER_SPEED = 600

function love.load()
    bg_font = love.graphics.newFont('fonts/ferbtastic.ttf', FSIZE_XL)
    sc_font = love.graphics.newFont('fonts/ferbtastic.ttf', FSIZE_SCORE)
    bg_image = love.graphics.newImage("img/background.jpg")
    
    love.window.setMode( WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    } )

    -- Initial Scores
    phineas_score = 0
    ferb_score = 0

    -- Initial Positions (Y of topmost point)
    phineas_pos = 30    
    ferb_pos = WINDOW_HEIGHT - 180

    ball_x = WINDOW_WIDTH/2
    ball_y = WINDOW_HEIGHT/2

    ball_dx = math.random(-100, 100) * 4 
    ball_dy = math.random(-50, 50) * 4

    game_state = "STOP"
end

function love.draw()
    love.graphics.draw(bg_image)
    -- love.graphics.setColor( 1, 1, 1, 0.9 )

    love.graphics.setFont(bg_font)
    love.graphics.printf(
        GAME_NAME,
        0, -- X coord, its 0 cause it starts at 0 and then align to center
        WINDOW_HEIGHT/2 - FSIZE_XL/2, -- Y cood, start slightly above half the window height 
        WINDOW_WIDTH, -- align across the entire window width 
        'center' -- alignment type center
    )


    love.graphics.setFont(sc_font)
    love.graphics.print(tostring(phineas_score), WINDOW_WIDTH / 2 - 200, WINDOW_HEIGHT/4)
    love.graphics.print(tostring(ferb_score), WINDOW_WIDTH / 2 + 200, WINDOW_HEIGHT/4)

    -- ( mode, x, y, width, height ) So the settings below ensure that both draw symmetrically
    love.graphics.rectangle('fill', 10, phineas_pos, 30, 150) 
    love.graphics.rectangle('fill', WINDOW_WIDTH-40, ferb_pos, 30, 150)

    love.graphics.circle("fill", ball_x, ball_y, 50)

end

function love.update(dt)

    -- Phineas
    if love.keyboard.isDown('w') then
        phineas_pos = math.max(0, phineas_pos + dt * -1 * PLAYER_SPEED)
    elseif love.keyboard.isDown('s') then
        phineas_pos = math.min(WINDOW_HEIGHT-150, phineas_pos + dt * PLAYER_SPEED)
    end

    -- Ferb
    if love.keyboard.isDown('up') then
        ferb_pos = math.max(0, ferb_pos + dt * -1 * PLAYER_SPEED)
    elseif love.keyboard.isDown('down') then
        ferb_pos = math.min(WINDOW_HEIGHT-150, ferb_pos + dt * PLAYER_SPEED)
    end

    if game_state == 'PLAY' then
        ball_x = ball_x + ball_dx * dt
        ball_y = ball_y + ball_dy * dt
    end


end

function love.keypressed(key)
    -- quit on escape
    if key == "escape" then
        love.event.quit()
    -- change state to reset
    elseif key == 'enter' or key == 'return' then
        if game_state == 'STOP' then
            game_state = 'PLAY'
        else
            game_state = 'STOP'
            
            -- revert to initial state
            ball_x = WINDOW_WIDTH/2
            ball_y = WINDOW_HEIGHT/2

            -- set delta vals for next time

            ball_dx = math.random(-100, 100) * 4 
            ball_dy = math.random(-50, 50) * 4

            
        end
    end
end