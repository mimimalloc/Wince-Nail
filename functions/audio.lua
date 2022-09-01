function isBGMPlaying()
  local isIt = false
  for k, track in keySorted(music.bg) do
    if track:isPlaying() then isIt = true end
  end
  return isIt
end

function randomBGMPlay( chance )
  if not isBGMPlaying() then
    local roll = math.random(chance)
    if roll == 1 then
      local roll2 = math.random(#music.bg)
      bgmPlay(roll2)
    end
  end
end
