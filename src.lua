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

local highscore = 0
local size = 3
Tail.x = 1
Tail.y = 1
Head.x = Tail.x + ( size - 1 )
Head.y = Tail.y

local Food = {}
Food.x = false
Food.y = false

Head.dx = 1
Head.dy = 0
Tail.dx = Head.dx
Tail.dy = Head.dy
local direction = "right"
local level = 1
local score = 0

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
        score = score + level
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