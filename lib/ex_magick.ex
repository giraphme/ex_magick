defmodule ExMagick do
  alias ExMagick.CommandBuilder, as: Builder

  @doc """
  ## Example
    iex> ExMagick.init()
    %ExMagick.CommandBuilder{command: "convert", options: [], output_name: nil}
  """
  def init do
    %Builder{}
  end

  @doc """
  ## Example
    iex> ExMagick.init() |> ExMagick.open("test.png")
    %ExMagick.CommandBuilder{command: "convert", options: ["test.png"], output_name: nil}
  """
  def open(%Builder{} = builder, path) when is_binary(path) do
    Builder.put_file(builder, path)
  end

  @doc """
  ## Example
    iex> ExMagick.init() |> ExMagick.open_with_base64("data:image/png;base64,....")
    %ExMagick.CommandBuilder{command: "convert", options: ["inline:data:data:image/png;base64,...."], output_name: nil}
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
  ## Example
    iex> ExMagick.init() |> ExMagick.open_with_color("#00aaff")
    %ExMagick.CommandBuilder{command: "convert", options: ["xc:#00aaff"], output_name: nil}
    iex> ExMagick.init() |> ExMagick.open_with_color("#00aaff-#ffaa00", fill: :gradient)
    %ExMagick.CommandBuilder{command: "convert", options: ["gradient:#00aaff-#ffaa00"], output_name: nil}
  """
  def open_with_color(%Builder{} = builder, rgb, opts \\ [fill: :fill]) do
    # TODO sanitize rgb to have # prefix
    # TODO sanitize rgb for gradient
    Builder.put_file(builder, "#{@fill_map[opts[:fill]]}:#{rgb}")
  end

  @doc """
  ## Example
    iex> ExMagick.init() |> ExMagick.put_option("size", "150 x 150")
    %ExMagick.CommandBuilder{command: "convert", options: ["-size 150 x 150"], output_name: nil}
  """
  def put_option(%Builder{} = builder, key, value) do
    Builder.put_option(builder, key, value)
  end

  def output(%Builder{} = builder, output_name) do
    builder = Builder.put_file(builder, output_name)
    System.cmd(builder.command, builder.options)
  end
end
