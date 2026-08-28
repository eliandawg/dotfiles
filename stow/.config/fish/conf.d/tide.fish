# tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Compact --icons='Few icons' --transient=No

# [prompt]
set --global tide_left_prompt_items context pwd git newline character
set --global tide_right_prompt_items status cmd_duration jobs direnv bun node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig

# [character]
set --global tide_character_icon ">"
set --global tide_character_vi_icon_default "<"
set --global tide_character_vi_icon_visual v
set --global tide_character_vi_icon_replace x

# [context]
set --global tide_context_always_display true

# [python]
set --global tide_python_icon py
