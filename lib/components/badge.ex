defmodule ExUikit.Components.Badge do
  @moduledoc """
  Badge component for creating nice looking notification badges.

  Based on UIKit's Badge component: https://getuikit.com/docs/badge
  """

  use Phoenix.Component

  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def badge(assigns) do
    ~H"""
    <span class={["uk-badge", @class]} {@rest}>
      {render_slot(@inner_block)}
    </span>
    """
  end
end
