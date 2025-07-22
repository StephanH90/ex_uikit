defmodule ExUikit.Utils do
  def random_dom_id(), do: "id-#{System.unique_integer()}"
end
