-- Class for Rooms
Room = Class{
  init = function(self, name, image, objects, puzzles, characters, exits, description)
    self.name, self.characters, self.exits = name, characters, exits
    local pz = puzzles or {}
    self.description = description or "There doesn't seem to be anything interesting about this room."
    if SETTINGS.backgroundScaling == "byHand" then
      self.image = nImg(ROOMBGS .. image .. winWidth .. "x" .. winHeight .. ".png")
    else
      self.image = nImg(ROOMBGS .. image .. ".png")
    end
    self.objInRoom = {}
    self.puzInRoom = {}
    for k, obj in keySorted(objects) do
      tPush(self.objInRoom, Object(k, obj.name, obj.description, obj.image, obj.interaction, obj.position))
    end
    for k2, puz in keySorted(pz) do
      local puzObj = tPush(self.puzInRoom, Puzzle(k, puz.name, puz.mx, puz.my, puz.mw, puz.mh, puz.solutionType, puz.solution, puz.mapImgFile, puz.bgImgFile, puz.solvedFlag, puz.solvedFunc))
      for k3, con in keySorted(puz.elements.containers) do
        puzObj:addContainer(k3, con.x, con.y, con.w, con.h, con.heldValues, con.textBased, con.imgFile)
      end
      for k4, sw in keySorted(puz.elements.switches) do
        puzObj:addSwitch(sw.linkedContainer, sw.valueMod, sw.x, sw.y, sw.w, sw.h, sw.imgFile, sw.isAnimated, sw.numFrames)
      end
      for k5, butt in keySorted(puz.elements.buttons) do
        puzObj:addButton(butt.x, butt.y, butt.w, butt.h, butt.imgFile, butt.func)
      end
    end
  end
}

-- ADD TO SEPIA ENGINE
function Room:addObject(obj)
  tPush(self.objInRoom, Object(#self.objInRoom+1, obj.name, obj.description, obj.image, obj.interaction, obj.position))
end

function Room:addPuzzle(puz)
  local puzObj = tPush(self.puzInRoom, Puzzle(#self.puzInRoom+1, puz.name, puz.mx, puz.my, puz.mw, puz.mh, puz.solutionType, puz.solution, puz.mapImgFile, puz.bgImgFile, puz.solvedFlag, puz.solvedFunc))
  for k, con in keySorted(puz.elements.containers) do
    puzObj:addContainer(k3, con.x, con.y, con.w, con.h, con.heldValues, con.textBased, con.imgFile)
  end
  for k, sw in keySorted(puz.elements.switches) do
    puzObj:addSwitch(sw.linkedContainer, sw.valueMod, sw.x, sw.y, sw.w, sw.h, sw.imgFile, sw.isAnimated, sw.numFrames)
  end
  for k, butt in keySorted(puz.elements.buttons) do
    puzObj:addButton(butt.x, butt.y, butt.w, butt.h, butt.imgFile, butt.func)
  end
end
-- DOO DEE DOO

function Room:draw()
  self:drawBackground()
  for k, obj in keySorted(self.objInRoom) do
    obj:draw()
  end
  for k, puz in keySorted(self.puzInRoom) do
    puz:draw()
  end
end

function Room:update(dt)
  for k, obj in keySorted(self.objInRoom) do
    obj:update(dt)
  end
end

function Room:drawBackground()
  if SETTINGS.backgroundScaling == "stretch" then
    gDraw(self.image, 0, 0, nil, xScale, yScale)
  elseif SETTINGS.backgroundScaling == "letterbox" then
    local x, y = 0, 0
    local w = self.image:getWidth()
    local h = self.image:getHeight()
    if w < winWidth then x = (winWidth-w)/2 end
    if h < winHeight then y = (winHeight-h)/2 end
    gDraw(self.image, x, y)
  else
    gDraw(self.image, 0, 0)
  end
end

function Room:getIdOfInhabitant(name)
  for k, char in keySorted(self.characters) do
    if char.name == name then
      return k
    end
  end
  return false
end

