-- Checks through clickable elements
function checkClick(room)
  for k1, menu in keySorted(gameEnv.data.menus) do
    if menu.active then
      for k2, item in keySorted(menu.container) do
        if item.active then
          if item:checkForHover() then
            sPlay("button")
            item:activate()
          end
        end
      end
    end
  end
  
  for k, puzzle in keySorted(gameEnv.data.currentRoom.puzInRoom) do
    if puzzle:checkForHover() and #gameEnv.data.menus == 0 and cursor.active then
      cursor.lock = true
      cursor.active = false
      cursor.state = "wait"
      sPlay("event")
      Timer.tween(0.9, gameEnv.data.gui, { y = winHeight + 80 })
      Timer.tween(1, fader, { alpha = 255 }, "in-out-quad", 
        function()
          love.audio.stop()
          Gamestate.switch(puzzleState, puzzle.id)
        end
      )
    end
  end
  
  if cursor.state == "object" then
    local lastObjInStack = false
    for k, obj in keySorted(room.objInRoom) do
      if obj:checkForHover() then
        lastObjInStack = obj
      end
    end
    if lastObjInStack ~= false then
      buildObjMenu(lastObjInStack)
    end
  end
  moveQuery(room)
end

-- The player bar is a loose cannon that plays by its own rules
function pbarClick(pbar)
  if pbar then
    if pbar.active then
      for k, item in keySorted(pbar.container) do
        if item.active then
          if item:checkForHover() then
            sPlay("button")
            item:activate()
          end 
        end
      end
    end
  end
end

-- Checks if the conditions for moving to another room are met, and moves if true
function moveQuery(room)
  if cursor.state == "moveN" then
    local go = currentRoom.exits.n.to
    movePlayer(gameEnv.data.activePlayer, room, go)
  elseif cursor.state == "moveS" then
    local go = currentRoom.exits.s.to
    movePlayer(gameEnv.data.activePlayer, room, go)
  elseif cursor.state == "moveW" then
    local go = currentRoom.exits.w.to
    movePlayer(gameEnv.data.activePlayer, room, go)
  elseif cursor.state == "moveE" then
    local go = currentRoom.exits.e.to
    movePlayer(gameEnv.data.activePlayer, room, go)
  end
end

-- Checks clicks during the puzzle state
function puzzleClicks(puzzle)
  if cursor.state == "moveS" then
    cursor.active = false
    cursor.lock = true
    cursor.state = "wait"
    Timer.tween(1, fader, { alpha = 255 }, "in-out-quad",
      function()
        Gamestate.switch(roomState)
        cursor.active = true
        cursor.lock = false
        cursor.state = "default"
      end
    )
  end
  
  for k, switch in keySorted(puzzle.elements.switches) do
    if switch:checkForHover() and cursor.active then
      switch:activate(puzzle)
    end
  end
  
  for k, button in keySorted(puzzle.elements.buttons) do
    if button:checkForHover() and cursor.active then
      button:activate(puzzle)
    end
  end
end
