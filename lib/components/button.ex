defmodule ExUikit.Components.Button do
  @moduledoc """
  Button component for creating various styles of buttons.

  Based on UIKit's Button component: https://getuikit.com/docs/button
  """

  use Phoenix.Component

  attr :style, :string, values: ~w(default primary secondary danger text link), default: "default"
  attr :size, :string, values: ~w(small medium large), default: "medium"
  attr :rest, :global

  def button(assigns) do
    ~H"""
    <button class={[@rest[:class], "uk-button", "uk-button-#{@style}", @size]}>
      {render_slot(@inner_block)}
    </button>
    """
  end

  def button_group(assigns) do
    ~H"""
    <div class="uk-button-group">{render_slot(@inner_block)}</div>
    """
  end
end
