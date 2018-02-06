defmodule ExMagick.CommandBuilder do
  defstruct command: "convert", options: []

  def put_file(%__MODULE__{options: options} = builder, file)
      when is_list(options) do
    %__MODULE__{
      builder
      | options: Enum.concat(builder.options, [file])
    }
  end

  def put_option(%__MODULE__{options: options} = builder, key, value)
      when is_list(options) do
    %__MODULE__{
      builder
      | options: Enum.concat(builder.options, ["-#{key}", value])
    }
  end
end
