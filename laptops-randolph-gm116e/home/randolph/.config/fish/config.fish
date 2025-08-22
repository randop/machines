if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path ~/.local/bin
set -gx TERM xterm-256color
set -gx GPG_TTY (tty)
set fish_greeting
