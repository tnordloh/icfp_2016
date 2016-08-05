module ProblemVisualizer exposing (..)

import Html exposing(..)
import Html.App as App
import String exposing(..)
import Svg exposing(..)
import Svg.Attributes exposing(..)


type alias Rational = (Int, Int)


type alias Point = (Rational, Rational)


type alias Polygon =
  { vertices : List Point
  , negative : Bool
  }


type alias Model =
    { polygons : List Polygon
    , lines    : List (Point, Point)
    }


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
            (List.append (List.map drawPolygon model.polygons) (List.map drawLine model.lines))


update : Cmd -> Model -> (Model, Cmd msg)
update message model = model ! []


drawPolygon : Polygon -> Svg a
drawPolygon polygon =
    Svg.polygon [ points (toSvgString polygon.vertices), fill "aquamarine" ] [ ]


toSvgString : List Point -> String
toSvgString points =
    points |> List.map toCoord |> String.join " "


toCoord : Point -> String
toCoord point =
    let
      (x, y)   = point
      (xn, xd) = x
      (yn, yd) = y
    in
      String.join "" [ rationalToString xscale x
                     , ","
                     , rationalToString yscale y
                     ]


xscale : Float -> Float
xscale number =
    number * 100


yscale : Float -> Float
yscale number =
    200 - (xscale number)


drawLine : (Point, Point) -> Svg a
drawLine coords =
    let
      (coord1, coord2) = coords
      (xs1, ys1) = coord1
      (xs2, ys2) = coord2
    in
      Svg.line [ x1 (rationalToString xscale xs1)
               , y1 (rationalToString yscale ys1)
               , x2 (rationalToString xscale xs2)
               , y2 (rationalToString yscale ys2)
               , stroke "black" ] []


rationalToString : (Float -> Float) -> Rational -> String
rationalToString scale point =
    point |> floatifyRational |> scale |> toString


floatifyRational : Rational -> Float
floatifyRational rational =
    let
      (numerator, denominator) = rational
    in
      (Basics.toFloat numerator / Basics.toFloat denominator)
