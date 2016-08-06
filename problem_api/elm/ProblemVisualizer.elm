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
    let
      minxy = minCoords model.polygons
    in
      Svg.svg [ width  (toString 200)
            , height (toString 200)
            ]
            (List.append (List.map (\poly -> drawPolygon poly minxy) model.polygons) (List.map (\line -> drawLine minxy line) model.lines))


minCoords polygons =
    let
      minx = polygons |> List.concatMap .vertices |> List.map fst |> List.map convert |> List.minimum
      miny = polygons |> List.concatMap .vertices |> List.map snd |> List.map convert |> List.minimum
    in
      (Maybe.withDefault 0.0 minx, Maybe.withDefault 0.0 miny)


convert : Rational -> Float
convert (n, d) =
        (Basics.toFloat n) / (Basics.toFloat d)


update : Cmd -> Model -> (Model, Cmd msg)
update message model = model ! []


drawPolygon : Polygon -> (Float, Float) -> Svg a
drawPolygon polygon minxy =
    Svg.polygon [ points (toSvgString polygon.vertices minxy), fill (color polygon.negative) ] [ ]


color : Bool -> String
color negative =
    case negative of
        True -> "white"
        False -> "aquamarine"

toSvgString : List Point -> (Float, Float) -> String
toSvgString points minxy =
    points |> List.map (\point -> toCoord minxy point) |> String.join " "


toCoord : (Float, Float) -> Point -> String
toCoord (minx, miny) (x, y) =
      String.join "" [ rationalToString xscale minx x
                     , ","
                     , rationalToString yscale miny y
                     ]

xscale : Float -> Float -> Float
xscale minx x =
    if minx < 0 then
        ((negate minx) + x) * 100
    else
        x * 100


yscale : Float -> Float -> Float
yscale miny y =
    if miny < 0 then
        ((negate miny) + y) * 100
    else
        200 - (y * 100)


drawLine : (Float, Float) -> (Point, Point) -> Svg a
drawLine (minx, miny) (coord1, coord2) =
    let
      (xs1, ys1) = coord1
      (xs2, ys2) = coord2
    in
      Svg.line [ x1 (rationalToString xscale minx xs1)
               , y1 (rationalToString yscale miny ys1)
               , x2 (rationalToString xscale minx xs2)
               , y2 (rationalToString yscale miny ys2)
               , stroke "black" ] []


rationalToString : (Float -> Float -> Float) -> Float -> Rational -> String
rationalToString scale minx point =
    point |> floatifyRational |> scale minx |> toString


floatifyRational : Rational -> Float
floatifyRational (numerator, denominator) =
      (Basics.toFloat numerator / Basics.toFloat denominator)
