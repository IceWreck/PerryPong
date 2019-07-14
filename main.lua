-- Constant Variables
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
GAME_NAME = "Perry Pong"
FSIZE_XL = 200
FSIZE_SCORE = 100
PLAYER_SPEED = 600

function love.load()
    bg_font = love.graphics.newFont('fonts/ferbtastic.ttf', FSIZE_XL)
    bg_image = love.graphics.newImage("img/background.jpg")
    love.graphics.setFont(bg_font)
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
end

function love.draw()
    love.graphics.draw(bg_image)
    -- love.graphics.setColor( 1, 1, 1, 0.9 )
    love.graphics.printf(
        GAME_NAME,
        0, -- X coord, its 0 cause it starts at 0 and then align to center
        WINDOW_HEIGHT/2 - FSIZE_XL/2, -- Y cood, start slightly above half the window height 
        WINDOW_WIDTH, -- align across the entire window width 
        'center' -- alignment type center
    )

    -- ( mode, x, y, width, height ) So the settings below ensure that both draw symmetrically
    love.graphics.rectangle('fill', 10, phineas_pos, 30, 150) 
    love.graphics.rectangle('fill', WINDOW_WIDTH-40, ferb_pos, 30, 150)

    love.graphics.circle("fill", WINDOW_WIDTH/2, WINDOW_HEIGHT/2, 100)

end

function love.update(dt)

    -- Phineas
    if love.keyboard.isDown('w') then
        phineas_pos = phineas_pos + dt * -1 * PLAYER_SPEED
    elseif love.keyboard.isDown('s') then
        phineas_pos = phineas_pos + dt * PLAYER_SPEED
    end

    -- Ferb
    if love.keyboard.isDown('up') then
        ferb_pos = ferb_pos + dt * -1 * PLAYER_SPEED
    elseif love.keyboard.isDown('down') then
        ferb_pos = ferb_pos + dt * PLAYER_SPEED
    end

end

-- quit on escape
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end