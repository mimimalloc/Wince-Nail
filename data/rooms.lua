ROOMS = {}

ROOMS[1] = {
  name = "Walkway",
  image = "1",
  description = "You are standing on a walkway over what appears to be an endless screaming void from which there is no return.\n\nYou find yourself longing for better footing than these rickety platforms.",
  objects = {},
  puzzles = {},
  characters = {},
  exits = {
    n = { to = 2, locked = false },
    e = { to = 6, locked = false },
    w = { to = 6, locked = false },
    s = { to = 6, locked = false }
  }
}

ROOMS[2] = {
  name = "Front of Lift",
  image = "2",
  description = "You are standing in front of the doors to a lift.\n\nA panel on your right catches your attention.",
  objects = { OBJECTS.trickynote1, OBJECTS.door1 },
  puzzles = {PUZZLES[1]},
  characters = {},
  exits = {
    s = { to = 5, locked = false },
    w = { to = 3, locked = false },
    e = { to = 4, locked = false }
  }
}

ROOMS[3] = {
  name = "Left Side of Lift",
  image = "3",
  description = "You peek over the corner of the cube. You can barely make out the lights and silhouettes of a sprawling city far beneath you. You resist the urge to jump.",
  objects = {},
  characters = {},
  exits = {
    e = { to = 2, locked = false },
    w = { to = 5, locked = false },
    s = { to = 4, locked = false }
  }
}

ROOMS[4] = {
  name = "Right Side of Lift",
  image = "4",
  description = "You can see another cube in the distance. It's well within your jumping range.",
  objects = {},
  characters = {},
  exits = {
    w = { to = 2, locked = false },
    e = { to = 5, locked = false },
    n = { to = 11, locked = false },
    s = { to = 3, locked = false }
  }
}

ROOMS[5] = {
  name = "Facing Walkway",
  image = "5",
  description = "Facing the walkway, you have great difficulty seeing where it ends on the horizon.",
  objects = {},
  characters = {},
  exits = {
    e = { to = 3, locked = false },
    w = { to = 4, locked = false },
    n = { to = 6, locked = false },
    s = { to = 2, locked = false }
  }
}

ROOMS[6] = {
  name = "Walkway",
  image = "6",
  description = "The walkway in this direction is fairly long, but you have the impression it will end eventually. There is no reason to believe it's an ETERNAL WALKWAY.",
  objects = {},
  characters = {},
  exits = {
    e = { to = 1, locked = false },
    w = { to = 1, locked = false },
    n = { to = 7, locked = false },
    s = { to = 1, locked = false }
  }
}

ROOMS[7] = {
  name = "Approaching ORB",
  image = "7",
  description = "You are facing a strange and harrowing ORB. Dare you enter the ORB?",
  objects = {},
  characters = {},
  exits = {
    e = { to = 8, locked = false },
    w = { to = 8, locked = false },
    n = { to = 9, locked = false },
    s = { to = 8, locked = false }
  }
}

ROOMS[8] = {
  name = "Walkway",
  image = "6",
  description = "The walkway hasn't changed since you last traversed it.",
  objects = {},
  characters = {},
  exits = {
    e = { to = 7, locked = false },
    w = { to = 7, locked = false },
    n = { to = 1, locked = false },
    s = { to = 7, locked = false }
  }
}

ROOMS[9] = {
  name = "Interior ORB",
  image = "8",
  description = "You are inside of the ORB. The sheer hollowness of the sphere causes your body to shiver.",
  objects = { OBJECTS.orborb },
  characters = {},
  exits = {
    e = { to = 10, locked = false },
    w = { to = 10, locked = false },
    s = { to = 10, locked = false }
  }
}

ROOMS[10] = {
  name = "Interior ORB",
  image = "9",
  description = "You are inside of the ORB. Seeing the exit fills you with relief.",
  objects = {},
  characters = {},
  exits = {
    e = { to = 9, locked = false },
    w = { to = 9, locked = false },
    s = { to = 9, locked = false },
    n = { to = 8, locked = false }
  }
}

ROOMS[11] = {
  name = "Outer Cube",
  image = "10",
  description = "On top of this cube, you can faintly see other nodes in the far distance.",
  objects = { OBJECTS.hatch1 },
  characters = {},
  exits = {
    e = { to = 12, locked = false },
    w = { to = 12, locked = false },
    s = { to = 12, locked = false },
  }
}

ROOMS[12] = {
  name = "Outer Cube",
  image = "11",
  description = "You see below you the node from which you came. It should be a simple matter to jump back down.",
  objects = {},
  characters = {},
  exits = {
    e = { to = 11, locked = false },
    w = { to = 11, locked = false },
    s = { to = 11, locked = false },
    n = { to = 3, locked = false }
  }
}

ROOMS[13] = {
  name = "Mysterious Cube",
  image = "12",
  description = "You are within a strange cube, long abandoned. The stench of ancient sweatstains emnate from the walls.",
  objects = { OBJECTS.pedestal, OBJECTS.hatch2 },
  characters = {},
  exits = {}
}

ROOMS[14] = {
  name = "Empty Shaft",
  image = "13",
  description = "It doesn't look like there's a lift at all, just a potentially bottomless shaft.",
  objects = {OBJECTS.shaft},
  characters = {},
  exits = {s = { to = 5, locked = false} }
}

ROOMS[15] = {
  name = "Bottom Floor",
  image = "14",
  description = "It doesn't look like there's a lift at all, just a potentially bottomless shaft.",
  objects = {OBJECTS.door2},
  characters = {},
  exits = {}
}
