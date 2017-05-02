module Lens exposing (..)

{-| Describe me please...
-}

import Html exposing (Html)
import Math.Vector3 as V3 exposing (Vec3)
import Units.Direction as Direction exposing (Direction)
import Units.Length as Length exposing (Length, floatToString)


type alias Lens a b =
    { name : String
    , get : a -> Result String b
    , set : b -> a -> Result String a
    }


type alias Getter a b =
    a -> Result String b


type alias Setter a b =
    b -> a -> Result String a


lens : String -> Getter a b -> Setter a b -> Lens a b
lens name get set =
    { name = name, get = get, set = set }


get : Lens a b -> a -> Result String b
get l = l.get


set : Lens a b -> b -> a -> Result String a
set l = l.set

{-| Transforms `a` by attempting to apply `fn` to the `b` value in `a` pointed to by `lens`.
-}
transform : (b -> Result String b) -> Lens a b -> a -> Result String a
transform fn lens a =
    lens.get a
        |> Result.andThen fn
        |> Result.andThen (\v -> lens.set v a)


concat : Lens a b -> Lens b c -> Lens a c
concat a b =
    { name =
        if String.isEmpty b.name then
            a.name
        else
            a.name ++ "/" ++ b.name
    , get = \aa -> a.get aa |> Result.andThen b.get
    , set =
        \cc aa ->
            a.get aa
                |> Result.andThen (b.set cc)
                |> Result.andThen (\bb -> a.set bb aa)
    }

concat3 : Lens a b -> Lens b c -> Lens c d -> Lens a d
concat3 a b c =
    concat a <| concat b c

concat4 : Lens a b -> Lens b c -> Lens c d -> Lens d e -> Lens a e
concat4 a b c d =
    concat a <| concat b <| concat c d

-- Wrap with getter / setter functions


wrapHead : Getter c a -> Setter c a  -> Lens a b -> Lens c b
wrapHead get set l =
    concat (lens "" get set) l

wrapTail : Getter b c -> Setter b c  -> Lens a b -> Lens a c
wrapTail get set l =
    concat l (lens "" get set)


