xrandr --output HDMI-2 --mode 1920x1080 --rate 60 --same-as eDP-1
xsetroot -name "$(uname -r -s)"
export XDG_CURRENT_DESKTOP=X-Generic
systemctl --user start xdg-desktop-portal

flatpak run com.brave.Browser --class=brave &

/usr/bin/kitty --class btop btop &

/usr/bin/kitty --class console &

/usr/bin/kitty --class neovim nvim ~/projects &

/usr/local/bin/st -c lazygit &

exec /usr/local/bin/dwm
