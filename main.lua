require("peg")

function love.load()
  held = 0
  victory = false
  love.graphics.setBackgroundColor(0.505, 0.517, 0.474)
  pegs = {
    Peg:new{x=510, y=10} ,
    Peg:new{x=600, y=10} ,
    Peg:new{x=690, y=10} ,
    Peg:new{x=510, y=100} ,
    Peg:new{x=600, y=100} ,
    Peg:new{x=690, y=100} ,
    Peg:new{x=510, y=190} ,
    Peg:new{x=600, y=190} ,
    Peg:new{x=690, y=190} ,
    Peg:new{x=240, y=280} ,
    Peg:new{x=330, y=280} ,
    Peg:new{x=420, y=280} ,
    Peg:new{x=510, y=280} ,
    Peg:new{x=600, y=280} ,
    Peg:new{x=690, y=280} ,
    Peg:new{x=780, y=280} ,
    Peg:new{x=870, y=280} ,
    Peg:new{x=960, y=280} ,
    Peg:new{x=240, y=370} ,
    Peg:new{x=330, y=370} ,
    Peg:new{x=420, y=370} ,
    Peg:new{x=510, y=370} ,
    Peg:new{x=600, y=370, state = false} ,
    Peg:new{x=690, y=370} ,
    Peg:new{x=780, y=370} ,
    Peg:new{x=870, y=370} ,
    Peg:new{x=960, y=370} ,
    Peg:new{x=240, y=460} ,
    Peg:new{x=330, y=460} ,
    Peg:new{x=420, y=460} ,
    Peg:new{x=510, y=460} ,
    Peg:new{x=600, y=460} ,
    Peg:new{x=690, y=460} ,
    Peg:new{x=780, y=460} ,
    Peg:new{x=870, y=460} ,
    Peg:new{x=960, y=460} ,
    Peg:new{x=510, y=550} ,
    Peg:new{x=600, y=550} ,
    Peg:new{x=690, y=550} ,
    Peg:new{x=510, y=640} ,
    Peg:new{x=600, y=640} ,
    Peg:new{x=690, y=640} ,
    Peg:new{x=510, y=730} ,
    Peg:new{x=600, y=730} ,
    Peg:new{x=690, y=730} ,
  }
  neighbors = {
    {[3]=2, [7]=4} ,
    {[8]=5} ,
    {[1]=2, [9]=6} ,
    {[6]=5, [13]=7} ,
    {[14]=8} ,
    {[4]=5, [15]=9} ,
    {[1]=4, [9]=8, [22]=13} ,
    {[2]=5, [23]=14} , 
    {[3]=6, [7]=8, [24]=15} ,
    {[12]=11, [28]=19} ,
    {[13]=12, [29]=20} ,
    {[10]=11, [14]=13, [30]=21} , 
    {[4]=7, [11]=12, [15]=14, [31]=22} ,
    {[5]=8, [12]=13, [16]=15, [32]=23} ,
    {[6]=9, [13]=14, [17]=16, [33]=24} ,
    {[14]=15, [18]=17, [34]=25} ,
    {[15]=16, [35]=26} ,
    {[16]=17, [36]=27} ,
    {[21]=20} ,
    {[22]=21} ,
    {[19]=20, [23]=22} ,
    {[7]=13, [20]=21, [24]=23, [37]=31} ,
    {[8]=14, [21]=22, [25]=24, [38]=32} ,
    {[9]=15, [22]=23, [26]=25, [39]=33} ,
    {[23]=24, [27]=26} ,
    {[24]=25} ,
    {[25]=26} ,
    {[10]=19, [30]=29} ,
    {[11]=20, [31]=30} ,
    {[12]=21, [28]=29, [32]=31} ,
    {[13]=22, [29]=30, [33]=32, [40]=37} ,
    {[14]=23, [30]=31, [34]=33, [41]=38} ,
    {[15]=24, [31]=32, [35]=34, [42]=39} ,
    {[16]=25, [32]=33, [36]=35} ,
    {[17]=26, [33]=34} ,
    {[18]=27, [34]=35} ,
    {[22]=31, [39]=38, [43]=40} ,
    {[23]=32, [44]=41} ,
    {[24]=33, [37]=38, [45]=42} ,
    {[31]=37, [42]=41} ,
    {[32]=38} ,
    {[33]=39, [40]=42} ,
    {[37]=40, [45]=44} ,
    {[38]=41} ,
    {[39]=42, [43]=44}
  }
end

function love.draw()
  for _i, s in ipairs(pegs) do
    s:draw()
    if victory then
      love.graphics.print("You Won!", 10, 10)
    end
  end
end

function love.mousepressed(x, y, button, istouch)
  if button == 1 then
    for i, p in ipairs(pegs) do
      if p:pointinside(x, y) and p.state then
        held = i
      end
    end
  end
end

function love.mousereleased(x, y, button, istouch)
  if button == 1 and held > 0 then
    for n in pairs(neighbors[held]) do
      if pegs[n]:pointinside(x, y) and not pegs[n].state then
        skipped = neighbors[held][n]
        if pegs[skipped].state then
          pegs[held].state = false
          pegs[skipped].state = false
          pegs[n].state = true
          held = 0
          checkvictory()
          break
        end
      end
    end
  end
end

function checkvictory()
  count = 0
  for i, p in ipairs(pegs) do
    if p.state then count = count + 1 end
    if count > 1 then break end
  end
  victory = count == 1
end