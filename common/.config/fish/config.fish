set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_add_path $HOME/bin
    fish_add_path $HOME/.local/bin
    fish_add_path /opt/homebrew/bin
end

