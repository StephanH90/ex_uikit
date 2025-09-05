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

## Dependencies
- `tidewave` - Added for enhanced functionality
- Test with `ExUikit.test_tidewave()` to verify integration