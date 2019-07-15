-- Import Classes
Class = require 'class'
require 'Ball'
require 'Player'

-- Constant Variables
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
GAME_NAME = "Perry Pong"
FSIZE_XL = 200 -- for title
FSIZE_SCORE = 100 -- for scorekeeping
PLAYER_SPEED = 600
BALL_RADIUS = 40

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

    -- Init Players (Player dimension 30x150)
    -- Player coordinates refer to the topmost left part of player
    phineas = Player(10, 30, 0) -- leave 30px so as not to be on the extreme edge
    ferb = Player(WINDOW_WIDTH-40, WINDOW_HEIGHT - 180, 0) -- (180 cause 150 + 30 cause initial state is not at the edge)
    -- Init Ball
    ball = Ball(WINDOW_WIDTH/2, WINDOW_HEIGHT/2, BALL_RADIUS)
    -- Game State
    game_state = "STOP"
end

function love.draw()
    -- Draw backgrounds
    love.graphics.draw(bg_image)
    love.graphics.setFont(bg_font)

    -- Render Objects
    phineas:render() 
    ferb:render()
    ball:render()

    love.graphics.setColor(0.4156,0.5215,0.1411, 0.75)

    love.graphics.printf(
        GAME_NAME,
        0, -- X coord, its 0 cause it starts at 0 and then aligns to center
        WINDOW_HEIGHT/2 - FSIZE_XL/2, -- Y cood, start slightly above half the window height 
        WINDOW_WIDTH, -- align across the entire window width 
        'center' -- alignment type center
    )

    love.graphics.setColor(1, 1,1, 0.7)

    -- Draw scorecards
    love.graphics.setFont(sc_font)
    love.graphics.print(tostring(phineas.score), WINDOW_WIDTH / 2 - 200, WINDOW_HEIGHT/7)
    love.graphics.print(tostring(ferb.score), WINDOW_WIDTH / 2 + 200, WINDOW_HEIGHT/7)

    showFPS()

    love.graphics.setColor(1, 1,1, 1)
    

    

end

function love.update(dt)
    -- Ball 
    if ball:isCollision(phineas) then
        ball.dx = -ball.dx
    end
    if ball:isCollision(ferb) then
        ball.dx = -ball.dx
    end
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