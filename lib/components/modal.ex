defmodule ExUikit.Components.Modal do
  use Phoenix.Component

  attr :id, :string, required: true, doc: "ID of the modal"
  attr :title, :string, default: nil
  attr :close_btn, :boolean, default: false, doc: "If true shows a close button on the top right"
  attr :shown, :boolean, default: false, doc: "If the modal is shown"
  attr :on_hide, :any, default: nil, doc: "JS commands that will be run when the modal is hidden"
  attr :on_show, :any, default: nil, doc: "JS commands that are run when the modal is shown"
  attr :rest, :global
  slot :inner_block, required: true
  slot :header, required: false
  slot :footer, required: false

  def modal(assigns) do
    ~H"""
    <div
      id={@id}
      phx-hook="UkModal"
      data-shown={(@shown && "true") || (@shown === false && "false")}
      data-on-hide={@on_hide}
    >
      <div uk-modal {@rest}>
        <div class="uk-modal-dialog">
          <button class="uk-modal-close-default" type="button" uk-close></button>
          {render_slot(@inner_block)}
        </div>
      </div>
    </div>
    """
  end

  attr :rest, :global
  slot :inner_block, required: true

  def header(assigns) do
    ~H"""
    <div class={["uk-modal-header", @rest[:class]]} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :rest, :global
  slot :inner_block, required: true

  def body(assigns) do
    ~H"""
    <div class={["uk-modal-body", @rest[:class]]} {@rest}>
      {render_slot(@inner_block)}
    </div>
    """
  end

  attr :rest, :global
  slot :inner_block, required: true

  def footer(assigns) do
    ~H"""
    <div class={["uk-modal-footer", @rest[:class]]} {@rest}>{render_slot(@inner_block)}</div>
    """
  end

  @doc """
  Use this function to show a modal on click.

  Example:

  <button phx-click={ExUikit.Components.show_modal("#the-id-of-my-modal")}>Show modal</button>
  """
  def show_modal(js \\ %Phoenix.LiveView.JS{}, selector) do
    js
    |> Phoenix.LiveView.JS.dispatch("showModal", to: selector, detail: %{"selector" => selector})
  end
end
