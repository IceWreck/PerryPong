Ball = Class{}

function Ball:init(x, y, radius)
    self.x = x
    self.y = y
    self.radius = radius
    self.dy = math.random(-50, 50) * 4
    self.dx = math.random(-100, 100) * 9
end

function Ball:reset()
    -- revert to initial position
    self.x = WINDOW_WIDTH/2
    self.y = WINDOW_HEIGHT/2

    -- set delta vals for next time
    self.dx = math.random(-100, 100) * 9
    self.dy = math.random(-50, 50) * 4
end

function Ball:update(dt)
    -- For every new frame, update position of ball
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end
