-- Resets draw color to default(white)
function resetColor(alpha)
  local a = alpha or 255
  sColor(255, 255, 255, a)
end

-- Sets draw color to the current color for fonts
function setColorForFonts(alpha)
  local col = SETTINGS.font.color
  col[4] = alpha or 255
  sColor(unpack(col))
end

-- Returns a valid alpha value
function alphize(alpha, mod)
  local al = alpha
  al = al + mod
  if al > 255 then al = 255
  elseif al < 0 then al = 0 end
  return al
end

-- Draws text styled to have a dropshadow
function txt(text, x, y, r, g, b, a)
  --sColor(50, 50, 50, a)
  --pStr(text, x+3, y+2)
  if r and g and b then
    sColor(r, g, b, a)
  else
    setColorForFonts(a)
  end
  pStr(text, x, y-2)
  resetColor()
end

-- Same as above, but formatted
function txtF(text, x, y, limit, align, r, g, b, a)
  --sColor(50, 50, 50, a)
  --pfStr(text, x+3, y+2, limit, align)
  if r and g and b then
    sColor(r, g, b, a)
  else
    setColorForFonts(a)
  end
  pfStr(text, x, y-2, limit, align)
  resetColor()
end

-- Returns the draw point that will an image at the center of two points(horizontally)
function imgXBetween(img, x1, x2)
  return (x2 / 2 - img:getWidth() / 2) + x1
end

-- Same as above but vertically
function imgYBetween(img, y1, y2)
  return(y2 / 2 - img:getHeight() / 2) + y1
end

-- Draws all of the current menus
function drawMenus()
  for k, menu in keySorted(gameEnv.data.menus) do
    menu:draw()
  end
end

-- Draws the frame that encompasses the game view
function drawFrameInterface()
  sColor(unpack(SETTINGS.interface.baseCol))
  --sLineWidth(16)
  --rekt("line", 0, 0, winWidth, winHeight)
  --sLineWidth(1)
  rekt("fill", 0, 0, winWidth, 32)
  --sColor(255, 255, 255, 100)
  --rekt("fill", 4, 2, winWidth-6, 2)
  --sColor(0,0,0,255)
  --rekt("line", 2, 2, winWidth-4, winHeight-4)
  --sColor(0,0,0,100)
  --rekt("fill", 4, 30, winWidth-8, 2)
  --sLineWidth(4)
  --rekt("line", 8, 33, winWidth-16, winHeight - 33)
  --resetColor()
  txtF(context.text, 0, 4, winWidth, "center")
  gDraw(corners.lcorner, 0, 0)
  gDraw(corners.rcorner, winWidth - 4, 0)
  sColor(0,0,0,255)
  rekt("fill", 0, 30, winWidth, 2)
  resetColor()
end

