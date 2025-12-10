export SSH_AUTH_SOCK

export ALL_PROXY=127.0.0.1:1080
export NO_PROXY="localhost,127.0.0.1,::1"

export CARGO_HOME=$HOME/.cargo
export PNPM_HOME="$HOME/.local/share/pnpm"
export RUSTUP_DIST_SERVER=https://rsproxy.cn
export RUSTUP_UPDATE_ROOT=https://rsproxy.cn/rustup
export RUSTUP_HOME=$HOME/.rustup

export PATH=$PATH:$CARGO_HOME/bin:$HOME/.local/bin

pkill sslocal 2>/dev/null
sslocal -c ~/.config/shadowsocks/config.json > ~/.config/shadowsocks/log &

[ "$(tty)" = "/dev/tty1" ] && exec sway
[ "$(tty)" = "/dev/tty2" ] && exec startx
