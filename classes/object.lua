Object = Class{
  init = function(self, id, name, descriptions, images, interactions, initPosition)
    self.id, self.name, self.interactions = id, name, interactions
    
    self.groundDescription = descriptions.ground
    self.invDescription = descriptions.inv
    
    self.x = initPosition.x
    self.y = initPosition.y
    self.w = initPosition.w
    self.h = initPosition.h
    
    self.tX = self.x
    self.tY = self.y
    self.tW = self.w
    self.tH = self.h
    self.tRight = self.tX + self.tW
    self.tBot = self.tY + self.tH
    
    if images.none then 
      self.groundImg = "none"
      self.invImg = "none"
    else
      if images.ground then self.groundImg = nImg(OBJ .. images.ground .. ".png") end
      if images.inv then self.invImg = nImg(OBJ .. images.inv .. ".png") end
    end
    
    self.inInventory = false
  end
}

function Object:draw()
  resetColor()
  if self.inInventory == false and self.groundImg ~= "none" then
    if SETTINGS.scaleObjects then
      gDraw(self.groundImg, self.tX, self.tY, nil, xScale, yScale)
    else
      gDraw(self.groundImg, self.tX, self.tY)
    end
  elseif self.inInventory and self.invImg ~= "none" then
    gDraw(self.invImg, self.x, self.y)
  end
end

function Object:update(dt)
  self.tX = self.x * xScale
  self.tY = self.y * yScale
  self.tW = self.w * xScale
  self.tH = self.h * yScale
  self.tRight = self.tX + self.tW
  self.tBot = self.tY + self.tH
end

function Object:checkForHover()
  local mX, mY = love.mouse.getPosition()
  if mX >= self.tX and mX <= self.tRight and mY >= self.tY and mY <= self.tBot then
    return true
  else
    return false
  end
end

