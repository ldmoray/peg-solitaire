Peg = { x = 0, y = 0, size = 80, state = true}

function Peg:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Peg:mode()
  if self.state then
    return "fill"
  else
    return "line"
  end
end

function Peg:pointinside(x, y)
  return x >= self.x and 
         x <= self.x+self.size and 
         y >= self.y and 
         y <= self.y+self.size
end

function Peg:draw()
  love.graphics.setColor(0.752, 0.972, 0.819, 0.5)
  love.graphics.rectangle(self:mode(), self.x, self.y, self.size, self.size)
  love.graphics.setColor(0, 0, 0, 1)
end