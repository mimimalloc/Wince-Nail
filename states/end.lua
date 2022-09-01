thend = {}

function thend:enter()
  Timer.tween(5, fader, {alpha = 0}, nil, 
    function()
      Timer.after(5,
        function()
          Timer.tween(5, fader, {alpha = 255}, nil, 
            function()
              love.event.quit()
            end
          )
        end
      )
    end
  )
end

function thend:draw()
  resetColor()
  sFont(hugeFont)
  txtF("The End?", 0, winHeight/2, winWidth, "center", 255, 255, 255)
  sColor(0,0,0,fader.alpha)
  rekt("fill", 0, 0, winWidth, winHeight)
end

function thend:update(dt)
  Timer.update(dt)
end