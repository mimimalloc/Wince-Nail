-- Dummy button that will not do anything
btnDummy = function() end

-- This button will exit the game
btnQuit = function() love.event.quit() end

btnNewGame = function(parent)
  destroyMenu(parent)
  cursor.state = "wait"
  love.mouse.setCursor( cursor.images.wait )
  Timer.tween(1, fader, { alpha = 255 }, 'in-out-quad', 
    function()
      love.audio.stop(music.title)
      Gamestate.switch(cutScene, 1)
    end
  )
end

-- Save the game
btnSaveGame = function()
  saveGame()
end

-- This button will ask for confirmation before exiting the game
btnConfirmQuit = function()
  queryDiag("Are you sure you want to quit?", "End Game?", btnQuit, nil, "info")
end

-- Dismisses the button's menu, removing it from the menu stack
btnDismiss = function(parent)
  destroyMenu(parent)
end

-- This button will load the room state of the active character's current room. It destroys the menu.
btnGoToActiveRoom = function(parent)
  Gamestate.switch(roomState, gameEnv.data.activePlayer.room)
  destroyMenu(parent)
end

-- When an object on the ground is looked at
btnLookObjectGround = function(data)
  destroyMenu(data[1])
  simpleDiag(data[2].groundDescription, "Observations", "look")
end

-- When an object on the ground is interacted with
btnManipulateObjectGround = function(data)
  destroyMenu(data[1])
  manipulateObject(data[2])
end

-- Look at object in inventory
btnLookInv = function()
  local item = gameEnv.data.activePlayer.inventory[1]
  sPlay("message")
  simpleDiag(item.invDescription, item.name, "look")
end

-- Use object in inventory
btnUseInv = function()
  local item = gameEnv.data.activePlayer.inventory[1]
  if item.interactions.useInv then
    if item.interactions.useInv.message then
      simpleDiag(item.interactions.useInv.message, item.name, "use")
    end
    sPlay("succeed")
    item.interactions.useInv.activate()
  else
    sPlay("fail")
    simpleDiag("You can't think of a use for this thing just yet.", "Interesting...", "use")
  end
end

-- OKs a swap between an item on the ground and one in the inventory
btnSwap = function(data)
  destroyMenu(data[1])
  local groundObject = data[2][1]
  local inv = gameEnv.data.activePlayer.inventory
  local invItem = inv[1]
  local roomItems = gameEnv.data.currentRoom.objInRoom
  inv[1] = groundObject
  roomItems[groundObject.id] = invItem
  roomItems[groundObject.id].id = groundObject.id
  roomItems[groundObject.id].x = groundObject.x + (inv[1].w - groundObject.w)
  roomItems[groundObject.id].y = groundObject.y + (inv[1].h - groundObject.h)
  simpleDiag(groundObject.interactions.pickUp.message, "Got " .. groundObject.name, "use")
end

-- Activates a character's ability
btnAbility = function(ability)
  local char = gameEnv.data.activePlayer
  char.abilities[ability].activate()
end

-- Checks and attempts to combine inventory and ground object
btnCombineObjects = function(data)
  destroyMenu(data[1])
  local invItem = gameEnv.data.activePlayer.inventory[1]
  local groundObject = data[2]
  if invItem.interactions.combine then
    if invItem.interactions.combine[groundObject.name] then
      simpleDiag(invItem.interactions.combine[groundObject.name].message, "Success", "use")
      invItem.interactions.combine[groundObject.name].activate(groundObject)
    else
      simpleDiag("You can't seem to use these objects together.", "Failure", "use")
    end
  else
    simpleDiag("You can't seem to use these objects together.", "Failure", "use")
  end
  
end

-- Gives the room's description
btnLookRoom = function()
  simpleDiag(gameEnv.data.currentRoom.description, gameEnv.data.currentRoom.name, "look")
end

-- Opens the settings menu
btnSettings = function()
  settingsMenu()
end


btnMenu001 = function()
  queryDiag("You seem to be in an abstract hellscape of some sort. All around you are flashes of light and blobs of solid energy that bounce every which way as you stare at them. A fiendish hellscraper is looking in your direction.\n\nThere is no escape, but you can see a rope on the ground.\n\nThere's also a yellow key made of skeletons.", "what is this even", btnQuit, nil, "info")
end
