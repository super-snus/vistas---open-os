local component = require("component")
local gpu = component.gpu
local event = require("event")

local windows = {}
local WindowHolding = false
local MouseStartX, MouseStartY

-- Функция для отслеживания кликов мыши
function onTouch(_, _, x, y, button, player)
  for _, win in ipairs(windows) do
    if x >= win.X and x <= win.X + win.W - 1 and y >= win.Y and y <= win.Y + 1 then
      -- Начало перетаскивания окна
      WindowHolding = true
      MouseStartX = x - win.X
      MouseStartY = y - win.Y
      break
    end
  end
end

-- Функция для завершения перетаскивания
function onDrop(_, _, x, y, button, player)
  WindowHolding = false
end

-- Функция для создания окна
function addWindow(X, Y, W, H, NAME)
  local win = {
    X = X,
    Y = Y,
    W = W,
    H = H,
    NAME = NAME,
    content = {}
  }
  table.insert(windows, win)
  return win
end

-- Функция для отрисовки окон и их перемещения
function DrawWindows(windows)
  for _, win in ipairs(windows) do
    -- Если окно перетаскивается, обновляем его координаты
    if WindowHolding then
      local _, _, mx, my = event.pull("touch")
      local newX = mx - MouseStartX
      local newY = my - MouseStartY

      -- Обновляем позицию окна
      win.X = newX
      win.Y = newY
    end

    gpu.setBackground(0xff7900) -- Оранжевый фон окна
    gpu.setForeground(0x8b4b11) -- Коричневый цвет текста
    gpu.fill(win.X, win.Y, win.W, 1, "-")   -- Заголовок окна
    gpu.fill(win.X, win.Y + 1, win.W, win.H - 1, " ") -- Тело окна
    gpu.set(win.X + 1, win.Y, win.NAME)     -- Смещаем имя окна вправо
  end
end

addWindow(4, 4, 10, 7, "test window")

while true do
  -- Фон рабочего стола
  gpu.setBackground(0x00ff98)
  gpu.fill(1, 1, 120, 120, " ")
  
  
  
  
  -- Отрисовка всех окон и их перемещение
  DrawWindows(windows)

  -- Ожидание событий (предотвращает перегрузку процессора)
  event.pull(0.1)
end
