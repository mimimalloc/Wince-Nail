-- Updates all current menus
function updateMenus(dt)
  local menny = gameEnv.data.menus
  for k, menu in keySorted(menny) do
    menu:update(dt)
    if not menu.activeStateLocked then menu.active = false end
  end
  if #menny > 0 and not menny[#menny].activeStateLocked then menny[#menny].active = true end
end

-- Updates the cursor state during puzzles
function updatePuzzleCursor(dt, puzzle)
  cursor.x = love.mouse.getX()
  cursor.y = love.mouse.getY()
  
  if cursor.active and cursor.lock == false and cursor.y > winHeight * 0.80 then
    cursor.state = "moveS"
    context.text = "Turn Back"
  else
    if cursor.active == true then
      cursor.state = "default"
    else
      cursor.state = "wait"
    end
    context.text = puzzle.name
  end
  
  for k, switch in keySorted(puzzle.elements.switches) do
    if switch:checkForHover()  and cursor.lock == false and cursor.active then
      cursor.state = "menu"
    end
  end
  
  for k, button in keySorted(puzzle.elements.buttons) do
    if button:checkForHover() and cursor.lock == false and cursor.active then
      cursor.state = "menu"
    end
  end
  
  love.mouse.setCursor(cursor.images[cursor.state])
end

-- Updates the cursor state
function updateCursor(dt, gui, room)
  local menny = gameEnv.data.menus
  cursor.x = love.mouse.getX()
  cursor.y = love.mouse.getY()
  
  if cursor.active and #menny == 0 and cursor.lock == false and not gui.active then
    if cursor.y < winHeight * 0.20 and room.exits.n and room.exits.n.locked == false then
      cursor.state = "moveN"
      context.text = "Move Forward"
    elseif cursor.y > winHeight * 0.80 and room.exits.s and room.exits.s.locked == false then
      cursor.state = "moveS"
      context.text = "Turn Around"
    elseif cursor.x < winWidth * 0.20 and room.exits.w and room.exits.w.locked == false then
      cursor.state = "moveW"
      context.text = "Turn Left"
    elseif cursor.x > winWidth * 0.80 and room.exits.e and room.exits.e.locked == false then
      cursor.state = "moveE"
      context.text = "Turn Right"
    else
      cursor.state = "default"
    end
    
    for k, obj in keySorted(room.objInRoom) do
      if obj:checkForHover() then
        cursor.state = "object"
        context.text = obj.name
      end
    end
    
    for k, puz in keySorted(room.puzInRoom) do
      if puz:checkForHover() then
        cursor.state = "menu"
        context.text = puz.name
      end
    end
    
  elseif cursor.active and #menny > 0 and cursor.lock == false and not gui.active then
    local anyHovers = false
    local tooltip = false
    for k, menu in keySorted(menny) do
      if menu.active then
        for k2, item in keySorted(menu.container) do
          if item:checkForHover() then
            anyHovers = true
            tooltip = item.tooltip or false
          end
        end
      end
    end
    if anyHovers == true then
      cursor.state = "menu"
      if tooltip ~= false then context.text = tooltip end
    else
      cursor.state = "default"
    end
  elseif cursor.active and cursor.lock == false and gui.active then
    local anyHovers = false
    local tooltip = false
    for k, item in keySorted(gui.container) do
      if item:checkForHover() then
        anyHovers = true
        tooltip = item.tooltip or false
      end
    end
    if anyHovers == true then
      cursor.state = "menu"
      if tooltip ~= false then context.text = tooltip end
    else
      cursor.state = "default"
    end
  elseif cursor.active and cursor.lock == false then
    cursor.state = "default"
  end 
  
  love.mouse.setCursor(cursor.images[cursor.state])
end
