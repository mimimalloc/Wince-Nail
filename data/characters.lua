CHARS = {
  gaverse = {
    name = "Gaverse",
    portrait = "gaverse",
    startingRoom = 1,
    inventory = {},
    abilities = {
      [1] = {
        name = "Generate Phlegm",
        image = "phlegm",
        activate = function()
          local inv = gameEnv.data.activePlayer.inventory
          if inv[1] then
            simpleDiag("You can't Generate Phlegm when you're holding something!\n\nGet rid of your item first.", "Ability Failure", "info")
          else
            local phlegm = OBJECTS.phlegm
            inv[1] = Object(0, phlegm.name, phlegm.description, phlegm.image, phlegm.interaction, phlegm.position)
            simpleDiag("You sneeze into your hands. Good job.", "Ability Success", "info")
          end
        end
      }
    }
  }
}

-- Abilities that can be attained in-game
ABILITIES = {
  tunnelcontrol = {
        name = "Tunnel Control",
        image = "tcontrol",
        activate = function()
          local rID = roomID(gameEnv.data.currentRoom)
          if TUNNELCONTROL.from[rID] then
            local tunneling = TUNNELCONTROL.from[rID]
            sPlay("message")
            queryDiag("There is a viable passage for TUNNEL CONTROL here.\n\nUse it?", "Tunnel Found", 
              function()
                destroyTopMenu()
                sPlay("event")
                movePlayer(gameEnv.data.activePlayer, gameEnv.data.currentRoom, tunneling.to)
                Timer.after(0.2,
                  function()
                    simpleDiag(tunneling.message, "Ability Success", "info")
                  end
                )
              end, nil, "info")
          else
            sPlay("message")
            simpleDiag("There are no tunnels around here.", "Ability Failure", "info")
          end
        end
      }
}

TUNNELCONTROL = {
  from = {
    [14] = {
      to = 15,
      message = "You gently fall to the bottom floor of the shaft. You didn't notice any other stops on the way, so it looks like this is it."
    },
    [15] = {
      to = 14,
      message = "You lift yourself out of the shaft and end up back where you started."
    }
  }
}

