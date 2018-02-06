defmodule ExMagick do
  alias ExMagick.CommandBuilder, as: Builder

  @doc """
  Generate the command builder struct.

  ## Examples

      iex> ExMagick.init()
      %ExMagick.CommandBuilder{command: "convert", options: []}

  """
  def init do
    %Builder{}
  end

  @doc """
  Set a file path to the command builder.

  ## Examples

      iex> ExMagick.init() |> ExMagick.open("test.png")
      %ExMagick.CommandBuilder{command: "convert", options: ["test.png"]}

  """
  def open(%Builder{} = builder, path) when is_binary(path) do
    Builder.put_file(builder, path)
  end

  @doc """
  Set a file by base64 encoded image to the command builder.

  ## Examples

      iex> ExMagick.init() |> ExMagick.open_with_base64("data:image/png;base64,....")
      %ExMagick.CommandBuilder{command: "convert", options: ["inline:data:data:image/png;base64,...."]}

  """
  def open_with_base64(%Builder{} = builder, encoded_image) do
    # TODO sanitize encoded_image
    Builder.put_file(builder, "inline:data:#{encoded_image}")
  end

  @fill_map [
    fill: :xc,
    gradient: :gradient
  ]
  @doc """
  Set a file by RGB color to the command builder.

  ## Examples

      iex> ExMagick.init() |> ExMagick.open_with_color("#00aaff")
      %ExMagick.CommandBuilder{command: "convert", options: ["xc:#00aaff"]}
      iex> ExMagick.init() |> ExMagick.open_with_color("#00aaff-#ffaa00", fill: :gradient)
      %ExMagick.CommandBuilder{command: "convert", options: ["gradient:#00aaff-#ffaa00"]}

  """
  def open_with_color(%Builder{} = builder, rgb, opts \\ [fill: :fill]) do
    # TODO sanitize rgb to have # prefix
    # TODO sanitize rgb for gradient
    Builder.put_file(builder, "#{@fill_map[opts[:fill]]}:#{rgb}")
  end

  @doc """
  Set an option to the command builder.

  ## Examples

      iex> ExMagick.init() |> ExMagick.put_option("size", "150x150")
      %ExMagick.CommandBuilder{command: "convert", options: ["-size", "150x150"]}

  """
  def put_option(%Builder{} = builder, key, value) do
    Builder.put_option(builder, key, value)
  end

  @doc """
  Output the image from command builder.
  """
  def output(%Builder{} = builder, output_name) do
    builder = Builder.put_file(builder, output_name)
    System.cmd(builder.command, builder.options)
  end
end
