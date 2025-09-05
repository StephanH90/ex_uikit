defmodule ExUikit.Components.Dropnav do
  @moduledoc """
  Dropnav component for creating dropdown menus for any navigation.

  Based on UIKit's Dropnav component: https://getuikit.com/docs/dropnav

  The Dropnav component initializes all dropdowns in navigation with the same 
  options, so they don't have to be initialized individually. All dropdowns within 
  the dropnav are aim-aware and support hover and click modes.

  ## Examples

  ### Basic dropnav with subnav

      <.dropnav>
        <ul class="uk-subnav">
          <li class="uk-active"><a href="#">Active</a></li>
          <li>
            <a href>Parent <span uk-drop-parent-icon></span></a>
            <div class="uk-dropdown">
              <ul class="uk-nav uk-dropdown-nav">
                <li class="uk-active"><a href="#">Active</a></li>
                <li><a href="#">Item</a></li>
                <li><a href="#">Item</a></li>
              </ul>
            </div>
          </li>
          <li><a href="#">Item</a></li>
        </ul>
      </.dropnav>

  ### Dropnav with dropbar

      <.dropnav dropbar>
        <ul class="uk-subnav">
          <li class="uk-active"><a href="#">Active</a></li>
          <li>
            <a href>Item</a>
            <div class="uk-dropdown">
              <ul class="uk-nav uk-dropdown-nav">
                <li class="uk-active"><a href="#">Active</a></li>
                <li><a href="#">Item</a></li>
                <li class="uk-nav-header">Header</li>
                <li><a href="#">Item</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </.dropnav>

  ### Click mode dropnav

      <.dropnav mode="click">
        <ul class="uk-subnav">
          <li class="uk-active"><a href="#">Active</a></li>
          <li>
            <a href>Parent <span uk-drop-parent-icon></span></a>
            <div class="uk-dropdown">
              <ul class="uk-nav uk-dropdown-nav">
                <li class="uk-active"><a href="#">Active</a></li>
                <li><a href="#">Item</a></li>
                <li><a href="#">Item</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </.dropnav>

  ### Dropnav with alignment

      <.dropnav align="center">
        <ul class="uk-subnav uk-flex-center">
          <li class="uk-active"><a href="#">Active</a></li>
          <li>
            <a href>Parent <span uk-drop-parent-icon></span></a>
            <div class="uk-dropdown">
              <ul class="uk-nav uk-dropdown-nav">
                <li class="uk-active"><a href="#">Active</a></li>
                <li><a href="#">Item</a></li>
                <li><a href="#">Item</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </.dropnav>

  ## Attributes

  * `:align` - Dropdown alignment: "left", "right", or "center" (default: "left")
  * `:dropbar` - Boolean to enable dropbar behavior (default: `false`)
  * `:dropbar_anchor` - CSS selector for dropbar anchor element (default: `nil`)
  * `:mode` - Trigger mode: "hover", "click", or "hover, click" (default: "hover")
  * `:delay_show` - Delay before showing in hover mode in ms (default: 0)
  * `:delay_hide` - Delay before hiding in hover mode in ms (default: 800)
  * `:boundary` - CSS selector for boundary (default: `true`)
  * `:target` - CSS selector for target element (default: `false`)
  * `:stretch` - Stretch dropdown: true, false, "x", or "y" (default: `false`)
  * `:offset` - Custom offset in pixels (default: 0)
  * `:animation` - Animation name (default: "uk-animation-fade")
  * `:duration` - Animation duration in milliseconds (default: 200)
  * `:rest` - Global HTML attributes

  ## Slots

  * `:inner_block` - Navigation content with dropdowns (required)
  """

  use Phoenix.Component

  attr :align, :string, default: "left", doc: "dropdown alignment: left, right, or center"
  attr :dropbar, :boolean, default: false, doc: "enable dropbar behavior"
  attr :dropbar_anchor, :string, default: nil, doc: "CSS selector for dropbar anchor"
  attr :mode, :string, default: "hover", doc: "trigger mode: hover, click, or hover, click"
  attr :delay_show, :integer, default: 0, doc: "delay before showing in hover mode"
  attr :delay_hide, :integer, default: 800, doc: "delay before hiding in hover mode"
  attr :boundary, :string, default: "true", doc: "CSS selector for boundary"
  attr :target, :string, default: "false", doc: "CSS selector for target element"
  attr :stretch, :any, default: false, doc: "stretch dropdown: true, false, x, or y"
  attr :offset, :integer, default: 0, doc: "custom offset in pixels"
  attr :animation, :string, default: "uk-animation-fade", doc: "animation name"
  attr :duration, :integer, default: 200, doc: "animation duration in milliseconds"
  attr :rest, :global

  slot :inner_block, required: true

  def dropnav(assigns) do
    ~H"""
    <nav
      id={ExUikit.Utils.random_dom_id()}
      phx-hook="UkDropnav"
      data-align={@align}
      data-dropbar={@dropbar}
      data-dropbar-anchor={@dropbar_anchor}
      data-mode={@mode}
      data-delay-show={@delay_show}
      data-delay-hide={@delay_hide}
      data-boundary={@boundary}
      data-target={@target}
      data-stretch={@stretch}
      data-offset={@offset}
      data-animation={@animation}
      data-duration={@duration}
      class={[@rest[:class]]}
      {@rest}
    >
      {render_slot(@inner_block)}
    </nav>
    """
  end
end
