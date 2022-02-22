# Background

`src/Decoder.elm` is meant to be a module that is capable of "decoding" a data structure
of `List ( k, String )`

For example

```elm
type Field
    = Title
    | PublishedAt


rawValue : List ( Field, String )
rawValue =
    [ ( Title, "Example Title" )
    , ( PublishedAt, "2016-01-01T00:00:00Z" )
    ]
```

We can decode the `PublishedAt` value

```elm
decode (field PublishedAt string) rawValue
--> Ok "2016-01-01T00:00:00Z"
```

we can also use `map`

```elm
decode (field Title string |> map String.toUpper) rawValue
--> Ok "EXAMPLE TITLE
```

or use `andThen` to compose decoders

```elm
decode (field PublishedAt string |> asTimePosix) rawValue
--> Ok (Time.millisToPosix 1451606400000)
```

# Task

Implement the missing code in `Decoder.elm` such that the tests in `DecoderTest.elm` passes.
You may make necessary changes to the test code to fit your function type signatures.

If there's an error in our test, please let us know!
