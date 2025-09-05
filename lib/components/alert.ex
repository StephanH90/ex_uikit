defmodule ExUikit.Components.Alert do
  @moduledoc """
  Alert component for displaying success, warning and error messages.

  Based on UIKit's Alert component: https://getuikit.com/docs/alert

  ## Basic Usage

      <.alert>
        <p>This is a default alert message.</p>
      </.alert>

  ## With Style Modifiers

      <.alert style="primary">
        <p>This is a primary alert.</p>
      </.alert>

      <.alert style="success">
        <p>This is a success alert.</p>
      </.alert>

      <.alert style="warning">
        <p>This is a warning alert.</p>
      </.alert>

      <.alert style="danger">
        <p>This is a danger alert.</p>
      </.alert>

  ## With Close Button

      <.alert style="primary" closeable>
        <p>This alert can be closed.</p>
      </.alert>

  ## With Custom Close Button

      <.alert style="success">
        <a class="uk-alert-close" uk-close></a>
        <h3>Success</h3>
        <p>Your action was completed successfully.</p>
      </.alert>
  """

  use Phoenix.Component

  @doc """
  Alert component with configurable styling and close button.

  ## Examples

      <.alert>
        <p>This is a default alert message.</p>
      </.alert>

      <.alert style="success">
        <p>This is a success alert.</p>
      </.alert>

      <.alert style="danger" closeable>
        <p>This is a danger alert that can be closed.</p>
      </.alert>
  """
  attr :style, :string, default: nil
  attr :closeable, :boolean, default: false
  attr :animation, :string, default: "true"
  attr :duration, :integer, default: 150
  attr :sel_close, :string, default: ".uk-alert-close"
  attr :id, :string, default: nil
  attr :class, :string, default: ""
  attr :rest, :global

  def alert(assigns) do
    style = assigns[:style]

    # Validate style attribute
    if style != nil && style not in ~w(primary success warning danger) do
      raise ArgumentError, """
      :style must be one of: primary, success, warning, danger, or nil
      Got: #{inspect(style)}
      """
    end

    style_class =
      case style do
        "primary" -> "uk-alert-primary"
        "success" -> "uk-alert-success"
        "warning" -> "uk-alert-warning"
        "danger" -> "uk-alert-danger"
        nil -> nil
        _ -> nil
      end

    classes =
      [
        style_class,
        assigns[:class]
      ]
      |> Enum.reject(&is_nil/1)
      |> Enum.join(" ")

    assigns =
      assigns
      |> assign(:class, classes)
      |> assign_new(:id, fn -> "alert-#{System.unique_integer([:positive])}" end)

    ~H"""
    <div
      id={@id}
      class={@class}
      uk-alert
      data-animation={@animation}
      data-duration={@duration}
      data-sel-close={@sel_close}
      phx-hook="UkAlert"
      {@rest}
    >
      <a :if={@closeable} href="#" class="uk-alert-close" uk-close></a>
      {render_slot(@inner_block)}
    </div>
    """
  end
end
