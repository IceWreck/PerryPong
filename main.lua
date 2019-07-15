-- Import Classes
Class = require 'class'
require 'Ball'
require 'Player'

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
    fps_font = love.graphics.newFont('fonts/ferbtastic.ttf', 20)
    bg_image = love.graphics.newImage("img/background.jpg")
    
    love.window.setMode( WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    } )

    love.window.setTitle('Perry Pong')

    math.randomseed(os.time())

    -- Init Players 
    phineas = Player(30, 0)
    ferb = Player(WINDOW_HEIGHT - 180, 0)
    -- Init Ball
    ball = Ball(WINDOW_WIDTH/2, WINDOW_HEIGHT/2, 50)
    -- Game State
    game_state = "STOP"
end

function love.draw()
    -- Draw backgrounds
    love.graphics.draw(bg_image)
    love.graphics.setFont(bg_font)
    love.graphics.printf(
        GAME_NAME,
        0, -- X coord, its 0 cause it starts at 0 and then aligns to center
        WINDOW_HEIGHT/2 - FSIZE_XL/2, -- Y cood, start slightly above half the window height 
        WINDOW_WIDTH, -- align across the entire window width 
        'center' -- alignment type center
    )

    -- Draw scorecards
    love.graphics.setFont(sc_font)
    love.graphics.print(tostring(phineas.score), WINDOW_WIDTH / 2 - 200, WINDOW_HEIGHT/4)
    love.graphics.print(tostring(ferb.score), WINDOW_WIDTH / 2 + 200, WINDOW_HEIGHT/4)

    showFPS()
    -- Render Objects
    phineas:render(10) 
    ferb:render(WINDOW_WIDTH-40)
    ball:render()

end

function love.update(dt)

    -- Phineas
    if love.keyboard.isDown('w') then
        phineas:update(-dt)
    elseif love.keyboard.isDown('s') then
        phineas:update(dt)
    end

    -- Ferb
    if love.keyboard.isDown('up') then
        ferb:update(-dt)
    elseif love.keyboard.isDown('down') then
        ferb:update(dt)
    end

    if game_state == 'PLAY' then
        ball:update(dt)
    end
end

function love.keypressed(key)
    -- quit on escape
    if key == "escape" then
        love.event.quit()
    -- reset state on enter
    elseif key == 'enter' or key == 'return' then
        if game_state == 'STOP' then
            game_state = 'PLAY'
        else
            game_state = 'STOP'
            ball:reset()
        end
    end
end

function showFPS()
    love.graphics.setFont(fps_font)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 50,50)
end