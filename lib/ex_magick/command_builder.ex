defmodule ExMagick.CommandBuilder do
  defstruct command: "convert", args: []

  def put_file(%__MODULE__{args: args} = builder, file)
      when is_list(args) do
    %__MODULE__{
      builder
      | args: Enum.concat(builder.args, [file])
    }
  end

  def put_args(builder, key, value \\ nil, opts \\ [])

  def put_args(%__MODULE__{args: args} = builder, key, value, opts)
      when (is_list(args) and is_binary(value)) or is_nil(value) do
    %__MODULE__{
      builder
      | args:
          Enum.concat(
            builder.args,
            ["#{Keyword.get(opts, :prefix, "-")}#{key}", value]
            |> Enum.reject(&is_nil/1)
          )
    }
  end

  def put_args(%__MODULE__{args: args} = builder, key, opts, _opts)
      when is_list(args) and is_list(opts) do
    %__MODULE__{
      builder
      | args:
          Enum.concat(
            builder.args,
            ["#{Keyword.get(opts, :prefix, "-")}#{key}"]
            |> Enum.reject(&is_nil/1)
          )
    }
  end
end
