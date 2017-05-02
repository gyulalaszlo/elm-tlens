module Lens.Common exposing (..)
{-| Describe me please...
-}


{-
[[[cog
import cog
import string


cog.outl("lensForField =")
cog.outl("    { self = { name = \"self\", get = Ok, set = \\v _ -> Ok v }")

fieldGroups = [["x","y", "z"], ["r","g", "b"], ["h", "s", "v"] ]


for fields in fieldGroups:
    cog.outl("")
    for name in fields:
        n = { "name": name, "capName": string.capitalize(name) }
        cog.outl("    , {name} = {{ name = \"{name}\", get = \\v -> Ok v.{name}, set = \\v p -> Ok {{ p | {name} = v }} }}".format(**n))

cog.outl("    }")

]]]-}
lensForField =
    { self = { name = "self", get = Ok, set = \v _ -> Ok v }

    , x = { name = "x", get = \v -> Ok v.x, set = \v p -> Ok { p | x = v } }
    , y = { name = "y", get = \v -> Ok v.y, set = \v p -> Ok { p | y = v } }
    , z = { name = "z", get = \v -> Ok v.z, set = \v p -> Ok { p | z = v } }

    , r = { name = "r", get = \v -> Ok v.r, set = \v p -> Ok { p | r = v } }
    , g = { name = "g", get = \v -> Ok v.g, set = \v p -> Ok { p | g = v } }
    , b = { name = "b", get = \v -> Ok v.b, set = \v p -> Ok { p | b = v } }

    , h = { name = "h", get = \v -> Ok v.h, set = \v p -> Ok { p | h = v } }
    , s = { name = "s", get = \v -> Ok v.s, set = \v p -> Ok { p | s = v } }
    , v = { name = "v", get = \v -> Ok v.v, set = \v p -> Ok { p | v = v } }
    }
--[[[end]]]

