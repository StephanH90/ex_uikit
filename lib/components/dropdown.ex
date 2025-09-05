defmodule ExUikit.Components.Dropdown do
  @moduledoc """
  Dropdown component for creating toggleable dropdown menus.

  Based on UIKit's Dropdown component: https://getuikit.com/docs/dropdown

  ## Examples

  ### Basic dropdown

      <div class="uk-inline">
        <button class="uk-button uk-button-default">Hover</button>
        <.dropdown>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        </.dropdown>
      </div>

  ### Click mode dropdown

      <div class="uk-inline">
        <button class="uk-button uk-button-default">Click</button>
        <.dropdown mode="click">
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        </.dropdown>
      </div>

  ### Dropdown with navigation

      <div class="uk-inline">
        <button class="uk-button uk-button-default">Menu</button>
        <.dropdown>
          <ul class="uk-nav uk-dropdown-nav">
            <li class="uk-active"><a href="#">Active</a></li>
            <li><a href="#">Item</a></li>
            <li class="uk-nav-header">Header</li>
            <li><a href="#">Item</a></li>
            <li class="uk-nav-divider"></li>
            <li><a href="#">Item</a></li>
          </ul>
        </.dropdown>
      </div>

  ### Large dropdown with custom position

      <div class="uk-inline">
        <button class="uk-button uk-button-default">Large</button>
        <.dropdown large pos="top-right">
          <ul class="uk-nav uk-dropdown-nav">
            <li class="uk-active"><a href="#">Active</a></li>
            <li><a href="#">Item</a></li>
            <li><a href="#">Item</a></li>
          </ul>
        </.dropdown>
      </div>

  ## Attributes

  * `:mode` - Trigger mode: "hover", "click", or "hover, click" (default: "hover")
  * `:pos` - Position: "top-left", "bottom-center", "right-top", etc. (default: "bottom-left")
  * `:large` - Boolean to apply large padding (default: `false`)
  * `:animation` - Animation name (default: "uk-animation-fade")
  * `:duration` - Animation duration in milliseconds (default: 200)
  * `:offset` - Custom offset in pixels (default: 0)
  * `:delay_show` - Delay before showing in hover mode in ms (default: 0)
  * `:delay_hide` - Delay before hiding in hover mode in ms (default: 800)
  * `:boundary` - CSS selector for boundary (default: false)
  * `:target` - CSS selector for target element (default: false)
  * `:stretch` - Stretch dropdown: true, false, "x", or "y" (default: false)
  * `:flip` - Boolean to enable flipping (default: true)
  * `:shift` - Boolean to enable shifting (default: true)
  * `:auto_update` - Boolean to enable dynamic positioning (default: true)
  * `:rest` - Global HTML attributes

  ## Slots

  * `:inner_block` - Dropdown content (required)
  """

  use Phoenix.Component

  attr :mode, :string, default: "hover", doc: "trigger mode: hover, click, or hover, click"
  attr :pos, :string, default: "bottom-left", doc: "dropdown position"
  attr :large, :boolean, default: false, doc: "apply large padding"
  attr :animation, :string, default: "uk-animation-fade", doc: "animation name"
  attr :duration, :integer, default: 200, doc: "animation duration in milliseconds"
  attr :offset, :integer, default: 0, doc: "custom offset in pixels"
  attr :delay_show, :integer, default: 0, doc: "delay before showing in hover mode"
  attr :delay_hide, :integer, default: 800, doc: "delay before hiding in hover mode"
  attr :boundary, :string, default: nil, doc: "CSS selector for boundary"
  attr :target, :string, default: nil, doc: "CSS selector for target element"
  attr :stretch, :any, default: false, doc: "stretch dropdown: true, false, x, or y"
  attr :flip, :boolean, default: true, doc: "enable flipping"
  attr :shift, :boolean, default: true, doc: "enable shifting"
  attr :auto_update, :boolean, default: true, doc: "enable dynamic positioning"
  attr :rest, :global

  slot :inner_block, required: true

  def dropdown(assigns) do
    ~H"""
    <div
      id={ExUikit.Utils.random_dom_id()}
      phx-hook="UkDropdown"
      data-mode={@mode}
      data-pos={@pos}
      data-large={@large}
      data-animation={@animation}
      data-duration={@duration}
      data-offset={@offset}
      data-delay-show={@delay_show}
      data-delay-hide={@delay_hide}
      data-boundary={@boundary}
      data-target={@target}
      data-stretch={@stretch}
      data-flip={@flip}
      data-shift={@shift}
      data-auto-update={@auto_update}
      class={[
        "uk-dropdown",
        @large && "uk-dropdown-large",
        @rest[:class]
      ]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </div>
    """
  end
end