debugState = {}

function debugState:init()
  gameEnv:initRooms()
  gameEnv:initPlayer()
  gameEnv.data.menus = {}
  gameEnv.data.activePlayer = gameEnv.data.chars:getActiveCharacter()
end

function debugState:enter(prev)
  local gameMenus = gameEnv.data.menus
  debugMenu = newMenu(winWidth/2, 0, winWidth/2, "filled", "Select a Debug Option", nil, nil, true, winHeight)
  debugMenu:addTextButt({btnMenu001}, "Game Initialization")
  debugMenu:addTextButt({btnDummy}, "Teleport to a Room", nil, nil, nil, nil, nil, false)
  debugMenu:addTextButt({btnDummy}, "Change to Another Character", nil, nil, nil, nil, nil, false)
  debugMenu:addTextButt({btnDummy}, "Manage Inventory", nil, nil, nil, nil, nil, false)
  debugMenu:addTextButt({btnGoToActiveRoom, debugMenu}, "Proceed with Game")
  debugMenu:addTextButt({btnConfirmQuit}, "Quit to OS", nil, nil, nil, nil, debugMenu:bottom(24))
  debugMenu.a = 0
  debugMenu.active = false
  flux.to(debugMenu, 1, { a = 255 }):oncomplete(function() debugMenu.active = true end)
end

function debugState:draw()
  sFont(bigFont)
  txtF("SEPIA Engine Debug Menu", 0, 20, winWidth/2, "center")
  sFont(mainFont)
  local ch = gameEnv.data.activePlayer
  txtF(ch.name, 0, 92, winWidth/2, "center")
  gDraw(ch.portrait, imgXBetween(ch.portrait, 0, winWidth/2), 118)
  txtF("Currently in Room " .. ch.room, 0, 256, winWidth/2, "center")
  txtF(gameEnv.data.rooms[ch.room].name, 0, 282, winWidth/2, "center")
  txtF("Currently Carrying:", 8, 320, winWidth/2 - 16, "left")
  local invStr = ch:declareInventory()
  txtF(invStr, 16, 352, winWidth/2 - 32, "left")
  drawMenus()
end

function debugState:update(dt)
  updateMenus(dt)
  flux.update(dt)
end

function debugState:mousereleased()
  checkClick()
  pbarClick()
end
