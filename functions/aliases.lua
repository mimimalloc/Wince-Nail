--[[
ALIASES

Shortened forms of pre-existing functions.
Because of their nature as shortcuts, be wary of conflicts with your existing functions.
]]--

-- Alias for love.graphics.newImage
function nImg(filename)
  return love.graphics.newImage(filename)
end

-- Alias for love.graphics.newFont
function nFont(font, size)
  return love.graphics.newFont(font, size)
end

-- Alias for love.graphics.newQuad
function nQuad( x, y, width, height, sw, sh )
  return love.graphics.newQuad( x, y, width, height, sw, sh )
end

-- Alias for love.graphics.setColor
function sColor(r, g, b, a)
  love.graphics.setColor(r, g, b, a)
end

-- Alias for love.graphics.setFont
function sFont(font)
  love.graphics.setFont(font)
end

-- Alias for love.graphics.print
function pStr(text, x, y, r, sx, sy, ox, oy, kx, ky)
  love.graphics.print(text, x, y, r, sx, sy, ox, oy, kx, ky)
end

-- Alias for love.graphics.printf
function pfStr(text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky)
  love.graphics.printf(text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky)
end

-- Alias for love.graphics.draw
function gDraw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
  love.graphics.draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky)
end

-- Alias for love.graphics.rectangle
function rekt(mode, x, y, width, height)
  love.graphics.rectangle(mode, x, y, width, height, 2, 2)
end

-- Alias for love.graphics.setLineWidth
function sLineWidth(width)
  love.graphics.setLineWidth(width)
end

-- Alias for love.graphics.line (only for basic lines)
function lyne(x1, y1, x2, y2)
  love.graphics.line(x1, y1, x2, y2)
end

-- Alias for love.audio.play (sounds)
function sPlay(source)
  love.audio.play(sound[source])
end

-- (specific music)
function mPlay(source)
  love.audio.play(music[source])
end

-- (background music)
function bgmPlay(id)
  love.audio.play(music.bg[id])
end
