OBJECTS = {
  
  trickynote1 = {
    name = "Tricky Note",
    description = {
      ground = "It's a Tricky Note, probably left as some sort of memo. You can't quite read it from here.",
      inv = "The Tricky Note reads:\n\n\"This is not a lift, but a drop. Do not believe the hype. I am furious at this deception.\n\n-Maudlin\""
    },
    image = {
      ground = "note_m",
      inv = "note_i"
    },
    interaction = {
      pickUp = {
        message = "You pick up the Tricky Note."
      },
      useInv = {
        message = "You ripped the Tricky Note to shreds. You have a momentary sensation of limitless power, but it soon passes.",
        activate = function()
          gameEnv.data.activePlayer.inventory[1] = nil
        end
      },
    },
    position = { x = 360, y = 224, w = 16, h = 16 }
  },
  
  orborb = {
    name = "ORB Orb",
    description = {
      ground = "A menacing Orb taunts you with its presence.",
      inv = "The Orb hums with ORB energies."
    },
    image = {
      ground = "orb_m",
      inv = "orb_i"
    },
    interaction = {
      pickUp = {
        message = "You recoil as the Orb feels as though it is burning your palm. You can see no damage to yourself, but wrap the orb in your sleeve this time before pocketing it."
      },
      combine = {
        ["Pedestal"] = {
          message = "You place the ORB Orb on the pedestal. A panel reveals itself...",
          activate = function(groundObj)
            gameEnv.data.activePlayer.inventory[1] = nil
            groundObj.groundDescription = "This pedestal houses a powerful ORB orb now."
            --groundObj.images.ground = "fullstand"
            groundObj.groundImg = nImg(OBJ .. "fullstand.png")
            groundObj.interactions.use = function() simpleDiag("You can't take back what you've done. The ORB Orb has a new home now.", "Failure", "info") end
            gameEnv.data.currentRoom:addPuzzle(PUZZLES[2])
          end
        }
      }
    },
    position = { x = 304, y = 312, w = 32, h = 32 }
  },
  
  phlegm = {
    name = "Phlegm",
    description = {
      ground = "It's a viscous pile of phlegm.",
      inv = "This is your phlegm. It is of questionable usefulness."
    },
    image = {
      ground = "phlegm_m",
      inv = "phlegm_i"
    },
    interaction = {
      pickUp = {
        message = "You gather up the pile of phlegm and stuff it in your pockets."
      },
      combine = {
        ["Lift Door"] = {
          message = "You smear your phlegm on the door. It doesn't accomplish much except making it grosser.",
          activate = function()
            gameEnv.data.activePlayer.inventory[1] = nil
          end
        },
        ["ORB Orb"] = {
          message = "Your attempts to defile the Orb with your mucous have failed. It remains as vaguely threatening as ever.",
          activate = function()
            gameEnv.data.activePlayer.inventory[1] = nil
          end
        },
        ["Tricky Note"] = {
          message = "You cover the Tricky Note with your snot, but it just dissolves. Tricky.",
          activate = function()
            gameEnv.data.activePlayer.inventory[1] = nil
          end
        }
      }
    },
    
    position = { x = 320, y = 320, w = 64, h = 64 }
  },
  
  door1 = {
    name = "Lift Door",
    description = {
      ground = "This door leads into the lift.",
    },
    image = {
      ground = "none"
    },
    interaction = {
      use = function()
        if gameEnv.data.flags.openedDoor1 then
          movePlayer(gameEnv.data.activePlayer, gameEnv.data.currentRoom, 14)
        else
          sPlay("fail")
          simpleDiag("The door resists your attempts to open it.", "Failure", "use")
        end
      end
    },
    position = { x = 216, y = 195, w = 99, h = 226 }
  },
  
  hatch1 = {
    name = "Open Hatch",
    description = {
      ground = "Surprisingly, this hatch has been left unlocked. Perhaps the cube has been abandoned by its owner."
    },
    image = {
      ground = "hatch"
    },
    interaction = {
      use = function()
        movePlayer(gameEnv.data.activePlayer, gameEnv.data.currentRoom, 13)
      end
    },
    position = { x = 272, y = 368, w = 96, h = 32 }
  },
  
  hatch2 = {
    name = "Exit Hatch",
    description = {
      ground = "The exit out of this cube."
    },
    image = {
      ground = "hatch"
    },
    interaction = {
      use = function()
        movePlayer(gameEnv.data.activePlayer, gameEnv.data.currentRoom, 11)
      end
    },
    position = { x = 272, y = 32, w = 96, h = 32 }
  },
  
  pedestal = {
    name = "Pedestal",
    description = {
      ground = "An ornate stand. It is suspiciously empty."
    },
    image = { ground = "emptystand" },
    interaction = {
      use = function()
        simpleDiag("Feeling around the indentation in the pedestal, you conclude it was meant to hold an artifact that, at the very least, has a spherical base.", "Observation", "use")
      end
    },
    position = { x = 393, y = 233, w = 96, h = 96 }
  },
  
  gleamcrystal1 = {
    name = "Gleamcrystal",
    description = {
      ground = "A Gleamcrystal. Gleamcrystals are coveted by many as they are believed to unleash latent power.",
      inv = "You examine this Gleamcrystal closely.\n\nIf your observations are correct, this Gleamcrystal holds the power of TUNNEL CONTROL."
    },
    image = {
      ground = "crystal_m",
      inv = "crystal_i"
    },
    interaction = {
      pickUp = {
        message = "You pick up the Gleamcrystal. It flashes in your hands and looses a deep, booming laugh."
      },
      useInv = {
        message = "You shatter the Gleamcrystal. A sensation of being chased through damp corridors echoes in your amygdala.\n\n (TUNNEL CONTROL allows you to instantly travel through enclosed areas such as tunnels and shafts, regardless of external forces such as gravity)",
        activate = function()
          mPlay("puzzleComplete")
          gameEnv.data.activePlayer.inventory[1] = nil
          tPush(gameEnv.data.activePlayer.abilities, ABILITIES.tunnelcontrol)
          gameEnv.data.gui = nil
          buildPBar()
        end
      }
    },
    position = { x = 304, y = 232, w = 32, h = 32 }
  },
  
  shaft = {
    name = "Foreboding Shaft",
    description = {
      ground = "This shaft is dark and deep with no good footholds. It would be dangerous to climb without equipment."
    },
    image = {
      ground = "none"
    },
    interaction = {
      use = function()
        sPlay("message")
        simpleDiag("Climbing down by yourself is asking for trouble.", "Please, just, don't.", "info")
      end
    },
    position = { x = 112, y = 304, w = 424, h = 64 }
  },
  
  door2 = {
    name = "Bottom Floor Door",
    description = {
      ground = "What could be behind this door?"
    },
    image = {
      ground = "none"
    },
    interaction = {
      use = function()
        sPlay("event")
        cursor.lock = true
        cursor.active = false
        cursor.state = "wait"
        Timer.tween(4, fader, { alpha = 255 }, nil, function() Gamestate.switch(thend) end)
      end
    },
    position = { x = 128, y = 56, w = 384, h = 376 }
  },
}