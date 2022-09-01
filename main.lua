function love.load(arg)
  Class = require "hump.class"
  Gamestate = require "hump.gamestate"
  Timer = require "hump.timer"
  flux = require "animation.flux"
  loadDir("functions")
  loadDir("data")
  loadDir("classes")
  loadDir("states")
  love.graphics.setDefaultFilter( "nearest", "nearest", 1 )
  
  mainFont = nFont(SETTINGS.font.file, SETTINGS.font.midSize)
  bigFont = nFont(SETTINGS.font.file, SETTINGS.font.largeSize)
  hugeFont = nFont(SETTINGS.font.file, SETTINGS.font.hugeSize)
  smallFont = nFont(SETTINGS.font.file, SETTINGS.font.smallSize)
  sFont(mainFont)
  corners = {
    lcorner = nImg("images/ui/lcorner.png"),
    rcorner = nImg("images/ui/rcorner.png")
  }
  cutscene = false
  imgStack = false
  cutscenetext = false
  
  winWidth, winHeight = love.window.getMode()
  xScale = winWidth/SETTINGS.resolution.width
  yScale = winHeight/SETTINGS.resolution.height
  xOffset = winWidth - SETTINGS.resolution.width
  yOffset = winHeight - SETTINGS.resolution.height
  
  gameEnv = Game(0)
  gameEnv.data.flags = {}
  
  characters = 0
  
  fader = { alpha = 255 }
  
  sound = {
    button = love.audio.newSource(SFX .. "button.wav", "static"),
    button2 = love.audio.newSource(SFX .. "button.wav", "static"),
    event = love.audio.newSource(SFX .. "event1.wav", "static"),
    message = love.audio.newSource(SFX .. "message.wav", "static"),
    step = love.audio.newSource(SFX .. "step.wav", "static"),
    switch = love.audio.newSource(SFX .. "switch.wav", "static"),
    use1 = love.audio.newSource(SFX .. "use.wav", "static"),
    use2 = love.audio.newSource(SFX .. "use1.wav", "static"),
    succeed = love.audio.newSource(SFX .. "succeed.wav", "static"),
    fail = love.audio.newSource(SFX .. "fail.wav", "static"),
    activated = love.audio.newSource(SFX .. "activated.wav", "static"),
  }
  
  music = {
    title = love.audio.newSource(MUSIC .. "wincenail.ogg", "stream"),
    puzzleComplete = love.audio.newSource(MUSIC .. "ditty.ogg", "stream"),
    bg = {
      [1] = love.audio.newSource(MUSIC .. "wince.ogg", "stream"),
      [2] = love.audio.newSource(MUSIC .. "justtemporally.ogg", "stream"),
      [3] = love.audio.newSource(MUSIC .. "wincenail.ogg", "stream")
    }
  }

  cursor = {
    x = love.mouse.getX(),
    y = love.mouse.getY(),
    active = true,
    state = "default",
    lock = false,
    images = {
      default = love.mouse.newCursor( CURSORS .. "default.png", 7, 2 ),
      wait = love.mouse.newCursor( CURSORS .. "wait.png", 19, 25 ),
      moveN = love.mouse.newCursor( CURSORS .. "moveN.png", 8, 3 ),
      moveS = love.mouse.newCursor( CURSORS .. "moveS.png", 8, 22 ),
      moveE = love.mouse.newCursor( CURSORS .. "moveE.png", 22, 8 ),
      moveW = love.mouse.newCursor( CURSORS .. "moveW.png", 3, 8 ),
      object = love.mouse.newCursor( CURSORS .. "object.png", 22, 8),
      menu = love.mouse.newCursor( CURSORS .. "menu.png", 7, 2)
    }
  }
  
  context = {
    text = "boo",
    locked = false
  }
  
  math.randomseed( os.time() )
  
  Gamestate.registerEvents()
  if SETTINGS.debugMode then
    Gamestate.switch(debugState)
  else
    Gamestate.switch(splashState)
  end
end

function love.update()
  require("debug.lovebird").update()
end

function loadDir( dir )
   dir = dir or ""
   local items = love.filesystem.getDirectoryItems(dir)
   for k, itms in ipairs(items) do
      trim = string.gsub( itms, ".lua", "")
      require(dir .. "/" .. trim)
   end
end