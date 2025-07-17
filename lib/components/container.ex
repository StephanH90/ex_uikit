defmodule ExUikit.Components.Container do
  use Phoenix.Component

  attr :size, :string, values: ~w(xsmall small large xlarge expand), default: "large"

  def container(assigns) do
    ~H"""
    <div class={["uk-container", @size]}>{render_slot(@inner_block)}</div>
    """
  end
end
