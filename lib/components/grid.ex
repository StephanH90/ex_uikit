defmodule ExUikit.Components.Grid do
  @moduledoc """
  Grid component for creating responsive grid layouts.

  Based on UIKit's Grid component: https://getuikit.com/docs/grid
  """

  use Phoenix.Component

  attr :rest, :global

  def grid(assigns) do
    ~H"""
    <div uk-grid class={["uk-grid", @rest[:class]]}>{render_slot(@inner_block)}</div>
    """
  end
end
