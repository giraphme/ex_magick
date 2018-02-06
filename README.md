# ExMagick

ExMagick is a package to make it easy to build ImageMagick commands with Elixir.

Perhaps it supports all of the options supported by ImageMagick.
However, we don't test all options, so please create an issue if you have options that can not be used.

## Installation

```elixir
def deps do
  [
    {:ex_magick, "~> 0.2.0"}
  ]
end
```

## Usage

```elixir
ExMagick.init()
|> ExMagick.put_image("path/to/input.jpg")
|> ExMagick.put_option("size", "150x150")
|> ExMagick.output("path/to/output.png")
```

### Decode base64 encoded image

```elixir
ExMagick.init()
|> ExMagick.put_base64_image("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAAH6Nf8rAAAABGdBTUEAALGPC/xhBQAAAD9JREFUGBlj/A8EDEDABCLAACQC5jHC5EDCcA5cIZwBl4Loh5BwWWRB4lVi1U68IFaLkF0CY2M1EiaJTA+gQgApmhwFHvIPpAAAAABJRU5ErkJggg==")
|> ExMagick.output("path/to/output.png")
```

### Generate filled image

```elixir
ExMagick.init()
|> ExMagick.put_option("size", "150x150")
|> ExMagick.put_color("#ffaa00")
|> ExMagick.output("path/to/output.png")
```

### Generate gradient image

```elixir
ExMagick.init()
|> ExMagick.put_option("size", "150x150")
|> ExMagick.put_color("#000000-#ffffff", fill: :gradient)
|> ExMagick.output("path/to/output.png")
```

### Use other options

```elixir
ExMagick.init()
|> ExMagick.put_image("path/to/input.jpg")
|> ExMagick.put_option("size", "150x150")
|> ExMagick.put_option("rotate", "-90")
|> ExMagick.output("path/to/output.png")
```

## License
This project is licensed under the terms of the MIT license, see LICENSE.
