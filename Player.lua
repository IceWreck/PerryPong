Player = Class{}

function Player:init(x, y, score)
    self.x = x
    self.y = y -- of topmost point
    self.score = score
    self.dy = 0
end

function Player:update(dt)
    if dt < 0 then -- go up
        self.y = math.max(0, self.y + dt * PLAYER_SPEED)
    else
        self.y = math.min(WINDOW_HEIGHT-150, self.y + dt * PLAYER_SPEED)
    end

end

function Player:render()
    -- ( mode, x, y, width, height )
    love.graphics.rectangle('fill', self.x, self.y, 30, 150)
end