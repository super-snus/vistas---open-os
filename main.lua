local component = require("component")
local gpu = component.gpu
local event = require("event")

-- Функция для отрисовки окна
function addWindow(X, Y, W, H, NAME)
  gpu.setBackground(0xff7900) -- Оранжевый фон окна
  gpu.setForeground(0x8b4b11) -- Коричневый цвет текста
  gpu.fill(X, Y, W, 1, "-")   -- Заголовок окна
  gpu.fill(X, Y + 1, W, H - 1, " ") -- Тело окна
  gpu.set(X + 1, Y, NAME)     -- Смещаем имя окна вправо
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
