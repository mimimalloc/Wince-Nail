Game = Class{
  init = function(self, slot, data)
    self.saveSlot = slot
    self.data = data or {}    
  end
}

function Game:initRooms()
  self.data.rooms = {}
  for k, room in keySorted(ROOMS) do
    self.data.rooms[k] = Room(room.name, room.image, room.objects, room.puzzles, room.characters, room.exits, room.description)
  end
  self.data.currentRoom = self.data.rooms[SETTINGS.initialPlayer.startingRoom]
  ROOMS = nil
end

function Game:initPlayer()
  self.data.chars = Characters()
  local chs = self.data.chars
  local default = SETTINGS.initialPlayer
  local player = Player(default.name, default.startingRoom, default.portrait, true, default.inventory, default.abilities)
  chs:add(player)
  local defaultRoomChars = self.data.rooms[default.startingRoom].characters
  local inc = #defaultRoomChars+1
  defaultRoomChars[inc] = player
end
