cutScene = {}

function cutScene:enter(prev, cutsceneID)
  cutscene = CUTSCENES[cutsceneID]
  imgStack = {}
  cutscenetext = ""
  recursiveCutscene(1)
end

function cutScene:draw()
  resetColor()
  drawImgStack(imgStack)
  sColor(0,0,0,255)
  rekt("fill", 0, winHeight*0.75, winWidth, winHeight*0.25)
  resetColor()
  txtF(cutscenetext, 0, winHeight*0.80, winWidth, "center", 255, 255, 255, 255)
end

function cutScene:update(dt)
  Timer.update(dt)
end

function cutScene:keyreleased(key)
  if key == "escape" then
    cutscene.complete()
  end
end


function recursiveCutscene(thisFrame)
  local curFrame = cutscene.frame[thisFrame]
  if curFrame.clearImages then imgStack = {} end
  cutscenetext = curFrame.text
  if curFrame.images then
    for k, image in keySorted(curFrame.images) do
      local img = {}
      img.x, img.y = image.x, image.y
      img.image = nImg(CUTIMG .. image.file .. ".png")
      tPush(imgStack, img)
    end
  end
  Timer.after(curFrame.timeActive, 
    function()
      if thisFrame == #cutscene.frame then
        cutscene.complete()
      else
        recursiveCutscene(thisFrame+1)
      end
    end
  )
end

function drawImgStack(imgStack)
  for k, img in keySorted(imgStack) do
    gDraw(img.image, img.x, img.x)
  end
end
