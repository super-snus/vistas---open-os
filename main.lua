local component = require("component")
local gpu = component.gpu
local event = require("event")

local windows = {}

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

-- Функция для отрисовки окна
function DrawWindow(windows)
  for i, win in pairs(windows) do
    gpu.setBackground(0xff7900) -- Оранжевый фон окна
    gpu.setForeground(0x8b4b11) -- Коричневый цвет текста
    gpu.fill(win.X, win.Y, win.W, 1, "-")   -- Заголовок окна
    gpu.fill(win.X, win.Y + 1, win.W, win.H - 1, " ") -- Тело окна
    gpu.set(win.X + 1, win.Y, win.NAME)     -- Смещаем имя окна вправо
  end
end

while true do
  -- Фон рабочего стола
  gpu.setBackground(0x00ff98)
  gpu.fill(1, 1, 120, 120, " ")

  -- Отрисовка окна
  addWindow(4, 4, 10, 7, "test window")

  -- Ожидание событий (предотвращает перегрузку процессора)
  event.pull(0.1)
end
