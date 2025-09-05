defmodule ExUikit.Components.Breadcrumb do
  @moduledoc """
  Breadcrumb component for creating navigation breadcrumbs.

  Based on UIKit's Breadcrumb component: https://getuikit.com/docs/breadcrumb

  ## Usage

  The breadcrumb component helps users understand their location within a website
  by providing a trail of navigation links. It consists of a list of items
  separated by dividers.

  ### Basic breadcrumb

      <.breadcrumb>
        <.item><a href="#">Home</a></.item>
        <.item><a href="#">Category</a></.item>
        <.item>Current Page</.item>
      </.breadcrumb>

  ### Breadcrumb with disabled item

      <.breadcrumb>
        <.item><a href="#">Home</a></.item>
        <.item><a href="#">Category</a></.item>
        <.item disabled={true}><a>Disabled Category</a></.item>
        <.item>Current Page</.item>
      </.breadcrumb>

  ## Components

  - `breadcrumb/1` - Main breadcrumb container
  - `item/1` - Individual breadcrumb item
  """

  use Phoenix.Component

  attr :class, :string, default: nil
  attr :rest, :global
  slot :inner_block, required: true

  @doc """
  Main breadcrumb container.

  Renders a `<nav>` element with the `uk-breadcrumb` class for accessibility
  and proper semantic structure. The breadcrumb items are aligned side by side
  with automatic dividers between them.

  ## Attributes

  - `class` - Additional CSS classes to apply
  - `rest` - Global HTML attributes

  ## Example

      <.breadcrumb>
        <.item><a href="#">Home</a></.item>
        <.item><a href="#">Blog</a></.item>
        <.item>Current Article</.item>
      </.breadcrumb>
  """
  def breadcrumb(assigns) do
    ~H"""
    <nav aria-label="Breadcrumb" class={["uk-breadcrumb", @class]} {@rest}>
      <ul>{render_slot(@inner_block)}</ul>
    </nav>
    """
  end

  attr :class, :string, default: nil
  attr :disabled, :boolean, default: false
  attr :rest, :global
  slot :inner_block, required: true

  @doc """
  Individual breadcrumb item.

  Renders a list item that can contain either a link or plain text.
  The disabled state prevents keyboard navigation when applied.

  ## Attributes

  - `class` - Additional CSS classes to apply
  - `disabled` - Whether this item should be disabled
  - `rest` - Global HTML attributes

  ## Examples

  ### Regular item with link

      <.item><a href="#">Home</a></.item>

  ### Disabled item

      <.item disabled={true}><a>Disabled Item</a></.item>

  ### Current page (no link)

      <.item>Current Page</.item>
  """
  def item(assigns) do
    ~H"""
    <li class={[@disabled && "uk-disabled", @class]} {@rest}>
      {render_slot(@inner_block)}
    </li>
    """
  end
end