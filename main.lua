WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
GAME_NAME = "Perry Pong"

function love.load()
    love.window.setMode( WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    } )
end

function love.draw()
    love.graphics.printf(
        GAME_NAME,
        0, -- X coord, its 0 cause it starts at 0 and then align to center
        WINDOW_HEIGHT/2 - 6, -- Y cood, start slightly above half the window height 
        WINDOW_WIDTH, -- align across the entire window width 
        'center' -- alignment type center
    )
end