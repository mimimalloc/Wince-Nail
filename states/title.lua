titleState = {}

function titleState:enter()
  gameEnv:initRooms()
  gameEnv:initPlayer()
  gameEnv.data.menus = {}
  gameEnv.data.activePlayer = gameEnv.data.chars:getActiveCharacter()
  titleMenu = false
  love.mouse.setVisible( true )
  love.mouse.setCursor( cursor.images.default )
  title = nImg("images/title.png")
  Timer.tween(1, fader, { alpha = 0 }, 'in-out-quad', 
    function()
      titleMenu = newMenu((winWidth-200)/2, winHeight - 200, 200, "empty")
      titleMenu:addTextButt({btnNewGame, titleMenu}, "New Game")
      titleMenu:addTextButt({btnQuit}, "Quit to OS")
    end
  )
  music.title:setLooping(true)
  mPlay("title")
end

function titleState:draw()
  resetColor()
  gDraw(title, 0, 0)
  if SETTINGS.interface.drawTitle then
    sFont(hugeFont)
    txtF(SETTINGS.gameName, 0, winHeight/4, winWidth, "center")
    sFont(mainFont)
  end
  drawMenus()
  sColor(0, 0, 0, fader.alpha)
  rekt("fill", 0, 0, winWidth, winHeight)
end

function titleState:update(dt)
  updateMenus(dt)
  Timer.update(dt)
end

function titleState:mousereleased()
  checkClick()
end
