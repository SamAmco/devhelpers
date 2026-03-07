local wezterm = require 'wezterm'
local config = {}

config.automatically_reload_config = true
config.enable_kitty_keyboard = true
config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = 'Tokyo Night Moon'
-- config.color_scheme = 'Batman'
-- config.color_scheme = 'Catppuccin Macchiato'

config.keys = {
  { key = 'Backspace', mods = 'ALT', action = wezterm.action.SendKey { key = 'w', mods = 'CTRL' } },
  { key = 'Backspace', mods = 'CTRL', action = wezterm.action.SendString '\x15' },
  {
    key = '%',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal {},
  },
  {
    key = '_',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical {},
  },
  { key = 's', mods = 'ALT', action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES' } },
  { key = 's', mods = 'CTRL|SHIFT', action = wezterm.action.PromptInputLine {
    description = 'Enter new workspace name',
    action = wezterm.action_callback(function(window, pane, line)
      if line then
        window:perform_action(wezterm.action.SwitchToWorkspace { name = line }, pane)
      end
    end),
  }},
  { key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = wezterm.action.ActivateTab(8) },
  { key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'h', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },
}

local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config
