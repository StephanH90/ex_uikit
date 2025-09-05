defmodule ExUikit.Components.Container do
  @moduledoc """
  Container component for centering and padding your site content.

  Based on UIKit's Container component: https://getuikit.com/docs/container
  """

  use Phoenix.Component

  attr :size, :string, values: ~w(xsmall small large xlarge expand), default: "large"

  def container(assigns) do
    ~H"""
    <div class={["uk-container", @size]}>{render_slot(@inner_block)}</div>
    """
  end
end
