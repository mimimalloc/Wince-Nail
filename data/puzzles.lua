PUZZLES = {
  [1] = {
    name = "Lift Panel",
    solutionType = "number",
    solution = 104,
    mx = 335, my = 253, mw = 64, mh = 52,
    mapImgFile = "lpanel",
    bgImgFile = "panel",
    solvedFlag = "openedDoor1",
    solvedFunc = function()
      sPlay("message")
      simpleDiag("This strikes you as a rather inconvenient way to open a lift, but in any case, the door is now loose and open to suggestion.", "Success", "info")
    end,
    elements = {
      containers = {
        [1] = {
          x = 120, y = 144, w = 48, h = 48,
          heldValues = { 2, 4, 6, 8 },
          textBased = true,
          imgFile = "numcontainer"          
        },
        [2] = {
          x = 200, y = 144, w = 48, h = 48,
          heldValues = { 0, 10, 20, 30, 40, 50 },
          textBased = true,
          imgFile = "numcontainer"
        },
        [3] = {
          x = 280, y = 144, w = 48, h = 48,
          heldValues = { 22, 33, 44, 55, 66, 11 },
          textBased = true,
          imgFile = "numcontainer"
        },
        [4] = {
          x = 360, y = 144, w = 48, h = 48,
          heldValues = { 3, 2, 1, 0 },
          textBased = true,
          imgFile = "numcontainer"
        },
        [5] = {
          x = 472, y = 144, w = 48, h = 48,
          heldValues = { 52 },
          textBased = true,
          imgFile = "numcontainer"
        },
      },
      switches = {
        [1] = {
          x = 136, y = 280, w = 32, h = 72,
          linkedContainer = 1,
          valueMod = 2,
          imgFile = "lswitch1",
          isAnimated = true,
          numFrames = 2
        },
        [2] = {
          x = 174, y = 280, w = 32, h = 72,
          linkedContainer = 2,
          valueMod = 2,
          imgFile = "lswitch1",
          isAnimated = true,
          numFrames = 2
        },
        [3] = {
          x = 212, y = 280, w = 32, h = 72,
          linkedContainer = 3,
          valueMod = 2,
          imgFile = "lswitch1",
          isAnimated = true,
          numFrames = 2
        },
        [4] = {
          x = 250, y = 280, w = 32, h = 72,
          linkedContainer = 4,
          valueMod = 2,
          imgFile = "lswitch1",
          isAnimated = true,
          numFrames = 2
        },
        [5] = {
          x = 320, y = 288, w = 24, h = 48,
          linkedContainer = 1,
          valueMod = 3,
          imgFile = "lever1",
          isAnimated = true,
          numFrames = 8
        },
        [6] = {
          x = 356, y = 288, w = 24, h = 48,
          linkedContainer = 2,
          valueMod = 3,
          imgFile = "lever1",
          isAnimated = true,
          numFrames = 8
        },
        [7] = {
          x = 392, y = 288, w = 24, h = 48,
          linkedContainer = 3,
          valueMod = 3,
          imgFile = "lever1",
          isAnimated = true,
          numFrames = 8
        },
        [8] = {
          x = 428, y = 288, w = 24, h = 48,
          linkedContainer = 4,
          valueMod = 3,
          imgFile = "lever1",
          isAnimated = true,
          numFrames = 8
        },
      },
      buttons = {
        [1] = {
          x = 472, y = 296, w = 32, h = 32,
          imgFile = "butt1",
          func = function(puzzle)
            puzzle:checkSolved()
          end
        }
      }
    }
  },
  [2] = {
    name = "Pictomonger",
    solutionType = "number",
    solution = 13,
    mx = 224, my = 144, mw = 192, mh = 80,
    mapImgFile = "cubepanel",
    bgImgFile = "orbpanel",
    solvedFlag = "pictomonger",
    solvedFunc = function()
      sPlay("activated")
      gameEnv.data.currentRoom:addObject(OBJECTS.gleamcrystal1)
    end,
    elements = {
      containers = {
        [1] = {
          x = 208, y = 112, w = 48, h = 48,
          heldValues = { 600, 600, 1, 600, 600 },
          textBased = false,
          imgFile = "picto"          
        },
        [2] = {
          x = 384, y = 112, w = 48, h = 48,
          heldValues = { 600, 600, 600, 600, 1 },
          textBased = false,
          imgFile = "picto2"
        },
        [3] = {
          x = 264, y = 160, w = 24, h = 24,
          heldValues = { 3, 4, 5, 6, 7, 8, 9, 1, 2 },
          textBased = true,
          imgFile = "placeholder"
        },
        [4] = {
          x = 352, y = 160, w = 24, h = 24,
          heldValues = { 8, 9, 1, 2, 3, 4, 5, 6, 7 },
          textBased = true,
          imgFile = "placeholder"
        }
      },
      switches = {
        [1] = {
          x = 264, y = 112, w = 24, h = 48,
          linkedContainer = 1,
          valueMod = 1,
          imgFile = "lever1",
          isAnimated = true,
          numFrames = 8
        },
        [2] = {
          x = 352, y = 112, w = 24, h = 48,
          linkedContainer = 2,
          valueMod = 1,
          imgFile = "lever1",
          isAnimated = true,
          numFrames = 8
        },
        [3] = {
          x = 264, y = 216, w = 32, h = 72,
          linkedContainer = 3,
          valueMod = 1,
          imgFile = "lswitch1",
          isAnimated = true,
          numFrames = 2
        },
        [4] = {
          x = 344, y = 216, w = 32, h = 72,
          linkedContainer = 4,
          valueMod = 1,
          imgFile = "lswitch1",
          isAnimated = true,
          numFrames = 2
        }
      },
      buttons = {
        [1] = {
          x = 304, y = 240, w = 32, h = 32,
          imgFile = "butt1",
          func = function(puzzle)
            puzzle:checkSolved()
          end
        }
      }
    }
  }
}