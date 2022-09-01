-- Class for Puzzles
Puzzle = Class{
  init = function(self, id, name, mx, my, mw, mh, solutionType, solution, mapImgFile, bgImgFile, solvedFlag, solvedFunc)
    self.id, self.name, self.mx, self.my, self.mw, self.mh, self.solutionType, self.solution, self.mapImgFile, self.bgImgFile, self.solvedFlag, self.solvedFunc = id, name, mx, my, mw, mh, solutionType, solution, mapImgFile, bgImgFile, solvedFlag, solvedFunc
    self.mapImg = nImg( PZMAP .. self.mapImgFile .. ".png")
    self.bgImg = nImg( PZBG .. self.bgImgFile .. ".png")
    self.elements = {}
    self.elements.containers = {}
    self.elements.switches = {}
    self.elements.buttons = {}
    self.solved = false
  end
}

function Puzzle:addContainer(id, x, y, w, h, heldValues, textBased, imgFile)
  tPush(self.elements.containers, PContainer(id, x, y, w, h, heldValues, textBased, imgFile))
end

function Puzzle:addSwitch(linkedContainerID, valueMod, x, y, w, h, imgFile, isAnimated, numFrames)
  tPush(self.elements.switches, PSwitch(linkedContainerID, valueMod, x, y, w, h, imgFile, isAnimated, numFrames))
end

function Puzzle:addButton(x, y, w, h, imgFile, func)
  tPush(self.elements.buttons, PButton(x, y, w, h, imgFile, func))
end

function Puzzle:checkForHover()
  if Gamestate.current() == roomState and self.solved == false then
    local moX, moY = love.mouse.getPosition()
    local r = self.mx + self.mw
    local b = self.my + self.mh
    if moX >= self.mx and moX <= r and moY >= self.my and moY <= b then
      return true
    else
      return false
    end
  else
    return false
  end
end


function Puzzle:draw()
  if Gamestate.current() == roomState then
    resetColor()
    gDraw(self.mapImg, self.mx, self.my)
  elseif Gamestate.current() == puzzleState then
    resetColor()
    gDraw(self.bgImg, 0, 0)
    for k, container in keySorted(self.elements.containers) do
      container:draw()
    end
    for k, switch in keySorted(self.elements.switches) do
      switch:draw()
    end
    for k, button in keySorted(self.elements.buttons) do
      button:draw()
    end
  end
end

function Puzzle:update(dt)
  if Gamestate.current() == puzzleState then
    for k, switch in keySorted(self.elements.switches) do
      switch:update(dt)
    end
    for k, button in keySorted(self.elements.buttons) do
      button:update(dt)
    end
  end
end

function Puzzle:checkSolved()
  if self.solutionType == "number" then
    local sum = 0
    for k, container in keySorted(self.elements.containers) do
      sum = sum + container.currentValue
    end
    if sum == self.solution then
      sPlay("succeed")
      self:solve()
    else
      sPlay("fail")
    end
  elseif self.solutionType == "string" then
    local str = ""
    for k, container in keySorted(self.elements.containers) do
      str = str .. container.currentValue
    end
    if str == self.solution then
      sPlay("succeed")
      self:solve()
    else
      sPlay("fail")
    end
  end
end

function Puzzle:solve()
  self.solved = true
  cursor.lock = true
  cursor.active = false
  cursor.state = "wait"
  mPlay("puzzleComplete")
  Timer.after(5, 
    function()
      Timer.tween(1, fader, { alpha = 255 }, nil, 
        function()
          Gamestate.switch(roomState)
          cursor.lock = false
          cursor.active = true
          cursor.state = "default"
          gameEnv.data.flags[self.solvedFlag] = true
          Timer.after(0.2, 
            function()
              self.solvedFunc()
            end
          )
        end
      )
    end
  )
end

-- Class for Containers (that hold the values that add to the solution)
PContainer = Class{
  init = function(self, id, x, y, w, h, heldValues, textBased, imgFile)
    self.id, self.x, self.y, self.w, self.h, self.heldValues, self.textBased, self.imgFile = id, x, y, w, h, heldValues, textBased, imgFile
    self.currentSlot = 1
    self.currentValue = self.heldValues[self.currentSlot]
    self.image = nImg(PZCONT .. self.imgFile .. ".png")
    if not textBased then
      self.stateQuad = {}
      for i=1, #heldValues do
        -- Builds all of the quads for the container
        self.stateQuad[i] = nQuad((i-1)*self.w, 0, self.w, self.h, self.image:getDimensions())
      end
    end
  end
}

function PContainer:draw()
  if self.textBased then
    resetColor()
    gDraw(self.image, self.x, self.y)
    txtF(self.currentValue, self.x, self.y + self.h*0.5-12, self.w, "center")
  else
    resetColor()
    gDraw(self.image, self.stateQuad[self.currentSlot], self.x, self.y)
  end
end

function PContainer:shift(mod)
  local landsOnValue = self.currentSlot + mod
  while landsOnValue < 1 do
    landsOnValue = landsOnValue + #self.heldValues
  end
  while landsOnValue > #self.heldValues do
    landsOnValue = landsOnValue - #self.heldValues
  end
  self.currentSlot = landsOnValue
  self.currentValue = self.heldValues[self.currentSlot]
end

-- Class for Switches (that alter the "current value" of the associated container)
PSwitch = Class{
  init = function(self, linkedContainerID, valueMod, x, y, w, h, imgFile, isAnimated, numFrames)
    self.linkedContainerID, self.valueMod, self.x, self.y, self.w, self.h, self.imgFile, self.isAnimated, self.numFrames = linkedContainerID, valueMod, x, y, w, h, imgFile, isAnimated, numFrames
    self.image = nImg(PZSWITCH .. self.imgFile .. ".png")
    if self.isAnimated then
      -- Builds the animation frames.
      self.animQuad = {}
      for i=1, numFrames do
        self.animQuad[i] = nQuad((i-1)*self.w, 0, self.w, self.h, self.image:getDimensions())
      end
      self.frame = 1
      self.animating = false
    end
  end
}

function PSwitch:draw()
  if self.isAnimated then
    love.graphics.draw(self.image, self.animQuad[self.frame], self.x, self.y)
  else
    gDraw(self.image, self.x, self.y)
  end
end

function PSwitch:update(dt)
end

function PSwitch:checkForHover()
  local moX, moY = love.mouse.getPosition()
  local r = self.x + self.w
  local b = self.y + self.h
  if moX >= self.x and moX <= r and moY >= self.y and moY <= b then
    return true
  else
    return false
  end
end

function PSwitch:activate(puzzle)
  local container = puzzle.elements.containers[self.linkedContainerID]
  container:shift(self.valueMod)
  cursor.lock = true
  cursor.active = false
  cursor.state = "wait"
  sPlay("switch")
  Timer.every(0.05, function() self.frame = self.frame + 1 end, self.numFrames-1)
  Timer.after(0.1*(self.numFrames-1), 
    function()
      self.frame = 1
      cursor.lock = false
      cursor.active = true
      cursor.state = "default"
    end
  )
end

-- Class for Buttons (special puzzle-specific buttons that can have a custom function, including checking the puzzle is solved)
PButton = Class{
  init = function(self, x, y, w, h, imgFile, func)
    self.x, self.y, self.w, self.h, self.imgFile, self.func = x, y, w, h, imgFile, func
    self.image = nImg(PZBUTT .. self.imgFile .. ".png")
    self.state = "default"
    -- All buttons should have 2 states - default, and pressed. The image should have 2 quads representing each state.
    self.stateQuad = {}
    self.stateQuad.default = nQuad(0, 0, self.w, self.h, self.image:getDimensions())
    self.stateQuad.pressed = nQuad(self.w, 0, self.w, self.h, self.image:getDimensions())
  end
}

function PButton:update(dt)
  if self:checkForHover() and love.mouse.isDown(1) then
    self.state = "pressed"
  else
    self.state = "default"
  end
end

function PButton:draw()
  gDraw(self.image, self.stateQuad[self.state], self.x, self.y)
end

function PButton:checkForHover()
  local moX, moY = love.mouse.getPosition()
  local r = self.x + self.w
  local b = self.y + self.h
  if moX >= self.x and moX <= r and moY >= self.y and moY <= b then
    return true
  else
    return false
  end
end

function PButton:activate(puzzle)
  sPlay("button2")
  self.func(puzzle)
end
