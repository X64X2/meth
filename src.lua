-- Constants
local screenWidth = 20
local screenHeight = 10
local cellSize = 4

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

local snakeX, snakeY = math.random(screenWidth), math.random(screenHeight)
local function create_food()
    -- if not food then
      Food.x, Food.y = math.random( xMax - 1), math.random( yMax - 1)
      while game_map[ Food.x ][ Food.y ] do
        Food.x, Food.y = math.random( xMax - 1 ), math.random( yMax - 1 )
      end
      game_map[ Food.x ][ Food.y ] = "food"
      snakeX.disp.print( "@", Food.x * 6, Food.y * 8, 10 )
    -- end
    end

    local function eat_food()
        snakeX.disp.print( "@", Head.x * 6, Head.y * 8, 0 )
        game_map[ Head.x ][ Head.y ] = nil
        create_food()
        score = score + level
      end 
    
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

local foodX, foodY = math.random(screenWidth), math.random(screenHeight)
local score = 0

-- Function to draw the game state on the console
local function draw()
    os.execute("cls") -- Clear the console (Windows-specific command)
    for i=1,screenHeight do
        for j=1,screenWidth do
            io.write(grid[i][j])
        end
        print()
    end
    print("Score: " .. score)
end

-- Main loop
while true do
    local event, key = os.execute("snake")
    if event == "char" then
        if key == "w" and direction ~= "down" then
            direction = "up"
        elseif key == "s" and direction ~= "up" then
            direction = "down"
        elseif key == "a" and direction ~= "right" then
            direction = "left"
        elseif key == "d" and direction ~= "left" then
            direction = "right"
        end
    end
    
    -- Update the grid with new values
    grid[snakeY][snakeX] = " "
    if direction == "up" then
        snakeY = snakeY - 1
    elseif direction == "down" then
        snakeY = snakeY + 1
    elseif direction == "left" then
        snakeX = snakeX - 1
    else
        snakeX = snakeX + 1
    end
    grid[snakeY][snakeX] = "@"
    
    -- Check for collision with borders or self
    if snakeX < 1 or snakeX > screenWidth or snakeY < 1 or snakeY > screenHeight then
        break
    end
    for partX, partY in ipairs(grid[snakeY]) do
        if partX ~= snakeX and partY == "@" then
            break
        end
    end
    
    -- Generate new food
    if snakeX == foodX and snakeY == foodY then
        score = score + 1
        foodX, foodY = math.random(screenWidth), math.random(screenHeight)
        while grid[foodY][foodX] ~= " " do
            foodX, foodY = math.random(screenWidth), math.random(screenHeight)
        end
    end
    grid[foodY][foodX] = "$"
    
    -- Draw the updated game state
    draw()
    os.setlocale(0.1)
end

print("Game over! Final score: " .. score)