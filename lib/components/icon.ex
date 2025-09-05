defmodule ExUikit.Components.Icon do
  @moduledoc """
  Icon component for displaying UIkit icons.

  Based on UIKit's Icon component: https://getuikit.com/docs/icon
  """

  use Phoenix.Component

  attr :icon, :string, required: true, doc: "name of uikit icon"
  attr :ratio, :string, default: "1"
  attr :rest, :global

  def icon(assigns) do
    ~H"""
    <span
      id={ExUikit.Utils.random_dom_id()}
      uk-icon
      icon={@icon}
      ratio={@ratio}
      {@rest}
      phx-hook="UkIcon"
      phx-update="ignore"
    >
    </span>
    """
  end
end
