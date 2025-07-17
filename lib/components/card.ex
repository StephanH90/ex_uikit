defmodule ExUikit.Components.Card do
  @moduledoc false

  use Phoenix.Component

  attr :style, :string,
    values: ~w(uk-card-default uk-card-primary uk-card-secondary),
    default: "uk-card-default"

  attr :hover, :boolean, default: false, doc: "creates a hover effect"
  attr :size, :string, values: ~w(small medium large), default: "medium"
  attr :rest, :global

  slot :header
  slot :body, required: true
  slot :footer
  slot :media_left

  def card(assigns) do
    ~H"""
    <div class={[
      "uk-card",
      @style,
      @hover && "uk-card-hover",
      @size && "uk-card-#{@size}",
      @rest[:class]
    ]}>
      <.header :if={render_slot(@header)}>{render_slot(@header)}</.header>
      <.body :if={render_slot(@body)}>{render_slot(@body)}</.body>
      <.footer :if={render_slot(@footer)}>{render_slot(@footer)}</.footer>
    </div>
    """
  end

  defp body(assigns) do
    ~H"""
    <div class="uk-card-body">
      {render_slot(@inner_block)}
    </div>
    """
  end

  defp header(assigns) do
    ~H"""
    <div class="uk-card-header">{render_slot(@inner_block)}</div>
    """
  end

  defp footer(assigns) do
    ~H"""
    <div class="uk-card-footer">{render_slot(@inner_block)}</div>
    """
  end
end
