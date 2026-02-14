export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export XKB_DEFAULT_LAYOUT="de"
export EDITOR="nvim"

export HISTFILE="${XDG_STATE_HOME}/zsh/history"

# Dev-Tools
export PICO_SDK_PATH="${XDG_DATA_HOME}/pico-sdk/sdk/2.1.1"
export GOPATH="${XDG_DATA_HOME}/go"
export GOMODCACHE="${GOPATH}/pkg/mod"

export PATH="${PATH}:${HOME}/.local/bin"

export QT_SCALE_FACTOR=1
export WINIT_X11_SCALE_FACTOR=1
. "/home/cmk/.local/share/bob/env/env.sh"
