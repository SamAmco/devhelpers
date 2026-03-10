local wezterm = require("wezterm")
local resurrect_loaded, resurrect = pcall(wezterm.plugin.require, "https://github.com/MLFlexer/resurrect.wezterm")
if not resurrect_loaded then
  wezterm.log_error("resurrect plugin failed to load: " .. tostring(resurrect))
end
local config = {}

config.automatically_reload_config = true
config.enable_kitty_keyboard = true
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 22
config.window_frame = {
  font_size = 18,
}
config.color_scheme = 'Tokyo Night Moon'
config.window_close_confirmation = 'NeverPrompt'
config.audible_bell = 'Disabled'

config.keys = {
  { key = 'Backspace', mods = 'ALT',  action = wezterm.action.SendKey { key = 'w', mods = 'CTRL' } },
  { key = 'Backspace', mods = 'CTRL', action = wezterm.action.SendString '\x15' },
  -- Alt+arrows: move cursor by word
  { key = 'LeftArrow',  mods = 'ALT', action = wezterm.action.SendKey { key = 'b', mods = 'ALT' } },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.SendKey { key = 'f', mods = 'ALT' } },
  -- Ctrl+arrows: move cursor to start/end of line
  { key = 'LeftArrow',  mods = 'CTRL', action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' } },
  { key = 'RightArrow', mods = 'CTRL', action = wezterm.action.SendKey { key = 'e', mods = 'CTRL' } },
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
  {
    key = 's',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new workspace name',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(wezterm.action.SwitchToWorkspace { name = line }, pane)
        end
      end),
    }
  },
  {
    key = 'R',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = 'Rename workspace',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
        end
      end),
    }
  },
  { key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0) },
  { key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1) },
  { key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2) },
  { key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3) },
  { key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4) },
  { key = '6', mods = 'ALT', action = wezterm.action.ActivateTab(5) },
  { key = '7', mods = 'ALT', action = wezterm.action.ActivateTab(6) },
  { key = '8', mods = 'ALT', action = wezterm.action.ActivateTab(7) },
  { key = '9', mods = 'ALT', action = wezterm.action.ActivateTab(8) },
  { key = '[', mods = 'ALT', action = wezterm.action.ActivateTabRelative(-1) },
  { key = ']', mods = 'ALT', action = wezterm.action.ActivateTabRelative(1) },
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.MoveTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.MoveTabRelative(1) },
  { key = 'h', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },
  { key = 'j', mods = 'ALT', action = wezterm.action.ScrollByLine(1) },
  { key = 'k', mods = 'ALT', action = wezterm.action.ScrollByLine(-1) },
  { key = 'e', mods = 'ALT', action = wezterm.action.ScrollByLine(1) },
  { key = 'y', mods = 'ALT', action = wezterm.action.ScrollByLine(-1) },
  { key = 'd', mods = 'ALT', action = wezterm.action.ScrollByPage(0.5) },
  { key = 'u', mods = 'ALT', action = wezterm.action.ScrollByPage(-0.5) },

  {
    key = 't',
    mods = 'ALT',
    action = wezterm.action.PromptInputLine {
      description = 'Rename tab',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          pane:tab():set_title(line)
        end
      end),
    },
  },

  -- save all workspaces
  {
    key = 'w',
    mods = 'ALT',
    action = wezterm.action_callback(function(win, pane)
      if resurrect_loaded then
        resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
      end
    end),
  },
  -- restore workspaces
  {
    key = "r",
    mods = "ALT",
    action = wezterm.action_callback(function(win, pane)
      if not resurrect_loaded then return end
      resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
        local type = string.match(id, "^([^/]+)") -- match before '/'
        id = string.match(id, "([^/]+)$")         -- match after '/'
        id = string.match(id, "(.+)%..+$")        -- remove file extention
        local opts = {
          window = pane:window(),
          close_open_tabs = true,
          resize_window = false,
          spawn_in_workspace = true,
        }
        if type == "workspace" then
          local state = resurrect.state_manager.load_state(id, "workspace")
          resurrect.workspace_state.restore_workspace(state, opts)
        elseif type == "window" then
          local state = resurrect.state_manager.load_state(id, "window")
          resurrect.window_state.restore_window(pane:window(), state, opts)
        elseif type == "tab" then
          local state = resurrect.state_manager.load_state(id, "tab")
          resurrect.tab_state.restore_tab(pane:tab(), state, opts)
        end
      end)
    end),
  },
}

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)


return config
