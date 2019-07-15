Ball = Class{}

function Ball:init(x, y, side)
    self.x = x
    self.y = y
    self.side = side
    self.dy = math.random(-50, 50) * 4
    self.dx = math.random(-100, 100) * 9
end

function Ball:reset()
    -- revert to initial position
    self.x = WINDOW_WIDTH/2
    self.y = WINDOW_HEIGHT/2

    -- set delta vals for next time
    self.dy = math.random(-50, 50) * 4
    self.dx = math.random(-100, 100) * 9
    
end

function Ball:update(dt)
    -- For every new frame, update position of ball
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:isCollision(player)
    if self.x > player.x + 30 or self.x + self.side < player.x then
        return false 
    end

    if self.y >= player.y + 150 or player.y >= (self.y + self.side) then
        return false
    end
    -- if nothing happens then return true
    return true
end

function Ball:render()
    love.graphics.rectangle("fill", self.x, self.y, self.side, self.side)
end
