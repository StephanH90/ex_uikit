# ExUikit Development Guide

## Build Commands

- `mix compile` - Compile the project
- `mix deps.get` - Fetch dependencies
- `mix format` - Format code according to Elixir standards
- `mix sass.install` - Install Dart Sass

## Lint/Test Commands

- `mix test` - Run all tests
- `mix test --trace` - Run tests with detailed output
- `mix test test/file_test.exs:15` - Run a specific test file/line
- `mix credo` - Run static code analysis
- `mix credo --strict` - Run strict static code analysis
- `mix dialyzer` - Run type checking
- `mix dialyzer --format short` - Run type checking with concise output

## Code Style Guidelines

### Formatting

- Use `mix format` to automatically format code
- Line length: 98 characters
- Use double quotes for strings
- Use `~c""` for charlists instead of single quotes
- Use snake_case for variables and function names

### Imports and Module Structure

- Organize imports alphabetically
- Group stdlib imports first, then external libraries, then internal modules
- Use module attributes for constants at the top of the file
- Follow the GenServer/Plug/Phoenix patterns for respective modules

### Naming Conventions

- Use descriptive function and variable names
- Use `?` suffix for boolean functions (e.g., `valid?/1`)
- Use `!` suffix for functions that raise exceptions
- Use `p` prefix for private functions

### Error Handling

- Use `with` expressions for complex error handling chains
- Return `{:ok, result}` or `{:error, reason}` from functions
- Use `@spec` typespecs for all public functions
- Handle errors gracefully with appropriate logging

### Types

- Use `@type`, `@typedoc` for custom types
- Prefer built-in types when available (e.g., `String.t()`, `map()`)
- Use `| nil` for optional values instead of `nil | type`

## Project Structure

- `lib/` - Main source code
- `lib/components/` - UI components
- `lib/mix/tasks/` - Mix tasks
- `test/` - Test files
- `priv/` - Private assets and templates
- `assets/` - SCSS and other frontend assets

## Component Development

- Components should be stateless functions returning HEEx templates
- Use `Phoenix.Component` conventions
- Include prop documentation with `@doc` attributes
- Follow accessibility guidelines

## Igniter Tasks

- Tasks should follow the `Igniter.Mix.Task` behaviour
- Include comprehensive docs in separate Docs module
- Handle both installation and configuration concerns
- Provide clear success messages to users

## How to write elixir comments

This is an example on how to write a proper elixir comment:

````elixir
@moduledoc """
  A data structure for reading data from a resource.

  Queries are run by calling `Ash.read/2`.

  Examples:

  ```elixir
  require Ash.Query

  MyApp.Post
  |> Ash.Query.filter(likes > 10)
  |> Ash.Query.sort([:title])
  |> Ash.read!()

  MyApp.Author
  |> Ash.Query.aggregate(:published_post_count, :posts, query: [filter: [published: true]])
  |> Ash.Query.sort(published_post_count: :desc)
  |> Ash.Query.limit(10)
  |> Ash.read!()

  MyApp.Author
  |> Ash.Query.load([:post_count, :comment_count])
  |> Ash.Query.load(posts: [:comments])
  |> Ash.read!()
````

To see more examples of what you can do with `Ash.Query` and read actions in general,
see the [writing queries how-to guide](/documentation/how-to/write-queries.livemd).

## Capabilities & Limitations

Ash Framework provides a comprehensive suite of querying tools designed to address common application development needs. While powerful and flexible, these tools are focused on domain-driven design rather than serving as a general-purpose ORM.

Ash's query tools support:

- Filtering records based on complex conditions
- Sorting results using single or multiple criteria
- Setting result limits and offsets
- Pagination, with offset/limit and keysets
- Selecting distinct records to eliminate duplicates
- Computing dynamic properties at query time
- Aggregating data from related resources

While Ash's query tools often eliminate the need for direct database queries, Ash is not itself designed to be a comprehensive ORM or database query builder.

For specialized querying needs that fall outside Ash's standard capabilities, the framework provides escape hatches. These mechanisms allow developers to implement custom query logic when necessary.

### Important Considerations

1. Ash is primarily a domain modeling framework, not a database abstraction layer
2. While comprehensive, the tooling is intentionally constrained to resource-oriented access
3. Escape hatches exist for cases that require custom query logic

For complex queries that fall outside these tools, consider whether they represent domain concepts that could be modeled differently, or if they truly require custom implementation through escape hatches.

## Escape Hatches

Many of the tools in `Ash.Query` are surprisingly deep and capable, covering everything you
need to build your domain logic. With that said, these tools are _not_
designed to encompass _every kind of query_ that you could possibly want to
write over your data. `Ash` is _not_ an ORM or a database query tool, despite
the fact that its query building tools often make those kinds of tools
unnecessary in all but the rarest of cases. Not every kind of query that you
could ever wish to write can be expressed with Ash.Query. Elixir has a
best-in-class library for working directly with databases, called
[Ecto](https://hexdocs.pm/ecto/Ecto.html), and if you end up building a
certain type of feature like analytics or reporting dashboards, you may find
yourself working directly with Ecto. Data layers like AshPostgres are built
on top of Ecto. In fact, every `Ash.Resource` is an `Ecto.Schema`!

> ### Choose escape hatches wisely {: .warning}
>
> You should choose to use Ash builtin functionality wherever possible.
> Barring that, you should choose the _least powerful_ escape hatch that
> can solve your problem. The options below are presented in the order
> that you should prefer them, but you should only use _any of them_
> if no builtin tooling will suffice.

### Fragments

Fragments only barely count as an escape hatch. You will often find yourself
wanting to use a function or operator specific to your data layer, and fragments
are purpose built to this end. You can use data-layer-specific expressions in your
expressions for filters, calculations, etc. For example:

```elixir
Resource
|> Ash.Query.filter(expr(fragment("lower(?)", name) == "fred"))
|> Ash.Query.filter(expr(fragment("? @> ?", tags, ["important"])))
```

### Manual Read Actions

See [the manual read actions guide](/documentation/topics/actions/manual-actions.md).

### `d:Ash.Resource.Dsl|actions.read.modify_query`

When running read actions, you can modify the underlying data layer query directly,
which can solve for cases when you cannot express your query using the standard Ash query interface.

```elixir
actions do
  read :complex_search do
    argument
    modify_query {SearchMod, :modify, []}
  end
end
```

```elixir
defmodule SearchMod do
  def modify(ash_query, data_layer_query) do
    # Here you can modify the underlying data layer query directly
    # For example, with AshPostgres you get access to the Ecto query
    {:ok, Ecto.Query.where(data_layer_query, [p], fragment("? @@ plainto_tsquery(?)", p.search_vector, ^ash_query.arguments.search_text))}
  end
end
```

### Using Ecto directly

For data layers like `AshPostgres`, you can interact directly with `Ecto`. You can do this
by using the `Ash.Resource` as its corresponding `Ecto.Schema`, like so:

```elixir
import Ecto.Query

query =
  from p in MyApp.Post,
    where: p.likes > 100,
    select: p

 MyApp.Repo.all(query)
```

Or you can build an `Ash.Query`, and get the corresponding ecto query:

```elixir
MyApp.Post
|> Ash.Query.for_read(:read)
|> Ash.data_layer_query()
|> case do
  {:ok, %{query: ecto_query}} ->
    ecto_query
    |> Ecto.Query.where([p], p.likes > 100)
    |> MyApp.Repo.all()

  {:error, error} ->
    {:error, error}
end
```

"""

```

```
