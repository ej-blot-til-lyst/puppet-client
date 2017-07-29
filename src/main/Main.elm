module Main exposing (main)

-- import Html.App    as App
import Html        exposing (..)
import Html.Events exposing (..)
import WebSocket

-- main : Program Never
main =
  Html.program
     { init          = init
     , update        = update
     , view          = view
     , subscriptions = subscriptions
     }

type alias Model
  = String

type Msg
  = Receive String
  | Send

init : (Model, Cmd Msg)
init =
  ("", Cmd.none)

view : Model -> Html Msg
view model =
  div []
    [ p [] [ text <| "Pokes: " ++ toString model ]
    , button [ onClick Send ] [ text "Poke others" ]
    ]

wsUrl : String
wsUrl = "ws://localhost:3000"

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Receive message ->
      message ! []
    Send ->
      model ! [ WebSocket.send wsUrl "poke" ]

subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen wsUrl Receive
