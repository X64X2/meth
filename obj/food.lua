Food = Object:extend()

function Food:new(i, j)

    self.i = i
    self.j = j
    self.x, self.y = get_position(i, j)

end

function Food:draw()

    --love.graphics.rectangle("fill", self.x, self.y, CELLSIZE, CELLSIZE)
    love.graphics.draw(apple, self.x, self.y, nil, 0.5, 0.5)
end
