require "data.characters"
SETTINGS = {
  gameName = "Wince Nail",
  debugMode = false,
  inventoryMode = "oneItem",
  font = {
    file = "pixChicago.ttf",
    smallSize = 12,
    midSize = 14,
    largeSize = 24,
    hugeSize = 64,
    color = { 0, 0, 0 },
    activeColor = { 255, 255, 255 },
    deactiveColor = { 255, 255, 255 }
  },
  resolution = {
    width = 640,
    height = 480,
    fullscreen = false
  },
  backgroundScaling = "stretch",
  scaleObjects = true,
  initialPlayer = CHARS.gaverse,
  interface = {
    baseCol = { 255, 255, 255 },
    drawTitle = false
  },
  audio = {
    playBGMOnRoomInit = false
  }
}