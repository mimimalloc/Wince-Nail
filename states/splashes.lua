splashState = {}

function splashState:enter()
  love.mouse.setVisible( false )
  splash = nImg("images/splash.png")
  Timer.tween(1, fader, { alpha = 0 }, 'in-out-quad', 
    function()
      Timer.after(5, 
        function()
          Timer.tween(1, fader, { alpha = 255 }, 'in-out-quad',
            function()
              Gamestate.switch(titleState)
            end
          )
        end
      )
    end
  )
end

function splashState:draw()
  local iX = (winWidth-splash:getWidth())/2
  local iY = (winHeight-splash:getHeight())/2
  resetColor()
  gDraw(splash, iX, iY)
  sColor(0, 0, 0, fader.alpha)
  rekt("fill", 0, 0, winWidth, winHeight)
  resetColor()
end

function splashState:update(dt)
  Timer.update(dt)
end

