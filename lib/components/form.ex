defmodule ExUikit.Components.Form do
  @moduledoc """
  Form components for creating various types of form elements.

  Based on UIKit's Form component: https://getuikit.com/docs/form

  ## Basic Usage

  ```elixir
  <form>
    <.input type="text" placeholder="Enter your name"/>
    <.select>
      <option>Option 1</option>
      <option>Option 2</option>
    </.select>
    <.textarea rows="5" placeholder="Enter your message"/>
    <.radio name="choice" value="option1" label="Option 1"/>
    <.radio name="choice" value="option2" label="Option 2"/>
    <.checkbox name="terms" value="accepted" label="I agree to terms"/>
    <.range min="0" max="100" value="50"/>
  </form>
  ```
  """

  use Phoenix.Component

  @doc """
  Input component for text inputs.

  ## Examples

      <.input type="text" placeholder="Enter your name"/>
      <.input type="email" value="user@example.com" class="uk-form-success"/>
      <.input type="password" placeholder="Password" required/>
  """
  attr :type, :string, default: "text", values: ~w(text email password number tel search url)
  attr :class, :string, default: ""
  attr :placeholder, :string, default: nil
  attr :value, :string, default: nil
  attr :name, :string, default: nil
  attr :id, :string, default: nil
  attr :required, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :readonly, :boolean, default: false
  attr :autocomplete, :string, default: nil
  attr :autofocus, :boolean, default: false
  attr :rest, :global

  def input(assigns) do
    classes =
      [
        "uk-input",
        assigns[:class]
      ]
      |> Enum.reject(&is_nil/1)
      |> Enum.join(" ")

    assigns =
      assigns
      |> assign(:class, classes)
      |> assign_new(:aria_label, fn -> assigns[:placeholder] || "Input" end)

    ~H"""
    <input
      type={@type}
      class={@class}
      placeholder={@placeholder}
      value={@value}
      name={@name}
      id={@id}
      required={@required}
      disabled={@disabled}
      readonly={@readonly}
      autocomplete={@autocomplete}
      autofocus={@autofocus}
      {@rest}
    />
    """
  end

  @doc """
  Select component for dropdown selections.

  ## Examples

      <.select aria-label="Choose an option">
        <option>Option 1</option>
        <option>Option 2</option>
      </.select>
      <.select disabled>
        <option>Disabled option</option>
      </.select>
  """
  attr :class, :string, default: ""
  attr :aria_label, :string, default: "Select"
  attr :name, :string, default: nil
  attr :id, :string, default: nil
  attr :required, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :multiple, :boolean, default: false
  attr :size, :integer, default: nil
  attr :rest, :global

  def select(assigns) do
    classes =
      [
        "uk-select",
        assigns[:class]
      ]
      |> Enum.reject(&is_nil/1)
      |> Enum.join(" ")

    assigns =
      assigns
      |> assign(:class, classes)

    ~H"""
    <select
      class={@class}
      aria-label={@aria_label}
      name={@name}
      id={@id}
      required={@required}
      disabled={@disabled}
      multiple={@multiple}
      size={@size}
      {@rest}
    >
      {render_slot(@inner_block)}
    </select>
    """
  end

  @doc """
  Textarea component for multi-line text input.

  ## Examples

      <.textarea rows="5" placeholder="Enter your message"/>
      <.textarea value="Pre-filled text" class="uk-form-large"/>
      <.textarea rows="3" required disabled>
        Default text
      </.textarea>
  """
  attr :rows, :integer, default: 3
  attr :class, :string, default: ""
  attr :placeholder, :string, default: nil
  attr :value, :string, default: nil
  attr :name, :string, default: nil
  attr :id, :string, default: nil
  attr :required, :boolean, default: false
  attr :disabled, :boolean, default: false
  attr :readonly, :boolean, default: false
  attr :autofocus, :boolean, default: false
  attr :rest, :global

  slot :inner_block, required: false

  def textarea(assigns) do
    classes =
      [
        "uk-textarea",
        assigns[:class]
      ]
      |> Enum.reject(&is_nil/1)
      |> Enum.join(" ")

    assigns =
      assigns
      |> assign(:class, classes)
      |> assign_new(:aria_label, fn -> assigns[:placeholder] || "Textarea" end)

    ~H"""
    <textarea
      rows={@rows}
      class={@class}
      placeholder={@placeholder}
      value={@value}
      name={@name}
      id={@id}
      required={@required}
      disabled={@disabled}
      readonly={@readonly}
      autofocus={@autofocus}
      {@rest}
    >{render_slot(@inner_block)}</textarea>
    """
  end

  @doc """
  Radio button component.

  ## Examples

      <.radio name="choice" value="option1" label="Option 1"/>
      <.radio name="choice" value="option2" checked label="Option 2"/>
      <.radio name="choice" value="option3" disabled label="Option 3"/>
  """
  attr :name, :string, required: true
  attr :value, :string, required: true
  attr :checked, :boolean, default: false
  attr :class, :string, default: ""
  attr :disabled, :boolean, default: false
  attr :label, :string, default: nil
  attr :rest, :global

  def radio(assigns) do
    classes =
      [
        "uk-radio",
        assigns[:class]
      ]
      |> Enum.reject(&is_nil/1)
      |> Enum.join(" ")

    assigns =
      assigns
      |> assign(:class, classes)

    ~H"""
    <label>
      <input
        type="radio"
        name={@name}
        value={@value}
        checked={@checked}
        class={@class}
        disabled={@disabled}
        {@rest}
      />
      <%= if @label do %>
        {@label}
      <% else %>
        {render_slot(@inner_block)}
      <% end %>
    </label>
    """
  end

  @doc """
  Checkbox component.

  ## Examples

      <.checkbox name="choice" value="option1" label="Option 1"/>
      <.checkbox name="choice" value="option2" checked label="Option 2"/>
      <.checkbox name="choice" value="option3" disabled label="Option 3"/>
  """
  attr :name, :string, required: true
  attr :value, :string, required: true
  attr :checked, :boolean, default: false
  attr :class, :string, default: ""
  attr :disabled, :boolean, default: false
  attr :label, :string, default: nil
  attr :rest, :global

  def checkbox(assigns) do
    classes =
      [
        "uk-checkbox",
        assigns[:class]
      ]
      |> Enum.reject(&is_nil/1)
      |> Enum.join(" ")

    assigns =
      assigns
      |> assign(:class, classes)

    ~H"""
    <label>
      <input
        type="checkbox"
        name={@name}
        value={@value}
        checked={@checked}
        class={@class}
        disabled={@disabled}
        {@rest}
      />
      <%= if @label do %>
        {@label}
      <% else %>
        {render_slot(@inner_block)}
      <% end %>
    </label>
    """
  end

  @doc """
  Range input component.

  ## Examples

      <.range min="0" max="100" value="50"/>
      <.range min="0" max="10" step="0.1" value="2.5"/>
      <.range min="0" max="100" value="75" class="uk-form-large"/>
  """
  attr :min, :string, default: "0"
  attr :max, :string, default: "100"
  attr :step, :string, default: "1"
  attr :value, :string, default: nil
  attr :class, :string, default: ""
  attr :name, :string, default: nil
  attr :id, :string, default: nil
  attr :disabled, :boolean, default: false
  attr :rest, :global

  def range(assigns) do
    classes =
      [
        "uk-range",
        assigns[:class]
      ]
      |> Enum.reject(&is_nil/1)
      |> Enum.join(" ")

    assigns =
      assigns
      |> assign(:class, classes)
      |> assign_new(:aria_label, fn -> "Range" end)

    ~H"""
    <input
      type="range"
      min={@min}
      max={@max}
      step={@step}
      value={@value}
      class={@class}
      name={@name}
      id={@id}
      disabled={@disabled}
      aria-label={@aria_label}
      {@rest}
    />
    """
  end
end
