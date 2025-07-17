defmodule ExUikit.Components.Grid do
  use Phoenix.Component

  attr :rest, :global

  def grid(assigns) do
    ~H"""
    <div uk-grid class={["uk-grid", @rest[:class]]}>{render_slot(@inner_block)}</div>
    """
  end
end
