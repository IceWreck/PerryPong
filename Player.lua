Player = Class{}

function Player:init(position, score)
    self.position = position -- of topmost point
    self.score = score
    self.dy = 0
end

function Player:update(dt)
    if dt < 0 then -- go up
        self.position = math.max(0, self.position + dt * PLAYER_SPEED)
    else
        self.position = math.min(WINDOW_HEIGHT-150, self.position + dt * PLAYER_SPEED)
    end

end

function Player:render(x)
    -- ( mode, x, y, width, height )
    love.graphics.rectangle('fill', x, self.position, 30, 150)
end