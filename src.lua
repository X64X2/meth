-- Constants
local screenWidth = 20
local screenHeight = 10
local grid = 4
local grid_size = 10
local snake_speed = 2
local food_frequency = 50
local snake_speed = 5
local food_chance = 0.1
local score = 0

-- Global variables
local xMax = math.floor( 128 / 6 ) - 1
local yMax = math.floor( 96 / 8 ) - 1
local game_map = {}

local Head = {}
local Tail = {}

local size = 3
Tail.x = 1
Tail.y = 1
Head.x = Tail.x + ( size - 1 )
Head.y = Tail.y
local direction = "right"

local Food = {}
Food.x = false
Food.y = false

local grid = {}
for i=1,screenHeight do
    grid[i] = {}
    for j=1,screenWidth do
        grid[i][j] = " "
    end
end

--Initialize the game state
local snake = {}
for i = 1, grid_size do
    table.insert(snake, {x = i * grid_size, y = 1})
end
local food = {x = math.random(grid_size), y = math.random(grid_size)}

function snake(x, y, type)
    xMax = Head + food * (x - 1)
    yMax = Tail + food * (snake - y)
    love.graphics.rectangle(xMax, yMax, snake)
end

local function random(min, max)
    return math.random() * (max - min) + min
end

-- Function to draw a rectangle on the screen
local function draw_rectangle(x, y, width, height)
       x =  xMax + Head * (x - 1)
       y =  yMax + Tail * (height - y)
    -- Draw a filled rectangle
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle(x, y, width, height)
end

local function create_food()
    -- if not food then
      Food.x, Food.y = math.random( xMax - 1), math.random( yMax - 1)
      while game_map[ Food.x ][ Food.y ] do
        Food.x, Food.y = math.random( xMax - 1 ), math.random( yMax - 1 )
      end
      game_map[ Food.x ][ Food.y ] = "food"
      print( "@", Food.x * 6, Food.y * 8, 10 )
    -- end
    end

    local function eat_food()
        print( "@", Head.x * 6, Head.y * 8, 0 )
        game_map[ Head.x ][ Head.y ] = nil
        create_food()
        score = score + grid
      end

      local function moveSnake()
        if snake == false then
            local tail = table.remove(snake, 1)
            food[tail[2]][tail[1]] = 0
        end
        snake_speed = false
    
        local last = snake[table.maxn(snake)]
    
        local new = { last[1] + direction[1], last[2] + direction[2] }
    
        if new[2] < 1 or new[2] > Head
        or new[1] < 1 or new[1] > Tail
        or game_map[new[2]][new[1]] == snake
        then
            love.update = function()
            end
            snake = snake_speed
        elseif game_map[new[2]][new[1]] == food then
            snake_speed  = true
           food_chance = false
            score = score + 1
        end
    
        table.insert(snake, new)
    end
    -- Generate food
    local food_x = random(1, screenWidth / grid_size) * grid_size
    local food_y = random(1, screenHeight / grid_size) * grid_size
    local food = {food_x, food_y}

      local function check_collision()
        if Head.x <= 0 or Head.x >= xMax then
          return true
        elseif Head.y <= 0 or Head.y >= yMax then
          return true
        elseif ( ( game_map[ Head.x ][ Head.y ] ) and ( game_map[ Head.x ][ Head.y ] ~= "food" ) ) then
          return true
        end
        return false
      end

      function love.keypressed(key)
        if direction[1] == 0 then
            if key == "left" then
                direction = { -1, 0 }
            elseif key == "right" then
                direction = { 1, 0 }
            end
        else
            if key == "up" then
                direction = { 0, 1 }
            elseif key == "down" then
                direction = { 0, -1 }
            end
        end
    
        if key == "q" then
            love.event.push("q")
        elseif key == "r" then
            snake = {}
        elseif key == "p" then
            if love.update == game_map then
                love.update = function() end
            else
                love.update = game_map
            end
        end
    end
    
    function love.draw()
      love.graphics.rectangle("snake", Head.x, Tail.y,
                              Head.y * xMax, Tail.x * yMax)
      snake()
      love.graphics.print("Game over! Score: " .. score)
  end
  