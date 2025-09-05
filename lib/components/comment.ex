defmodule ExUikit.Components.Comment do
  @moduledoc """
  A comment component for displaying user comments with optional header and body content.

  This component implements UIkit's [Comment component](https://getuikit.com/docs/comment) 
  which provides styles for comments, for example for a blog section on your site.

  ## Examples

      <.comment>
        <:header>
          <h4 class="uk-comment-title">Author</h4>
          <p class="uk-comment-meta">12 days ago</p>
        </:header>
        <:body>
          <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr.</p>
        </:body>
      </.comment>

      <.comment primary>
        <:body>
          <p>This is a highlighted admin comment.</p>
        </:body>
      </.comment>

  ## Slots

  * `:header` - Optional header content including avatar, title, and meta information
  * `:body` - Required main comment content

  ## Attributes

  * `:primary` - Boolean to apply primary styling (default: `false`)
  * `:rest` - Global HTML attributes

  ## Accessibility

  The component automatically includes `role="comment"` for proper accessibility.
  """

  use Phoenix.Component

  attr :primary, :boolean, default: false, doc: "applies primary styling"
  attr :rest, :global

  slot :header, doc: "header content including avatar, title, and meta"
  slot :body, required: true, doc: "main comment content"

  def comment(assigns) do
    ~H"""
    <article
      class={[
        "uk-comment",
        @primary && "uk-comment-primary",
        @rest[:class]
      ]}
      role="comment"
    >
      <.header :if={render_slot(@header)}>{render_slot(@header)}</.header>
      <.body :if={render_slot(@body)}>{render_slot(@body)}</.body>
    </article>
    """
  end

  defp header(assigns) do
    ~H"""
    <header class="uk-comment-header">
      {render_slot(@inner_block)}
    </header>
    """
  end

  defp body(assigns) do
    ~H"""
    <div class="uk-comment-body">
      {render_slot(@inner_block)}
    </div>
    """
  end
end
