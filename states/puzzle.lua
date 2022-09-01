puzzleState = {}

function puzzleState:enter(prev, puzzleID)
  puzzle = getPuzzleFromID(puzzleID)
  Timer.tween(2, fader, { alpha = 0 }, "in-out-quad", 
    function()
      cursor.lock = false
      cursor.active = true
      cursor.state = "default"
    end
  )
end

function puzzleState:draw()
  puzzle:draw()
  sColor(0, 0, 0, fader.alpha)
  rekt("fill", 0, 0, winWidth, winHeight)
  resetColor()
  drawFrameInterface()
end

function puzzleState:update(dt)
  Timer.update(dt)
  updatePuzzleCursor(dt, puzzle)
  puzzle:update(dt)
end

function puzzleState:mousereleased()
  puzzleClicks(puzzle)
end

function getPuzzleFromID(puzzleID)
  for k, puz in keySorted(gameEnv.data.currentRoom.puzInRoom) do
    if puz.id == puzzleID then
      return puz
    end
  end
  return false
end
