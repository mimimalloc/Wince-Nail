roomState = {}

function roomState:init()
  goo = buildPBar()
  if SETTINGS.audio.playBGMOnRoomInit then
    bgmPlay(SETTINGS.audio.playBGMOnRoomInit)
  end
end

function roomState:enter(prev)
  currentRoom = gameEnv.data.currentRoom
  flux.to(fader, 1, { alpha = 0 })
  flux.to(goo, 3, { y = winHeight - 32 }):ease("expoout")
  randomBGMPlay(2)
end

function roomState:draw()
  currentRoom:draw()
  sColor(0, 0, 0, fader.alpha)
  rekt("fill", 0, 0, winWidth, winHeight)
  resetColor()
  drawFrameInterface()
  drawMenus()
  goo:draw()
end

function roomState:update(dt)
  currentRoom = gameEnv.data.currentRoom
  context.text = currentRoom.name
  flux.update(dt)
  Timer.update(dt)
  updateMenus(dt)
  goo:update(dt)
  currentRoom:update(dt)
  updateCursor(dt, goo, currentRoom)
end

function roomState:keyreleased(key)
  if key == "`" and SETTINGS.debugMode then
    Gamestate.switch(debugState)
  elseif key == "r" and SETTINGS.debugMode then
    changeResolution(640, 480)
  elseif key == "escape" then
    settingsMenu()
  end
end

function roomState:mousereleased()
  checkClick(currentRoom)
  pbarClick(goo)
end