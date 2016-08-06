module SolutionVisualizer exposing (..)

import Html exposing(..)
import Html.App as App
import String exposing(..)
import Svg exposing(..)
import Svg.Attributes exposing(..)

type alias Rational =
  { numerator   : Int
  , denominator : Int
  }

type alias Point =
  { x : Rational
  , y : Rational
  }

type alias Polygon =
  List Point

type alias Model =
  { polygons : List Polygon }

main =
  App.programWithFlags
    { init   = init
    , update = update
    , subscriptions = \_ -> Sub.none
    , view   = view
    }

init : Model -> (Model, Cmd msg)
init model =
  model ! []

view model =
  Svg.svg [ width  (toString 200)
          , height (toString 200)
          ]
          (List.map drawPolygon model.polygons)

update : Cmd -> Model -> (Model, Cmd msg)
update message model = model ! []

drawPolygon : Polygon -> Svg a
drawPolygon polygon =
  Svg.polygon [ points (toSvgString polygon), fill "aquamarine", stroke "black" ][ ]

toSvgString : Polygon -> String
toSvgString polygon =
  polygon
  |> List.map toCoord
  |> String.join " "

toCoord : Point -> String
toCoord {x, y} =
  String.join "" [ rationalToString x
                 , ","
                 , rationalToStringy y 200
                 ]

rationalToString : Rational -> String
rationalToString { numerator, denominator } =
  toString ((Basics.toFloat numerator / Basics.toFloat denominator) * 100)

rationalToStringy : Rational -> Float -> String
rationalToStringy { numerator, denominator } offset =
  toString (offset - ((Basics.toFloat numerator / Basics.toFloat denominator) * 100))
