# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    default_release: :default,
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html

environment :prod do
  set include_erts: true
  set include_src: false
  set include_system_libs: true
  set cookie: :"AXs2V:|,WkBC3c?XFy5=(g[_OOV_4&FW*XW*`?V!vHhl3Bi@8A{vE4JDKe%@ldOv"
end

release :ptr do
  set version: current_version(:ptr)
  set applications: [
    :runtime_tools
  ]
end
