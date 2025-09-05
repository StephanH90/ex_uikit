defmodule ExUikit.Components.Article do
  @moduledoc """
  Article component for creating articles within your page.

  Based on UIKit's Article component: https://getuikit.com/docs/article
  """

  use Phoenix.Component

  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  def article(assigns) do
    ~H"""
    <article class={["uk-article", @class]} {@rest}>
      {render_slot(@inner_block)}
    </article>
    """
  end
end
