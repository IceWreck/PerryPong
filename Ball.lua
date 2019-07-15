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

function Ball:isCollision(player)
    if self.x - self.radius > 30 then--or self.x + self.radius < WINDOW_WIDTH-30 then
        return false
    end

    if player.position + 150 < self.y - self.radius or self.radius + self.y > player.position then
        return false
    end
    -- if nothing happens then return true
    return true
end

function Ball:render()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end
