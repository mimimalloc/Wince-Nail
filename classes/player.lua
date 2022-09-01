Characters = Class{
  init = function(self, startingCharacters)
    self.container = startingCharacters or {}
  end 
}

function Characters:getNameOf(id)
  for k, char in keySorted(self.container) do
    if k == id then
      return char.name
    end
  end
  return "Nobody"
end

function Characters:getIdOf(name)
  for k, char in keySorted(self.container) do
    if char.name == name then
      return k
    end
  end
  return false
end

function Characters:add(character)
  self.container[#self.container+1] = character
end

function Characters:remove(id)
  self.container[k] = nil
end

function Characters:activate(id)
  for k, char in keySorted(self.container) do
    char.active = false
  end
  self.container[id].active = true
end

function Characters:getActiveCharacter()
  for k, char in keySorted(self.container) do
    if char.active then
      return char
    end
  end
  return false
end

Player = Class{
  init = function(self, name, room, portrait, active, inventory, abilities)
    self.name = name or "Yma DeFault"
    self.room = room or 1
    
    if portrait then
      self.portrait = nImg(PORTRAITS .. portrait .. ".png")
    else
      self.portrait = nImg(PORTRAITS .. "default.png")
    end
    
    self.active = active or false
    
    self.inventory = inventory or {}
    self.selectable = true
    self.abilities = abilities or {}
  end
}

function Player:declareInventory()
  if #self.inventory == 0 then
    return "Nothing"
  else
    local str = ""
    for k, item in keySorted(self.inventory) do
      str = str .. "* " .. item.name .. "\n"
      if k == 5 then
        str = str .. "...and more"
        break
      end
    end
    return str
  end
end
