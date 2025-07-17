defmodule Mix.Tasks.ExUikit.Install.Docs do
  @moduledoc false

  @spec short_doc() :: String.t()
  def short_doc do
    "A short description of your task"
  end

  @spec example() :: String.t()
  def example do
    "mix ex_uikit.install --example arg"
  end

  @spec long_doc() :: String.t()
  def long_doc do
    """
    #{short_doc()}

    Longer explanation of your task

    ## Example

    ```sh
    #{example()}
    ```

    ## Options

    * `--example-option` or `-e` - Docs for your option
    """
  end
end

if Code.ensure_loaded?(Igniter) do
  defmodule Mix.Tasks.ExUikit.Install do
    @shortdoc "#{__MODULE__.Docs.short_doc()}"

    @moduledoc __MODULE__.Docs.long_doc()

    @sass_version "1.77.0"
    @sass_args ~w(--embed-source-map --source-map-urls=absolute --watch)

    use Igniter.Mix.Task
    import Sourceror, only: [parse_string!: 1]

    @impl Igniter.Mix.Task
    def info(_argv, _composing_task) do
      %Igniter.Mix.Task.Info{
        # Groups allow for overlapping arguments for tasks by the same author
        # See the generators guide for more.
        group: :ex_uikit,
        # *other* dependencies to add
        # i.e `{:foo, "~> 2.0"}`
        adds_deps: [],
        # *other* dependencies to add and call their associated installers, if they exist
        # i.e `{:foo, "~> 2.0"}`
        installs: [],
        # An example invocation
        example: __MODULE__.Docs.example(),
        # A list of environments that this should be installed in.
        only: nil,
        # a list of positional arguments, i.e `[:file]`
        positional: [],
        # Other tasks your task composes using `Igniter.compose_task`, passing in the CLI argv
        # This ensures your option schema includes options from nested tasks
        composes: [],
        # `OptionParser` schema
        schema: [],
        # Default values for the options in the `schema`
        defaults: [],
        # CLI aliases
        aliases: [],
        # A list of options in the schema that are required
        required: []
      }
    end

    @impl Igniter.Mix.Task
    def igniter(igniter) do
      app = Igniter.Project.Application.app_name(igniter)
      endpoint = Module.concat([Macro.camelize(to_string(app)), "Web.Endpoint"])
      template = :ex_uikit |> :code.priv_dir() |> Path.join("templates/app.scss.eex")

      igniter
      |> Igniter.Project.Deps.add_dep({:ex_uikit, "~> 0.1"})
      |> Igniter.Project.Deps.add_dep({:dart_sass, "~> 0.7", runtime: false})
      |> Igniter.Project.Config.configure_new(
        "config/config.exs",
        :dart_sass,
        [:version],
        @sass_version
      )
      |> Igniter.Project.Config.configure(
        "config/dev.exs",
        app,
        [endpoint, :watchers, :sass],
        {:code,
         parse_string!(
           "{DartSass, :install_and_run, [:default, ~w(#{Enum.join(@sass_args, " ")})]}"
         )}
      )

      # |> Igniter.copy_template(template, "assets/css/app.scss", [])
      # |> Igniter.success("""
      # ✅  ExUikit installed.
      #    • Run `mix deps.get`
      #    • Restart your server – the new SASS watcher will rebuild on save.
      # """)
    end

    defp application_path() do
      :ex_uikit |> :code.priv_dir() |> Path.join("templates/app.scss.eex")
    end

    defp add_watcher(file) do
      String.replace(file, "watchers: [", """
      watchers: [
        sass: {DartSass, :install_and_run,
          [:default, ~w(--embed-source-map --source-map --watch)]},
      """)
    end
  end
else
  defmodule Mix.Tasks.ExUikit.Install do
    @shortdoc "#{__MODULE__.Docs.short_doc()} | Install `igniter` to use"

    @moduledoc __MODULE__.Docs.long_doc()

    use Mix.Task

    @impl Mix.Task
    def run(_argv) do
      Mix.shell().error("""
      The task 'ex_uikit.install' requires igniter. Please install igniter and try again.

      For more information, see: https://hexdocs.pm/igniter/readme.html#installation
      """)

      exit({:shutdown, 1})
    end
  end
end
