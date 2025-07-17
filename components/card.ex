defmodule ExUikit.Components.Card do
  @moduledoc false

  use Phoenix.Component

  attr :style, :string,
    values: ~w(uk-card-default uk-card-primary uk-card-secondary),
    default: "uk-card-default"

  attr :hover, :boolean, default: false, doc: "creates a hover effect"
  attr :size, :string, values: ~w(small medium large), default: "medium"
  attr :rest, :global

  def card(assigns) do
    ~H"""
    <div class={[
      "uk-card",
      @style,
      @hover && "uk-card-hover",
      @size && "uk-card-#{@size}",
      @rest[:class]
    ]}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  def body(assigns) do
    ~H"""
    <div class="uk-card-body">{render_slot(@inner_block)}</div>
    """
  end

  def header(assigns) do
    ~H"""
    <div class="uk-card-header">{render_slot(@inner_block)}</div>
    """
  end

  def footer(assigns) do
    ~H"""
    <div class="uk-card-footer">{render_slot(@inner_block)}</div>
    """
  end
end
