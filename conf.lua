function love.conf(t)
  require "data.settings"
  t.window.title = SETTINGS.gameName
  t.window.width = SETTINGS.resolution.width
  t.window.height = SETTINGS.resolution.height
  t.window.fullscreen = SETTINGS.resolution.fullscreen
  t.window.fullscreentype = "exclusive"
  t.window.icon = "icon.png"
  t.identity = "SEPIA"

  t.modules.joystick = false
  t.modules.physics = false
end
