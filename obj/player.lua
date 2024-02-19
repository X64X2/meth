Player = Object:extend()

function Player:new(i, j, size)

    self.qu = Queue(size)

    self.qu:push({i = i-2, j = j})
    self.qu:push({i = i-1, j = j})
    self.qu:push({i = i, j = j})

    self.grow = false

end

function Player:update(direction)

    local head = self.qu:top()
    local next

    if direction == "up" then
        next = {i = head.i, j = head.j - 1}
    elseif direction == "down" then
        next = {i = head.i, j = head.j + 1}
    elseif direction == "left" then
        next = {i = head.i - 1, j = head.j}
    elseif direction == "right" then
        next = {i = head.i + 1, j = head.j}
    end

    self.qu:push(next)
    Food = false

    if not self.grow then
        self.qu:pop()
    end

    self.grow = false

end

function Player:draw()

    for s in self.qu:iter() do
        local x, y = get_position(s.i, s.j)
        love.graphics.rectangle("fill", x, y, CELLSIZE, CELLSIZE)
    end
    
end

function Player:lost()

    local j = 1

    for s in self.qu:iter() do
        if j ~= self.qu.size and s.i == self.qu:top().i and s.j == self.qu:top().j then
            return true
        end
        j = j+1
    end

    return self.qu:top().i >= GRIDMAX
        or self.qu:top().i < 0
        or self.qu:top().j >= GRIDMAX
        or self.qu:top().j < 0

end

