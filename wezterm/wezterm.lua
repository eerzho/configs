local wezterm = require 'wezterm'

return {
	default_prog = {"/bin/zsh", "-l"},
	default_cwd = os.getenv("HOME") .. "/Documents",

	-- Set color scheme
	color_scheme = "Catppuccin Macchiato",

	-- Font settings
	font = wezterm.font("FiraCode Nerd Font"),
    font_size = 15.0,
    line_height = 1.0, 
    freetype_load_target = "HorizontalLcd", 	

	-- Disable ligatures (fixes != issue)
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

	-- Allow resizing the window manually
	adjust_window_size_when_changing_font_size = false,

	-- Disable window decorations if not needed
	-- Comment this line if you want to be able to resize via edges
	-- window_decorations = "NONE",

	-- Enable proper glyph rendering for icons
	allow_square_glyphs_to_overflow_width = "Always",

	-- Tab bar settings
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,

	-- Optimize rendering performance
	front_end = "OpenGL",

	-- Keybindings
	keys = {
		-- {key="c", mods="CMD", action=wezterm.action{CopyTo="Clipboard"}},
		-- {key="v", mods="CMD", action=wezterm.action{PasteFrom="Clipboard"}},
	},
}

