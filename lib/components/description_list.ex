defmodule ExUikit.Components.DescriptionList do
  @moduledoc """
  Description list component for displaying terms and descriptions.

  Based on UIKit's Description List component: https://getuikit.com/docs/description-list

  ## Examples

  ### Basic description list

      <.description_list>
        <:item term="Description term">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        </:item>
        <:item term="Description term">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        </:item>
      </.description_list>

  ### Description list with dividers

      <.description_list divider>
        <:item term="Description term">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        </:item>
        <:item term="Description term">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        </:item>
      </.description_list>

  ## Slots

  * `:item` - Individual description list item with term and description

  ## Attributes

  * `:divider` - Boolean to add horizontal lines between items (default: `false`)
  * `:rest` - Global HTML attributes
  """

  use Phoenix.Component

  attr :divider, :boolean, default: false, doc: "adds horizontal lines between items"
  attr :rest, :global

  slot :item, required: true do
    attr :term, :string, required: true, doc: "the term/description title"
  end

  def description_list(assigns) do
    ~H"""
    <dl
      class={[
        "uk-description-list",
        @divider && "uk-description-list-divider",
        @rest[:class]
      ]}
      {@rest}
    >
      <.item :for={item <- @item} term={item.term}>
        {render_slot(item)}
      </.item>
    </dl>
    """
  end

  attr :term, :string, required: true
  attr :rest, :global
  slot :inner_block, required: true

  defp item(assigns) do
    ~H"""
    <dt {@rest}>{@term}</dt>
    <dd>{render_slot(@inner_block)}</dd>
    """
  end
end
