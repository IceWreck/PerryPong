-- Import Classes
Class = require 'class'
require 'Ball'
require 'Player'
require 'helpers'

-- Constant Variables
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
GAME_NAME = "Perry Pong"
FSIZE_XL = 200 -- font size for title
FSIZE_SCORE = 100 -- for scorekeeping
PLAYER_SPEED = 600
SPEED_INCREASE = 1.15 -- speed increase for ball after every collision
BALL_SIDE = 100  -- width of square image for ball, the actual img is part transparent to make it look circular
FERB_OFFSET_LIMIT = 180 -- Max value of offset

-- Variables that need to be accessed/changed in multiple functions
ferb_offset = 100 -- default value untill it changes on first collision/score


function love.load()
    bg_font = love.graphics.newFont('fonts/ferbtastic.ttf', FSIZE_XL)
    sc_font = love.graphics.newFont('fonts/ferbtastic.ttf', FSIZE_SCORE)
    fps_font = love.graphics.newFont('fonts/ferbtastic.ttf', 20)
    bg_image = love.graphics.newImage("img/background.jpg")
    perry_img = love.graphics.newImage("img/perry.png")
    phineas_img = love.graphics.newImage("img/phineas.png")
    ferb_img = love.graphics.newImage("img/ferb.png")
    game_icon = love.image.newImageData("img/perry.png")
    sounds = {
        ['perry_grr'] = love.audio.newSource('sounds/perry-grr.mp3', 'static'),
        ['perry_theme'] = love.audio.newSource('sounds/perry-dooby-dooby-do.mp3', 'static'),
        ['theme']= love.audio.newSource('sounds/theme.mp3', 'stream'),
        ['watchadoin']= love.audio.newSource('sounds/watchadoin.mp3', 'static'),
        ['hit']= love.audio.newSource('sounds/hit.wav', 'static'),
        ['goal']= love.audio.newSource('sounds/goal.wav', 'static')        
    }
    
    love.window.setMode( WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    } )

    love.window.setTitle('Perry Pong')
    love.window.setIcon(game_icon)
    math.randomseed(os.time())

    -- Init Players (Player dimension 30x150)
    -- Player coordinates refer to the topmost left part of player
    phineas = Player(10, 30, 0, "Phineas", phineas_img) -- leave 30px so as not to be on the extreme edge
    ferb = Player(WINDOW_WIDTH-110, WINDOW_HEIGHT - 180, 0, "Ferb", ferb_img) -- (180 cause 150 + 30 cause initial state is not at the edge)
    -- Init Ball
    ball = Ball(perry_img, WINDOW_WIDTH/2 - BALL_SIDE/2, WINDOW_HEIGHT/2 - BALL_SIDE/2, BALL_SIDE)
    -- Play Music
    sounds['theme']:setLooping(true)
    sounds['theme']:play()

    -- Game State
    game_state = "STOP"
end

function love.draw()
    -- Draw backgrounds
    love.graphics.draw(bg_image)
    love.graphics.setFont(bg_font)

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

    -- Render Objects
    phineas:render() 
    ferb:render()
    ball:render()

end

function love.update(dt)
    -- Ball 

    -- Collision with players
    if ball:isCollision(phineas) or ball:isCollision(ferb) then

        -- we change the ferb_offset value after every collision.
        ferb_offset = math.random(0, FERB_OFFSET_LIMIT)

        sounds['perry_grr']:play()
        -- rebound with extra speed
        ball.dx = -ball.dx * SPEED_INCREASE
        -- change its angle
        if ball.dy < 0 then
            ball.dy = -math.random(50, 350)
        else
            ball.dy = math.random(50, 350)
        end
    end

    -- Ensure it doesn't go offscreen
    if ball.y <= 0 then
        sounds['hit']:play()  -- watchadoing was too annoying
        ball.y = 0
        ball.dy = -ball.dy
    end
    if ball.y >= WINDOW_HEIGHT - BALL_SIDE then
        sounds['hit']:play()
        ball.y = WINDOW_HEIGHT - BALL_SIDE
        ball.dy = -ball.dy
    end

    -- Phineas
    if love.keyboard.isDown('up') then
        phineas:update(-dt)
    elseif love.keyboard.isDown('down') then
        phineas:update(dt)
    end

    -- Ferb for multiplayer
    --[[
    if love.keyboard.isDown('w') then
        ferb:update(-dt)
    elseif love.keyboard.isDown('s') then
        ferb:update(dt)
    end
    ]]
    automatedFerb(dt, ferb_offset)
    
    if game_state == 'PLAY' then
        ball:update(dt)
    end

    -- Scoring

    if ball.x < 0 then
        sounds['goal']:play()
        ferb.score = ferb.score + 1
        game_state = 'STOP'
        ball:reset()
    end
    if ball.x > WINDOW_WIDTH then
        sounds['goal']:play()
        -- we change the ferb_offset value after every collision.
        ferb_offset = math.random(0, FERB_OFFSET_LIMIT)
        phineas.score = phineas.score + 1
        game_state = 'STOP'
        ball:reset()
    end

    wonGame(phineas)
    wonGame(ferb)


end

function love.keypressed(key)
    -- quit on escape
    if key == "escape" then
        love.event.quit()
    -- reset state on enter
    elseif key == 'enter' or key == 'return' then
        if game_state == 'STOP' then
            sounds['perry_theme']:play()
            game_state = 'PLAY'
        else
            game_state = 'STOP'
            ball:reset()
        end
    end
end

