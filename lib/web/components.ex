defmodule ExUikit.Components do
  @moduledoc false

  use Phoenix.Component

  defdelegate article(assigns), to: ExUikit.Components.Article
  defdelegate badge(assigns), to: ExUikit.Components.Badge

  defdelegate grid(assigns), to: ExUikit.Components.Grid
  defdelegate card(assigns), to: ExUikit.Components.Card
  defdelegate container(assigns), to: ExUikit.Components.Container
  defdelegate button(assigns), to: ExUikit.Components.Button
  defdelegate button_group(assigns), to: ExUikit.Components.Button
  defdelegate icon(assigns), to: ExUikit.Components.Icon
  defdelegate modal(assigns), to: ExUikit.Components.Modal
  defdelegate show_modal(selector), to: ExUikit.Components.Modal
end
