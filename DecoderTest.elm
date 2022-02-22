module DecoderTest exposing (..)

import Decoder exposing (..)
import Expect exposing (Expectation)
import Iso8601
import Test exposing (Test, describe, test)
import Time


type alias Book =
    { title : String
    , publishedAt : Time.Posix
    }


type Field
    = Title
    | PublishedAt


okayValue : Value Field
okayValue =
    [ ( Title, "Example Title" )
    , ( PublishedAt, "2016-01-01T00:00:00Z" )
    ]


errMissingTitle : Value Field
errMissingTitle =
    [ ( PublishedAt, "2016-01-01T00:00:00Z" )
    ]


errInvalidPublishedAt : Value Field
errInvalidPublishedAt =
    [ ( Title, "Example Title" )
    , ( PublishedAt, "2016" )
    ]


timePosixAfter fieldName targetYear =
    field fieldName timePosix
        |> andThen
            (\t ->
                if Time.toYear Time.utc t > targetYear then
                    Debug.todo "andThen succeed"

                else
                    Debug.todo "andThen fail"
            )


suite : Test
suite =
    describe "Decode"
        [ test "String field fails" <|
            \_ ->
                errMissingTitle
                    |> decode (field Title string)
                    |> Expect.equal (Err (Debug.todo "error?"))
        , test "String field succeeds" <|
            \_ ->
                okayValue
                    |> decode (field Title string)
                    |> Expect.equal (Ok "Example Title")
        , test "Time.Posix field fails" <|
            \_ ->
                errInvalidPublishedAt
                    |> decode (field PublishedAt timePosix)
                    |> Expect.equal (Err (Debug.todo "error?"))
        , test "Time.Posix field succeeds" <|
            \_ ->
                okayValue
                    |> decode (field PublishedAt timePosix)
                    |> Expect.equal (Ok (Time.millisToPosix 1451606400000))
        , test "field map" <|
            \_ ->
                let
                    titleToUpper =
                        field Title string
                            |> map String.toUpper
                in
                okayValue
                    |> decode titleToUpper
                    |> Expect.equal (Ok "EXAMPLE TITLE")
        , test "field map2" <|
            \_ ->
                let
                    bookDecoder =
                        map2 Book
                            (field Title string)
                            (field PublishedAt timePosix)
                in
                okayValue
                    |> decode bookDecoder
                    |> Expect.equal
                        (Ok
                            { title = "Example Title"
                            , publishedAt = Time.millisToPosix 1451606400000
                            }
                        )
        , test "field andThen fails" <|
            \_ ->
                okayValue
                    |> decode (timePosixAfter PublishedAt 2020)
                    |> Expect.equal (Err (Debug.todo "error?"))
        , test "field andThen succeed" <|
            \_ ->
                okayValue
                    |> decode (timePosixAfter PublishedAt 2000)
                    |> Expect.equal (Ok (Time.millisToPosix 1451606400000))
        ]
