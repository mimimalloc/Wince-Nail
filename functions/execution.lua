-- Changes the game's current resolution
function changeResolution(width, height)
  winWidth, winHeight = width, height
  xScale = width/SETTINGS.resolution.width
  yScale = height/SETTINGS.resolution.height
  xOffset = width - SETTINGS.resolution.width
  yOffset = height - SETTINGS.resolution.height
  gameEnv.data.gui = nil
  love.window.setMode( winWidth, winHeight )
  buildPBar()
end

-- Adds a menu and returns its reference
function newMenu(x, y, w, backdrop, caption, icon, items, staticH, h, stackDir)
  local gameMenus = gameEnv.data.menus
  local newID = menuID()
  gameMenus[newID] = Menu(newID, x, y, w, backdrop, caption, icon, items, staticH, h, stackDir)
  return gameMenus[newID]
end

-- Saves the game data to slot, as well as a summary
function saveGame()
  local lady = require 'files.lady'
  local game = lady.register_class(Class{}, 'Game')
  lady.save_all("save" .. gameEnv.saveSlot, gameEnv)
  --[[ local summary = {
    character = gameEnv.data.activePlayer,
    area = gameEnv.data.currentRoom.name
  }
  love.filesystem.write("summary" .. gameEnv.saveSlot, serialize(summary))
  --]]
  simpleDiag("Game has been saved to slot " .. gameEnv.saveSlot .. ".", "Saved", "info")
end

-- Loads the game data from a slot
function loadGame(slot)
  if love.filesystem.exists( "save" .. slot) then
    local lady = require 'files.lady'
    local save = lady.load_all( "save" .. slot )
    return save
    --gameEnv = save()
    --Gamestate.switch(roomState, gameEnv.data.activePlayer.room)
  else
    simpleDiag("Hopefully you didn't try to load a file that doesn't exist.", "Wow", "info")
  end
end

-- Generates the Player Bar
function buildPBar()
  gameEnv.data.gui = PBar(0, 0, winHeight, winWidth, "filled", gameEnv.data.activePlayer.name, nil, nil, true, 150, "horizontal")
  goo = gameEnv.data.gui
  gameEnv.data.pbarElements = {}
  local pbe = gameEnv.data.pbarElements
  pbe["portrait"] = goo:addPicture(gameEnv.data.activePlayer.portrait, true)
  local xS = 94
  pbe["look"] = goo:addPicButt({btnLookRoom}, "look", "filled", 42, 42, xS, nil, nil, "Observe Room")
  xS = xS + 52
  pbe["changeCharacter"] = goo:addPicButt({btnDummy}, "character", "filled", 42, 42, xS, nil, false, "Change Character")
  xS = xS + 52
  pbe["settings"] = goo:addPicButt({btnSettings}, "settings", "filled", 42, 42, xS, nil, nil, "Settings")
  xS = 94
  pbe["ability1"] = goo:addPicButt({btnDummy}, "ability", "filled", 42, 42, xS, 42, false, "Ability 1")
  xS = xS + 52
  pbe["ability2"] = goo:addPicButt({btnDummy}, "ability", "filled", 42, 42, xS, 42, false, "Ability 2")
  xS = xS + 52
  pbe["ability3"] = goo:addPicButt({btnDummy}, "ability", "filled", 42, 42, xS, 42, false, "Ability 3")
  pbe["invPanel"] = goo:addInvDisplay(1, nil, goo.w - 116)
  local item = gameEnv.data.activePlayer.inventory[1] or { name = "Nothingness" }
  pbe["lookInv"] = goo:addPicButt({btnLookInv}, "lookInv", "filled", 42, 42, goo.w - 172, nil, false, "Look at " .. item.name)
  pbe["useInv"] = goo:addPicButt({btnUseInv}, "use", "filled", 42, 42, goo.w - 172, 42, false, "Use " .. item.name)
  manageAbilityButton(1)
  manageAbilityButton(2)
  manageAbilityButton(3)
  return goo
end

-- Manages the state of ability buttons
function manageAbilityButton(bNum)
  local pbe = gameEnv.data.pbarElements
  local char = gameEnv.data.activePlayer
  if char.abilities[bNum] then
    pbe["ability"..bNum].func = {btnAbility, bNum}
    pbe["ability"..bNum].tooltip = "Ability: " .. char.abilities[bNum].name
    pbe["ability"..bNum].fore = nImg(BTNFORES .. char.abilities[bNum].image .. ".png")
    pbe["ability"..bNum].active = true
  end
end

-- Creates an object menu on click of the object
function buildObjMenu(obj)
  local mx = obj.tX + obj.tW/2 - 68
  local my = obj.tY + obj.tH/2
  local toMY = my - obj.tH/2.5
  local inv = gameEnv.data.activePlayer.inventory
  local useOnTooltip = "No Item"
  if #inv > 0 then
    useOnTooltip = "Use " .. inv[1].name .. " on " .. obj.name
  end
  local objMenu = newMenu(mx, my, 120, "empty", nil, nil, nil, true, 32, "horizontal")
  objMenu:addPicButt({btnLookObjectGround, {objMenu, obj}}, "look", nil, 32, 32, -16, -16, nil, "Look at " .. obj.name)
  --(buttFunc, buttFore, buttBack, buttW, buttH, bXM, bYM, active, tooltip)
  objMenu:addPicButt({btnManipulateObjectGround, {objMenu, obj}}, "use", nil, 32, 32, 18, -16, nil, "Get/Use " .. obj.name)
  objMenu:addPicButt({btnCombineObjects, {objMenu, obj}}, "combine", nil, 32, 32, 52, -16, false, useOnTooltip)
  objMenu:addPicButt({btnDismiss, objMenu}, "cancel", nil, 32, 32, 86, -16, nil, "Never Mind")
  objMenu.a = 0
  objMenu.activeStateLocked = true
  objMenu.active = false
  if #inv > 0 then objMenu.container[3].active = true end
  flux.to(objMenu, 0.5, { y = toMY, a = 255 }):oncomplete(
    function()
      objMenu.active = true
      objMenu.activeStateLocked = false
    end
  )
end

-- Creates a basic dialogue box as a menu
function simpleDiag(text, caption, icon)
  local diag = newMenu(0, 0, 480, "filled", caption, icon)
  local w = 0
  if icon then
    w = 440 - diag.icon:getWidth()
  else
    w = 440
  end
  local h = string.len(text) * 0.75 + 24
  local counter = text
  local _, count = string.gsub(counter, "%\n", "")
  h = h + count*14 + 16
  diag:addText(text, true, w, h, "left")
  diag:addTextButt({btnDismiss, diag}, "OK")
  local centeredX = (winWidth - diag.w)/2
  local centeredY = (winHeight - diag.h)/2
  diag.x = centeredX
  diag.y = centeredY
end

-- Creates the Settings menu
function settingsMenu()
  local settings = newMenu(winWidth/4, 0, winWidth/2, "filled", "Settings")
  settings:addTextButt({btnDummy}, "Save Game", nil, nil, nil, nil, nil, false)
  settings:addTextButt({btnDummy}, "Load Game", nil, nil, nil, nil, nil, false)
  settings:addTextButt({btnConfirmQuit}, "Quit Game")
  settings:addTextButt({btnDummy}, "Audio Settings", nil, nil, nil, nil, nil, false)
  settings:addTextButt({btnDummy}, "Display Settings", nil, nil, nil, nil, nil, false)
  settings:addTextButt({btnDismiss, settings}, "Return to Game")
  settings.y = (winHeight - settings.h)/2
end

-- Creates an OK/Cancel dialogue box
function queryDiag(text, caption, okFunc, params, icon)
  local diag = newMenu(0, 0, 480, "filled", caption, icon)
  local w = 0
  if icon then
    w = 440 - diag.icon:getWidth()
  else
    w = 440
  end
  local h = string.len(text) * 0.75 + 24
  local counter = text
  local _, count = string.gsub(counter, "%\n", "")
  h = h + count*8 + 32
  diag:addText(text, true, w, h, "left")
  diag.stackDir = "horizontal"
  diag.h = diag.h + 48
  diag:addTextButt({okFunc, {diag, params}}, "OK", nil, w/2-8)
  diag:addTextButt({btnDismiss, diag}, "Cancel", nil, w/2-8)
  local centeredX = (winWidth - diag.w)/2
  local centeredY = (winHeight - diag.h)/2
  diag.x = centeredX
  diag.y = centeredY
  return diag
end

-- Assigns the ID for a menu so it will be taken in
function menuID()
  return #gameEnv.data.menus+1
end

-- Destroys a menu
function destroyMenu(menu)
  gameEnv.data.menus[menu.id] = nil
end

function destroyTopMenu()
  gameEnv.data.menus[#gameEnv.data.menus] = nil
end


-- Returns the ID of the active player (in the Characters collection)
function activePlayerID()
  local playername = gameEnv.data.activePlayer.name
  return gameEnv.data.chars:getIdOf(playername)
end

-- Moves the player into a new room
function movePlayer(player, room, newRoomID)
  cursor.lock = true
  cursor.active = false
  cursor.state = "wait"
  sPlay("step")
  flux.to(fader, 1, { alpha = 255 }):oncomplete(
    function()
      local playerID = room:getIdOfInhabitant(player.name)
      local newRoom = gameEnv.data.rooms[newRoomID]
      player.room = newRoomID
      room.characters[playerID] = nil
      newRoom.characters[#newRoom.characters+1] = player
      gameEnv.data.currentRoom = newRoom
      flux.to(fader, 1, { alpha = 0 }):oncomplete(
        function()
          randomBGMPlay(8)
          cursor.active = true
          cursor.lock = false
          cursor.state = "default"
        end
      )
    end
  )
end

-- Attempts to manipulate an object on the ground
function manipulateObject(object)
  local inv = gameEnv.data.activePlayer.inventory
  -- NOTE: add interactions as they are made
  if object.interactions.pickUp then
    if SETTINGS.inventoryMode == "oneItem" then
      if #inv == 0 then
        pickUpItem(object)
      else
        swapItem(object)
      end
    else
      pickUpItem(object)
    end
  elseif object.interactions.use then
    object.interactions.use()
  end
end

-- Picks up an object from the ground
function pickUpItem(object)
  local roomObjs = gameEnv.data.currentRoom.objInRoom
  roomObjs[object.id] = nil
  tPush(gameEnv.data.activePlayer.inventory, object)
  simpleDiag(object.interactions.pickUp.message, "Got " .. object.name, "use")
  sPlay("use1")
end

-- Asks whether to swap current item for one on the ground
function swapItem(object)
  local inv = gameEnv.data.activePlayer.inventory
  queryDiag("Exchange your " .. inv[1].name .. " for the " .. object.name .. "?", "Swap?", btnSwap, {object}, "use")
end

function roomID(givenRoom)
  for k, room in keySorted(gameEnv.data.rooms) do
    if room == givenRoom then
      return k
    end
  end
  return false
end
