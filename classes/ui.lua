-- Class for menus
Menu = Class{
  init = function(self, id, x, y, w, backdrop, caption, icon, items, staticH, h, stackDir)
    self.id, self.x, self.y, self.w = id, x, y, w
    self.a = 255
    self.staticH = staticH or false
    if self.staticH == true then
      self.h = h
    else
      self.h = 8 
    end
    
    if backdrop ~= "filled" and backdrop ~= "empty" and backdrop ~= nil then
      self.backdrop = nImg(BACKDROPS .. backdrop .. ".png")
    elseif backdrop == nil then
      self.backdrop = "empty"
    else
      self.backdrop = backdrop
    end
    
    if caption then
      self.caption = caption
      self.contentY = y + 48
      if self.staticH == false then self.h = self.h + 48 end
    else
      self.caption = false
      self.contentY = y + 16
    end
    
    if icon then
      self.icon = nImg(ICONS .. icon .. ".png")
      self.contentX = x + self.icon:getWidth() + 32
    else
      self.icon = false
      self.contentX = x + 16
    end
    self.container = items or {}
    
    self.contentW = w - (self.contentX - x) - 16
    self.contentH = self.h - (self.contentY - y) - 16
    
    self.contentXStack = self.contentX
    self.contentYStack = self.contentY
    
    self.rightX = self.x + self.w
    self.bottomY = self.y + self.h
    
    self.stackDir = stackDir or "vertical"
    
    self.active = true
    self.activeStateLocked = false
    self.maxW = false
    self.maxH = false
  end
}

function Menu:bottom(givenHeight)
  return self.contentH - (givenHeight)
end

function Menu:newXStack(givenHeight, xOffset)
  self.contentXStack = self.contentX + xOffset + 8
  self.contentYStack = self.contentYStack + givenHeight
end

function Menu:addTextButt(buttFunc, buttFore, buttBack, buttW, buttH, bXM, bYM, active, tooltip)
  local bX, bY = 0, 0
  if bXM then bX = bXM else bX = self.contentXStack - self.contentX end
  if bYM then bY = bYM else bY = self.contentYStack - self.contentY end
  local bW = buttW or self.contentW
  local bH = buttH or 32
  
  local stackSit = true
  
  if bXM or bYM then stackSit = false end
  
  local tempButt = Button(bX, bY, bW, bH, "text", buttFunc, self, buttFore, buttBack, active, tooltip)
  tPush(self.container, tempButt)
  
  if self.stackDir == "vertical" and stackSit then 
    self.contentYStack = self.contentYStack + bH + 8
    if self.staticH == false then self.h = self.h + bH + 8 end
  elseif self.stackDir == "horizontal" and stackSit then
    self.contentXStack = self.contentXStack + bW + 8
  end
  return self.container[#self.container]
end

function Menu:addPicButt(buttFunc, buttFore, buttBack, buttW, buttH, bXM, bYM, active, tooltip)
  local bX, bY = 0, 0
  if bXM then bX = bXM else bX = self.contentXStack - self.contentX end
  if bYM then bY = bYM else bY = self.contentYStack - self.contentY end
  local bW = buttW or self.contentW
  local bH = buttH or 32
  
  local stackSit = true
  
  if bXM or bYM then stackSit = false end
  
  local tempButt = Button(bX, bY, bW, bH, "pic", buttFunc, self, buttFore, buttBack, active, tooltip)
  tPush(self.container, tempButt)
  
  if self.stackDir == "vertical" and stackSit then 
    self.contentYStack = self.contentYStack + bH + 8
    if self.staticH == false then self.h = self.h + bH + 8 end
  elseif self.stackDir == "horizontal" and stackSit then
    self.contentXStack = self.contentXStack + bW + 8
  end
  
  return self.container[#self.container]
end

function Menu:addText(text, stack, w, h, align, xM, yM)
  local wt = w or self.contentW
  local ht = h or self.contentH
  if stack then
    local xMod = self.contentXStack - self.contentX
    local yMod = self.contentYStack - self.contentY
  else
    local xMod = xM or 0
    local yMod = yM or 0
  end
  
  local tempTxt = UText(text, self, w, h, align, xMod, yMod)
  tPush(self.container, tempTxt)
  
  if self.stackDir == "vertical" and stack then 
    self.contentYStack = self.contentYStack + ht + 8
    if self.staticH == false then self.h = self.h + ht + 8 end
  elseif self.stackDir == "horizontal" and stack then
    self.contentXStack = self.contentXStack + wt + 8
  end
  
  return self.container[#self.container]
end

function Menu:addPicture(img, stack, xM, yM)
  local iW = img:getWidth()
  local iH = img:getHeight()
  if stack then
    local xMod = self.contentXStack - self.contentX
    local yMod = self.contentYStack - self.contentY
  else
    local xMod = xM or 0
    local yMod = yM or 0
  end
  
  local tempPic = UImage(img, self, xMod, yMod)
  tPush(self.container, tempPic)
  
  if self.stackDir == "vertical" and stack then 
    self.contentYStack = self.contentYStack + iH + 8
    if self.staticH == false then self.h = self.h + iH + 8 end
  elseif self.stackDir == "horizontal" and stack then
    self.contentXStack = self.contentXStack + iW + 8
  end
  
  return self.container[#self.container]
end

function Menu:addInvDisplay(slot, stack, xM, yM, w, h)
  local iW = w or 84
  local iH = h or 84
  if stack then
    local xMod = self.contentXStack - self.contentX
    local yMod = self.contentYStack - self.contentY
  else
    local xMod = xM or 0
    local yMod = yM or 0
  end
  
  local tempInvD = UInv(slot, self, xM, yM, iW, iH)
  tPush(self.container, tempInvD)
  
  if self.stackDir == "vertical" and stack then 
    self.contentYStack = self.contentYStack + iH + 8
    if self.staticH == false then self.h = self.h + iH + 8 end
  elseif self.stackDir == "horizontal" and stack then
    self.contentXStack = self.contentXStack + iW + 8
  end
  
  return self.container[#self.container]
end

function Menu:alpha(mod)
  local al = self.a
  al = al + mod
  if al > 255 then al = 255
  elseif al < 0 then al = 0
  end
  return al
end

function Menu:draw()
  if self.backdrop == "filled" then
    sColor(0, 0, 0, 255)
    rekt("fill", self.x + 12, self.y + 12, self.w, self.h)
    local cl = SETTINGS.interface.baseCol
    cl[4] = self.a
    sColor(unpack(cl))
    rekt("fill", self.x, self.y, self.w, self.h)
    --sColor(0, 0, 0, alphize(self.a, -155))
    --rekt("fill", self.x, self.y, self.w, self.h)
    --sColor(unpack(cl))
    sLineWidth(4)
    rekt("line", self.x, self.y, self.w, self.h)
    sLineWidth(1)
    sColor(unpack(cl))
    
    if self.caption then
      rekt("fill", self.x, self.y, self.w, 32)
      sColor(0,0,0,self.a)
      lyne(self.x+8, self.y + 10, self.x + 8 + self.w/10, self.y + 10)
      lyne(self.x+8, self.y + 14, self.x + 8 + self.w/10, self.y + 14)
      lyne(self.x+8, self.y + 18, self.x + 8 + self.w/10, self.y + 18)
      lyne(self.x+8, self.y + 22, self.x + 8 + self.w/10, self.y + 22)
      lyne(self.x+self.w-8, self.y + 10, self.x+self.w - 8 - self.w/10, self.y + 10)
      lyne(self.x+self.w-8, self.y + 14, self.x+self.w - 8 - self.w/10, self.y + 14)
      lyne(self.x+self.w-8, self.y + 18, self.x+self.w - 8 - self.w/10, self.y + 18)
      lyne(self.x+self.w-8, self.y + 22, self.x+self.w - 8 - self.w/10, self.y + 22)
      lyne(self.x, self.y + 32, self.x + self.w, self.y + 32)
      --sColor(0,0,0,alphize(self.a,-195))
      --rekt("fill", self.x+3, self.y + 32, self.w-6, 4)
      --rekt("fill", self.x-2, self.y + self.h - 6, self.w+4, 8)
    end
    
    --sColor(255, 255, 255, alphize(self.a, -175))
    --rekt("fill", self.x, self.y, self.w, 2)
    sColor(0, 0, 0, 255)
    rekt("line", self.x, self.y, self.w, self.h)
  elseif self.backdrop ~= "empty" then
    gDraw(self.backdrop, self.x, self.y)
  end
  
  if self.caption then
    txtF(self.caption, self.x, self.y+4, self.w, "center", nil, nil, nil, self.a)
  end
  
  if self.icon then
    resetColor(self.a)
    gDraw(self.icon, self.x + 16, self.contentY)
  end
  
  for k, item in keySorted(self.container) do
    item:draw()
  end
  
  resetColor()
end

function Menu:update(dt, child)
  self = child or self
  if self.icon then
    self.contentX = self.x + self.icon:getWidth() + 32
  else
    self.contentX = self.x + 16
  end
  
  if self.caption then
    self.contentY = self.y + 48
  else
    self.contentY = self.y + 16
  end
    
  for k, item in keySorted(self.container) do
    item:update(dt)
  end
  
  if self.maxW then
    self.w = winWidth
  end
  
  if self.maxH then
    self.h = winHeight
  end
  
end

function Menu:checkForHover()
  local mX, mY = love.mouse.getPosition()
  if mX >= self.x and mX <= self.rightX and mY >= self.y and mY <= self.bottomY then
    return true
  else
    return false
  end
end

-- Class for text
UText = Class{
  init = function(self, text, parent, w, h, align, xMod, yMod)
    self.text, self.parent, self.w, self.h, self.align = text, parent, w, h, align
    self.xMod = xMod or parent.contentXStack - parent.contentX
    self.yMod = yMod or parent.contentYStack - parent.contentY
    self.x = self.parent.x + self.xMod
    self.y = self.parent.y + self.yMod
    self.a = self.parent.a
  end
}

function UText:draw()
  setColorForFonts(self.a)
  txtF(self.text, self.x, self.y, self.w, self.align)
  resetColor()
end

function UText:update(dt)
  self.x = self.parent.contentX + self.xMod
  self.y = self.parent.contentY + self.yMod
  self.a = self.parent.a
end

function UText:checkForHover()
  return false
end


-- Class for images
UImage = Class{
  init = function(self, image, parent, xMod, yMod)
    self.xMod = xMod or 0
    self.yMod = yMod or 0
    self.image = image
    self.parent = parent
    self.x = self.parent.x + self.xMod
    self.y = self.parent.y + self.yMod
    self.w = image:getWidth()
    self.h = image:getHeight()
    self.a = self.parent.a
  end
}

function UImage:draw()
  resetColor(self.a)
  gDraw(self.image, self.x, self.y)
  resetColor()
end

function UImage:update(dt)
  self.x = self.parent.contentX + self.xMod
  self.y = self.parent.contentY + self.yMod
  self.a = self.parent.a
end

function UImage:checkForHover()
  return false
end
-- Class for buttons
Button = Class{
  init = function(self, xM, yM, w, h, kind, func, parent, fore, back, active, tooltip)
    self.xM, self.yM, self.w, self.h, self.kind, self.func = xM, yM, w, h, kind, func
    
    if kind == "pic" then
      self.fore = nImg(BTNFORES .. fore .. ".png")
    else
      self.fore = fore
    end
    
    if back == "filled" or back == "empty" then
      self.back = back
    elseif back ~= nil then
      self.back = nImg(BTNBACKS .. back .. ".png")
    else
      self.back = "filled"
    end
    
    if active ~= nil then
      self.active = active
    else
      self.active = true
    end
    
    self.state = "default"
    self.parent = parent
    
    self.x = self.parent.contentX + self.xM
    self.y = self.parent.contentY + self.yM
    
    self.rightX = self.x + self.w
    self.bottomY = self.y + self.h
    self.tooltip = tooltip
    
    self.a = self.parent.a
  end
}

function Button:draw()
  
  if self.back == "filled" then
    local cl = SETTINGS.interface.baseCol
    cl[4] = self.a
    sColor(unpack(cl))
    rekt("fill", self.x, self.y, self.w, self.h)
    --if self.state ~= "clicking" and self.active then
      --sColor(255,255,255,alphize(self.a, -135))
      --rekt("fill", self.x, self.y, self.w, self.h / 20)
      --sColor(0, 0, 0, alphize(self.a, -135))
      --rekt("fill", self.x, self.y + (self.h * 0.875), self.w, self.h / 8)
    --end
    sColor(0, 0, 0, 255)
    sLineWidth(2)
    rekt("line", self.x, self.y, self.w, self.h)
    sLineWidth(1)
    if self.state == "hover" or self.state == "clicking" then
      if self.state == "hover" then
        sColor(255, 255, 255, alphize(self.a, -155))
      elseif self.state == "clicking" then
        sColor(0, 0, 0, 255)
        rekt("fill", self.x, self.y, self.w, self.h)
      end
    end
    if self.active == false then
      sColor(0, 0, 0, 255)
      rekt("fill", self.x, self.y, self.w, self.h)
    end
    resetColor()
  end
  
  if self.kind == "text" then
    local r, g, b = 255, 255, 255
    if self.state == "default" and self.active and self.parent.active then
      r, g, b = unpack(SETTINGS.font.color)
    elseif self.state == "hover" and self.active and self.parent.active then
      r, g, b = unpack(SETTINGS.font.color)
    else
      r, g, b = unpack(SETTINGS.font.activeColor)
    end
    txtF(self.fore, self.x, self.y + (self.h * 0.10), self.w, "center", r, g, b, self.a)
  elseif self.kind == "pic" then
    resetColor(self.a)
    gDraw(self.fore, self.x + (self.w - self.fore:getWidth())/2, self.y + (self.h - self.fore:getHeight())/2)
  end
  resetColor()
end

function Button:update(dt)
  self.x = self.parent.contentX + self.xM
  self.y = self.parent.contentY + self.yM
  self.a = self.parent.a
  self.rightX = self.x + self.w
  self.bottomY = self.y + self.h
  local isOverhead = self:checkForHover()
  if isOverhead and self.active and self.parent.active then 
    self:alteredState()
  else
    self.state = "default"
  end
end

function Button:checkForHover()
  local mX, mY = love.mouse.getPosition()
  if mX >= self.x and mX <= self.rightX and mY >= self.y and mY <= self.bottomY then
    return true
  else
    return false
  end
end

function Button:alteredState()
  if love.mouse.isDown(1) then
    self.state = "clicking"
  else
    self.state = "hover"
  end
end

function Button:activate()
  cursor.lock = true
  cursor.active = false
  cursor.state = "wait"
  self.func[1](self.func[2])
  Timer.after(0.05, 
    function()
      cursor.lock = false
      cursor.active = true
      cursor.state = "default"
    end
  )
end

-- Class for the player bar (basically a special menu)
PBar = Class{ __includes = Menu, 
  init = function(self, id, x, y, w, backdrop, caption, icon, items, staticH, h, stackDir)
    Menu.init(self, id, x, y, w, backdrop, caption, icon, items, staticH, h, stackDir)
    self.active = false
    self.locked = false
    self.maxW = true
  end
}

function PBar:update(dt)
  if self:checkForHover() and cursor.active and #gameEnv.data.menus == 0 then
    flux.to(self, 0.5, { y = winHeight - self.h }):oncomplete(
      function()
        self.active = true
      end
      )
  else
    self.active = false
    flux.to(self, 1, { y = winHeight - 32 })
  end
  local pbe = gameEnv.data.pbarElements
  if gameEnv.data.activePlayer.inventory[1] then
    pbe.lookInv.active = true
    pbe.useInv.active = true
  else
    pbe.lookInv.active = false
    pbe.useInv.active = false
  end
  Menu:update(dt, self)
end

-- Class for Inventory Item Display
UInv = Class{
  init = function(self, slot, parent, xMod, yMod, w, h)
    self.xMod = xMod or 0
    self.yMod = yMod or 0
    self.slot = slot
    self.parent = parent
    self.x = self.parent.x + self.xMod
    self.y = self.parent.y + self.yMod
    self.w = w or 84
    self.h = h or 84
    self.rightX = self.x + self.w
    self.bottomY = self.y + self.h
    self.a = self.parent.a
    self.tooltip = false
  end
}

function UInv:draw()
  sColor(0, 0, 0, self.a)
  rekt("fill", self.x, self.y, self.w, self.h)
  sLineWidth(3)
  sColor(255, 255, 255, alphize(self.a, -180))
  rekt("line", self.x, self.y, self.w, self.h)
  sLineWidth(1)
  if gameEnv.data.activePlayer.inventory[self.slot] then
    resetColor(self.a)
    gDraw(gameEnv.data.activePlayer.inventory[self.slot].invImg, self.x, self.y)
  end
  resetColor()
end

function UInv:update(dt)
  self.xMod = self.parent.w - 116
  self.x = self.parent.contentX + self.xMod
  self.y = self.parent.contentY + self.yMod
  self.a = self.parent.a
  self.rightX = self.x + self.w
  self.bottomY = self.y + self.h
  if gameEnv.data.activePlayer.inventory[self.slot] then
    self.tooltip = gameEnv.data.activePlayer.inventory[self.slot].name
  end
end

function UInv:checkForHover()
  local mX, mY = love.mouse.getPosition()
  if mX >= self.x and mX <= self.rightX and mY >= self.y and mY <= self.bottomY then
    return true
  else
    return false
  end
end
